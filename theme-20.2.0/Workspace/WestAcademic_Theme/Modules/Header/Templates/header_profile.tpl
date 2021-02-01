{{#if showExtendedMenu}}
	<!--<a class="header-profile-welcome-link" href="#" data-toggle="dropdown">
		<i class="header-profile-welcome-user-icon"></i>
		{{translate 'Welcome <strong class="header-profile-welcome-link-name">$(0)</strong>' displayName}}
		<i class="header-profile-welcome-carret-icon"></i>
	</a>

	{{#if showMyAccountMenu}}
		<ul class="header-profile-menu-myaccount-container">
			<li data-view="Header.Menu.MyAccount"></li>
		</ul>
	{{/if}}-->

<a class="header-profile-login-link" data-touchpoint="customercenter" data-hashtag="overview" href="#">
	<!--<i class="header-profile-login-icon"></i>-->

	<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 24 24" style="enable-background:new 0 0 24 24;" xml:space="preserve">
<path d="M12,0C5.4,0,0,5.4,0,12s5.4,12,12,12s12-5.4,12-12S18.6,0,12,0z M19.8,18.3c-0.3-0.6-0.8-1-1.9-1.2c-2.3-0.5-4.4-1-3.4-2.9
	C17.6,8.2,15.3,5,12,5c-3.4,0-5.6,3.3-2.5,9.1c1.1,2-1.1,2.4-3.4,2.9c-1.1,0.2-1.6,0.7-1.9,1.2C2.8,16.6,2,14.4,2,12
	C2,6.5,6.5,2,12,2s10,4.5,10,10C22,14.4,21.2,16.6,19.8,18.3z"/>
</svg>

	<span>{{translate 'my account'}}</span>
</a>

{{else}}

	{{#if showLoginMenu}}
		{{#if showLogin}}
			<div class="header-profile-menu-login-container">
				<ul class="header-profile-menu-login">
					<li>
						<a class="header-profile-login-link" data-touchpoint="login" data-hashtag="login-register" href="#">
							<!--<i class="header-profile-login-icon"></i>-->

							<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 24 24" style="enable-background:new 0 0 24 24;" xml:space="preserve">
<path d="M12,0C5.4,0,0,5.4,0,12s5.4,12,12,12s12-5.4,12-12S18.6,0,12,0z M19.8,18.3c-0.3-0.6-0.8-1-1.9-1.2c-2.3-0.5-4.4-1-3.4-2.9
	C17.6,8.2,15.3,5,12,5c-3.4,0-5.6,3.3-2.5,9.1c1.1,2-1.1,2.4-3.4,2.9c-1.1,0.2-1.6,0.7-1.9,1.2C2.8,16.6,2,14.4,2,12
	C2,6.5,6.5,2,12,2s10,4.5,10,10C22,14.4,21.2,16.6,19.8,18.3z"/>
</svg>

							<span>{{translate 'sign in'}}</span>
						</a>
					</li>
					<!--{{#if showRegister}}
						<li> | </li>
						<li>
							<a class="header-profile-register-link" data-touchpoint="register" data-hashtag="login-register" href="#">
								{{translate 'Register'}}
							</a>
						</li>
					{{/if}}-->
				</ul>
			</div>
		{{/if}}
	{{else}}
		<a class="header-profile-loading-link">
			<i class="header-profile-loading-icon"></i>
			<span class="header-profile-loading-indicator"></span>
		</a>
	{{/if}}

{{/if}}



{{!----
Use the following context variables when customizing this template:

	showExtendedMenu (Boolean)
	showLoginMenu (Boolean)
	showLoadingMenu (Boolean)
	showMyAccountMenu (Boolean)
	displayName (String)
	showLogin (Boolean)
	showRegister (Boolean)

----}}
