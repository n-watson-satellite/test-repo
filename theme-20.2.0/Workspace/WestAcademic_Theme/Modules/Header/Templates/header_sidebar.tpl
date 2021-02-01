<div class="header-sidebar-wrapper">
	<div class="header-sidebar-profile-menu" data-view="Header.Profile"></div>

	<div class="header-sidebar-menu-wrapper" data-type="header-sidebar-menu">

		<ul class="header-sidebar-menu">
			<li><a href="https://faculty.westacademic.com/" target="_blank">Faculty</a></li>

		    {{#unless isStandalone}}
			{{#each categories}}
				{{#if text}}
					<li>
						<a {{objectToAtrributes this}} {{#if categories}}data-action="push-menu"{{/if}} name="{{text}}" {{#if @last}} target="_blank"{{/if}}>
							{{text}}
							{{#if categories}}<i class="header-sidebar-menu-push-icon"></i>{{/if}}

						</a>
						{{#if categories}}
							<ul>
								<li>
									<a href="#" class="header-sidebar-menu-back" data-action="pop-menu" name="back-sidebar">
										<i class="header-sidebar-menu-pop-icon"></i>
										{{translate 'Back'}}
									</a>
								</li>

								<li>
									<a {{objectToAtrributes this}}>
										{{translate 'Browse $(0)' text}}
									</a>
								</li>

								{{#each categories}}
								<li>
									<a {{objectToAtrributes this}} {{#if categories}}data-action="push-menu"{{/if}}>
									{{text}}
									{{#if categories}}<i class="header-sidebar-menu-push-icon"></i>{{/if}}
									</a>

									{{#if categories}}
									<ul>
										<li>
											<a href="#" class="header-sidebar-menu-back" data-action="pop-menu">
												<i class="header-sidebar-menu-pop-icon"></i>
												{{translate 'Back'}}
											</a>
										</li>

										<li>
											<a {{objectToAtrributes this}}>
												{{translate 'Browse $(0)' text}}
											</a>
										</li>

										{{#each categories}}
										<li>
											<a {{objectToAtrributes this}} name="{{text}}">{{text}}</a>
										</li>
										{{/each}}
									</ul>
									{{/if}}
								</li>
								{{/each}}
							</ul>
						{{/if}}
					</li>
				{{/if}}
			{{/each}}
			{{/unless}}

			{{#if showExtendedMenu}}
				<li class="header-sidebar-menu-myaccount" data-view="Header.Menu.MyAccount"></li>
			{{/if}}

		</ul>

		<ul class="header-secondary-navigation-mobile">
			<li><a href="/students" data-hashtag="/students" data-touchpoint="home">Students</a></li>
			<li><a href="/librarians" data-hashtag="/librarians" data-touchpoint="home">Librarians</a></li>
			<li><a href="/legal-professionals" data-hashtag="/legal-professionals" data-touchpoint="home">Legal professionals</a></li>
			<li><a href="https://reseller.westacademic.com/" target="_blank">Bookstores</a></li>	
		</ul>

	</div>

	{{#if showExtendedMenu}}
	<a class="header-sidebar-user-logout" href="#" data-touchpoint="logout" name="logout">
		<i class="header-sidebar-user-logout-icon"></i>
		{{translate 'Sign Out'}}
	</a>
	{{/if}}

	{{#if showLanguages}}
	<div data-view="Global.HostSelector"></div>
	{{/if}}
	{{#if showCurrencies}}
	<div data-view="Global.CurrencySelector"></div>
	{{/if}}

</div>



{{!----
Use the following context variables when customizing this template:

	categories (Array)
	showExtendedMenu (Boolean)
	showLanguages (Boolean)
	showCurrencies (Boolean)

----}}
