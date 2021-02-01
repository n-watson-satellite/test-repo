/* jshint node: true */
/*jshint esversion: 6 */

let request = require('request');
const through = require('through2');
const Progress = require('progress');
const path = require('path');
const { Spinner } = require('cli-spinner');
const fs = require('fs');
const url = require('url');
const args = require('yargs').argv;
const Uploader = require('ns-uploader');
const inquirer = require('inquirer');
const package_manager = require('../package-manager');

if (args.proxy) {
    request = request.defaults({ proxy: args.proxy });
}

function getAuthorizationHeader(deploy) {
    return (
        'NLAuth nlauth_account=' +
        deploy.info.account +
        ', ' +
        'nlauth_email=' +
        deploy.info.email +
        ', ' +
        'nlauth_signature=' +
        encodeURIComponent(deploy.info.password) +
        ', ' +
        'nlauth_role=' +
        deploy.info.role
    );
}

const net_module = {
    getConfigurationForDomain: function(deploy, cb) {
        const requestUrl = url.format({
            protocol: 'https',
            hostname: deploy.info.hostname,
            pathname: '/app/site/hosting/restlet.nl',
            query: {
                script: deploy.info.script,
                deploy: deploy.info.deploy,
                t: Date.now(),
                get: 'domain-configuration',
                website: deploy.info.website,
                domain: deploy.info.domain,
                folderId: deploy.info.target_folder
            }
        });

        request.get(
            requestUrl,
            {
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: getAuthorizationHeader(deploy),
                    'User-Agent': deploy.info.user_agent
                },
                rejectUnauthorized: false
            },
            function(err, request, response_body) {
                if (err) {
                    err.message = 'Error in GET ' + requestUrl + ': ' + err.message;
                    cb(err);
                } else {
                    try {
                        const response = JSON.parse(response_body);

                        if (response.error) {
                            if (typeof response.error !== 'object') {
                                response.error = JSON.parse(response.error);
                            }
                            console.log(
                                'Error',
                                response.error.code,
                                response.error.message
                                    ? response.error.message
                                    : response.error.details
                            );
                            cb(new Error(response.error.message));
                        } else if (!response.domainUnmanagedFolder) {
                            deploy.domainUnmanagedFolderConfigDontExists = true; // so then we know we need to save the folder in the config
                            inquirer
                                .prompt([
                                    {
                                        type: 'input',
                                        name: 'domainUnmanagedFolder',
                                        message:
                                            'Please, give a name to the folder to deploy your files',
                                        default: (deploy.info.domain + '').replace(/\./g, '_'),
                                        validate: function(input) {
                                            if ((input + '').match(/^[\w\d_]+$/i)) {
                                                return true;
                                            }
                                            return 'Invalid folder name - can only contain ';
                                        }
                                    }
                                ])
                                .then(function(answers) {
                                    deploy.info.domainUnmanagedFolder =
                                        answers.domainUnmanagedFolder;
                                    cb(null, deploy);
                                });

                            // TODO: save deploy.info.domainUnmanagedFolder in back in config record
                        } else {
                            deploy.info.domainUnmanagedFolder = response.domainUnmanagedFolder;
                            cb(null, deploy);
                        }
                    } catch (e) {
                        cb(
                            new Error(
                                'Error parsing response:\n' +
                                    response_body +
                                    ' - ' +
                                    JSON.stringify(e) +
                                    ' - ' +
                                    e.stack
                            )
                        );
                    }
                }
            }
        );
    },

    writeConfig: function(deploy, cb) {
        if (!deploy.domainUnmanagedFolderConfigDontExists) {
            cb(null, deploy);
        } else {
            const requestUrl = url.format({
                protocol: 'https',
                hostname: deploy.info.hostname,
                pathname: '/app/site/hosting/restlet.nl',
                query: {
                    script: deploy.info.script,
                    deploy: deploy.info.deploy,
                    t: Date.now()
                }
            });

            request.put(
                requestUrl,
                {
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: getAuthorizationHeader(deploy),
                        'User-Agent': deploy.info.user_agent
                    },
                    rejectUnauthorized: false,
                    body: JSON.stringify({
                        saveConfiguration: true,
                        unmanagedResourcesFolderName: deploy.info.domainUnmanagedFolder,
                        website: deploy.info.website,
                        domain: deploy.info.domain,
                        folderId: deploy.info.target_folder
                    })
                },
                function(err, request, response_body) {
                    if (err) {
                        err.message = 'Error in GET ' + requestUrl + ': ' + err.message;
                        cb(err);
                    } else {
                        try {
                            const response = JSON.parse(response_body) || {};

                            if (response.error) {
                                console.log('Error', response.error.code, response.error.message);
                                cb(new Error(response.error.message));
                            } else {
                                cb(null, deploy);
                            }
                        } catch (e) {
                            const errorMsg =
                                'Error parsing response:\n' +
                                response_body +
                                ' - ' +
                                JSON.stringify(e) +
                                ' - ' +
                                e.stack;
                            cb(new Error(errorMsg));
                        }
                    }
                }
            );
        }
    },

    getWebsitesAndDomains: function(deploy, cb) {
        const requestUrl = url.format({
            protocol: 'https',
            hostname: deploy.info.hostname,
            pathname: '/app/site/hosting/restlet.nl',
            query: {
                script: deploy.info.script,
                deploy: deploy.info.deploy,
                t: Date.now(),
                get: 'list-websites'
            }
        });

        request.get(
            requestUrl,
            {
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: getAuthorizationHeader(deploy),
                    'User-Agent': deploy.info.user_agent
                },
                rejectUnauthorized: false
            },
            function(err, request, response_body) {
                if (err) {
                    err.message = 'Error in GET ' + requestUrl + ': ' + err.message;
                    cb(err);
                } else {
                    try {
                        const response = JSON.parse(response_body);

                        if (response.error) {
                            console.log('Error', response.error.code, response.error.message);
                            cb(new Error(response.error.message));
                        } else {
                            deploy.websitesAndDomains = response;
                            cb(null, deploy);
                        }
                    } catch (e) {
                        cb(new Error('Error parsing response:\n' + response_body));
                    }
                }
            }
        );
    },

    rollback: function(deploy, cb) {
        if (!deploy.rollback_revision) {
            cb(new Error('No backup selected'));
        } else {
            request.put(
                url.format({
                    protocol: 'https',
                    hostname: deploy.info.hostname,
                    pathname: '/app/site/hosting/restlet.nl',
                    query: {
                        script: deploy.info.script,
                        deploy: deploy.info.deploy,
                        t: Date.now()
                    }
                }),
                {
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: getAuthorizationHeader(deploy),
                        'User-Agent': deploy.info.user_agent
                    },
                    rejectUnauthorized: false,
                    body: JSON.stringify({ rollback_to: deploy.rollback_revision.file_id })
                },
                function() {
                    cb(null, deploy);
                }
            );
        }
    },

    getVersions: function(deploy, cb) {
        if (deploy.revisions) {
            cb(null, deploy);
        } else {
            const requestUrl = url.format({
                protocol: 'https',
                hostname: deploy.info.hostname,
                pathname: '/app/site/hosting/restlet.nl',
                query: {
                    script: deploy.info.script,
                    deploy: deploy.info.deploy,
                    t: Date.now(),
                    get: 'revisions',
                    target_folder: deploy.info.target_folder
                }
            });

            request.get(
                requestUrl,
                {
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: getAuthorizationHeader(deploy),
                        'User-Agent': deploy.info.user_agent
                    },
                    rejectUnauthorized: false
                },
                function(err, request, response_body) {
                    if (err) {
                        err.message = 'Error in GET ' + requestUrl + ': ' + err.message;
                        cb(err);
                    } else {
                        const response = JSON.parse(response_body);
                        if (response.error) {
                            cb(new Error(response.error.message));
                        } else {
                            deploy.revisions = response;
                            cb(null, deploy);
                        }
                    }
                }
            );
        }
    },

    roles: function(deploy, cb) {
        if (deploy.info.email && deploy.info.password) {
            let host = deploy.options.molecule
                ? 'https://rest.' + deploy.options.molecule + '.netsuite.com'
                : 'https://rest.netsuite.com';

            // if VM address is specified in --vm parameter, use it instead
            if (args.vm) {
                host = args.vm;
            }

            const requestUrl = host + '/rest/roles';

            request.get(
                requestUrl,
                {
                    headers: {
                        Accept: '*/*',
                        'Accept-Language': 'en-us',
                        Authorization:
                            'NLAuth nlauth_email=' +
                            deploy.info.email +
                            ', nlauth_signature=' +
                            encodeURIComponent(deploy.info.password),
                        'User-Agent': deploy.info.user_agent
                    },
                    rejectUnauthorized: false
                },
                function(err, request, response_body) {
                    if (err) {
                        err.message = 'Error in GET ' + requestUrl + ': ' + err.message;
                        return cb(err);
                    }
                    const response = JSON.parse(response_body);

                    if (response.error) {
                        const error = new Error(response.error.message);
                        error.type = 'NETWORK_ROLES_ERROR';
                        return cb(error);
                    }

                    deploy.roles = response;
                    cb(null, deploy);
                }
            );
        } else {
            const error = new Error('Missing email and password');
            error.type = 'MISSING_EMAIL_OR_PASSWORD';
            cb(error);
        }
    },

    targetFolder: function(deploy, cb) {
        if (deploy.target_folders) {
            cb(null, deploy);
        } else {
            const requestUrl = url.format({
                protocol: 'https',
                hostname: deploy.info.hostname,
                pathname: '/app/site/hosting/restlet.nl',
                query: {
                    script: deploy.info.script,
                    deploy: deploy.info.deploy,
                    t: Date.now(),
                    get: 'target-folders'
                }
            });

            request.get(
                requestUrl,
                {
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: getAuthorizationHeader(deploy),
                        'User-Agent': deploy.info.user_agent
                    },
                    rejectUnauthorized: false
                },
                function(err, request, response_body) {
                    if (err) {
                        err.message = 'Error in GET ' + requestUrl + ': ' + err.message;
                        cb(err);
                    } else {
                        const invalid_scriptlet_id_msg =
                            'Please make sure the selected account/molecule have the "' +
                            deploy.options.distroName +
                            '" bundle installed.';
                        try {
                            const response = JSON.parse(response_body);

                            if (response.error) {
                                if (response.error.code === 'SSS_INVALID_SCRIPTLET_ID') {
                                    console.log(
                                        'Error: Deployment scriptlet not found, aborting. \n' +
                                            invalid_scriptlet_id_msg
                                    );
                                    process.exit(1);
                                } else {
                                    console.log(
                                        'Error',
                                        response.error.code,
                                        response.error.message
                                    );
                                    if (response.error.code === 'USER_ERROR') {
                                        console.log(
                                            'Please check you are pointing to the right molecule/datacenter using the -m argument.'
                                        );
                                    }
                                    cb(new Error(response.error.message));
                                }
                            } else {
                                deploy.target_folders = response;
                                cb(null, deploy);
                            }
                        } catch (e) {
                            cb(
                                new Error(
                                    'Error parsing response:\n' +
                                        response_body +
                                        '\n\n' +
                                        invalid_scriptlet_id_msg
                                )
                            );
                        }
                    }
                }
            );
        }
    },

    // @method ensureTargetFolder for sclite we only upload the contents of the
    // /tmp folder into the target site folder (info.target_folder). we need to:
    // 1) see if it exists
    // 2) if not, create it.
    // 3) assign info.target_folder to the target folder id.
    ensureTargetFolder: function(deploy, cb) {
        const { folderName, parentId } = deploy.info.target_folder;
        const uploader = net_module.getUploader(deploy);

        // we get or create the 'folderName' folder
        uploader
            .getFolderNamed(parentId, folderName)
            .then(async function(folder) {
                if (!folder) {
                    return uploader.mkdir(parentId, folderName);
                }
                return folder.$;
            })
            // we get or create the site/something folder
            .then(function(folderRef) {
                deploy.info.target_folder = folderRef.internalId;
                cb(null, deploy);
            })
            .catch(cb);
    },

    uploadBackup: function(deploy, cb) {
        const spinner = new Spinner('Uploading backup');
        spinner.start();
        net_module.uploader
            .mkdir(deploy.info.target_folder, 'backup')
            .then(function(recordRef) {
                const sourceFolderPath = path.join(
                    package_manager.distro.folders.deploy,
                    '_Sources'
                );
                if (!fs.existsSync(sourceFolderPath)) {
                    spinner.stop();
                    cb(null, deploy);
                    return;
                }

                net_module.uploader
                    .main({
                        targetFolderId: recordRef.internalId,
                        sourceFolderPath: sourceFolderPath
                    })
                    .then(function() {
                        spinner.stop();
                        cb(null, deploy);
                    })
                    .catch(function(err) {
                        console.log(err, err.stack);
                        cb(err);
                    });
            })
            .catch(function(err) {
                console.log(err, err.stack);
                cb(err);
            });
    },

    getUploader: function(deploy) {
        if (!net_module.uploader) {
            const credentials = {
                email: deploy.info.email,
                password: deploy.info.password,
                roleId: deploy.info.role,
                account: deploy.info.account,
                user_agent: deploy.info.user_agent || undefined,
                molecule: args.m || undefined,
                nsVersion: args.nsVersion || undefined,
                applicationId: args.applicationId || undefined,
                vm: args.vm || undefined
            };
            const uploader = new Uploader(credentials);
            net_module.uploader = uploader;
        }
        return net_module.uploader;
    },

    getManifest: function(deploy, cb){
        const manifestName = '__ns-uploader-manifest__.json';
        request.get(
            url.format({
                protocol: 'https',
                hostname: deploy.info.hostname,
                pathname: '/app/site/hosting/restlet.nl',
                query: {
                    script: deploy.info.script,
                    deploy: deploy.info.deploy,
                    fileName: manifestName,
                    targetFolder: deploy.info.target_folder,
                    t: Date.now(),
                    get: 'getFile'
                }
            }),
            {
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: getAuthorizationHeader(deploy)
                },
                rejectUnauthorized: false
            },
            function(err, request, response_body) {
                try {
                    if (err) {
                        return cb(new Error('Response error: ' + err), deploy);
                    }

                    deploy.uploadManifest = { name: manifestName, data: JSON.parse(response_body) };
                    cb(null, deploy);
                } catch (e) {
                    cb(
                        new Error(
                            'Error parsing response:\n' +
                            response_body +
                            '\n\n' +
                            'Please make sure that:\n' +
                            '- You uploaded all files in RestLet folder to a location in your account.\n' +
                            '- You have a restlet script pointing to sca_deployer.js with id customscript_sca_deployer and deployment with id customdeploy_sca_deployer\n' +
                            '- You have set the get, post, put, delete methods to _get, _post, _put, _delete respectively in the script.\n' +
                            '- You have added the Deployment.js and FileCabinet.js scripts to the script libraries.'
                        )
                    );
                }
            }
        );
    },

    postFiles: function(deploy, cb) {
        const t0 = new Date().getTime();
        const payload_path = path.join(process.gulp_init_cwd, 'payload.json');
        const { options } = deploy;

        fs.stat(payload_path, function(err, stat) {
            if (err) {
                return cb(err);
            }

            const spinner = new Spinner('Processing');
            const bar = new Progress(`Uploading Chunk ${options.chunksNumber}/${options.chunksTotal} [:bar] :percent`, {
                complete: '=',
                incomplete: ' ',
                width: 50,
                total: stat.size,
                callback: function() {
                    spinner.start();
                }
            });

            fs.createReadStream(payload_path)
                .pipe(
                    through(function(buff, type, cb2) {
                        bar.tick(buff.length);
                        this.push(buff);
                        return cb2();
                    })
                )
                .pipe(
                    request.post(
                        url.format({
                            protocol: 'https',
                            hostname: deploy.info.hostname,
                            pathname: '/app/site/hosting/restlet.nl',
                            query: {
                                script: deploy.info.script,
                                deploy: deploy.info.deploy
                            }
                        }),
                        {
                            headers: {
                                'Content-Type': 'application/json',
                                Authorization: getAuthorizationHeader(deploy)
                            },
                            rejectUnauthorized: false
                        },
                        function(err, request, response_body) {
                            try {
                                if (typeof spinner !== 'undefined') {
                                    spinner.stop();
                                }

                                if (typeof process.stdout.clearLine === 'function') {
                                    process.stdout.clearLine();
                                }

                                if (typeof process.stdout.cursorTo === 'function') {
                                    process.stdout.cursorTo(0);
                                }

                                if (err) {
                                    cb(new Error('Response error: ' + err), deploy);
                                } else {
                                    const result = JSON.parse(response_body);
                                    let took = (new Date().getTime() - t0) / 1000 / 60 + '';

                                    took = took.substring(0, Math.min(4, took.length)) + ' minutes';

                                    deploy.result = result;
                                    cb(null, deploy);
                                }
                            } catch (e) {
                                cb(
                                    new Error(
                                        'Error parsing response:\n' +
                                            response_body +
                                            '\n\n' +
                                            'Please make sure that:\n' +
                                            '- You uploaded all files in RestLet folder to a location in your account.\n' +
                                            '- You have a restlet script pointing to sca_deployer.js with id customscript_sca_deployer and deployment with id customdeploy_sca_deployer\n' +
                                            '- You have set the get, post, put, delete methods to _get, _post, _put, _delete respectively in the script.\n' +
                                            '- You have added the Deployment.js and FileCabinet.js scripts to the script libraries.'
                                    )
                                );
                            }
                        }
                    )
                );
        });
    }
};

module.exports = net_module;
