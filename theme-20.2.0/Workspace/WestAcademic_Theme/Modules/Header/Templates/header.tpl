<div class="header-message" data-view="Message.Placeholder"></div>
<div class="header-promo" data-cms-area="header_banner_top_promo" data-cms-area-filters="global">
	<!--10% off + <b>free shipping for signed in customers!</b>  <a href="#" data-touchpoint="login" data-hashtag="login-register">Create an account</a>-->
</div>

<div class="header-main-wrapper {{#if isStandalone}}header-main-wrapper-standalone{{/if}}">

	<nav class="header-main-nav">
		<div id="banner-header-top" class="content-banner banner-header-top" data-cms-area="header_banner_top" data-cms-area-filters="global"></div>
		<div class="header-sidebar-toggle-wrapper">
			<button class="header-sidebar-toggle" data-action="header-sidebar-show">
				<i class="header-sidebar-toggle-icon"></i>
			</button>
		</div>
		<div class="header-content">
			<div class="header-logo-wrapper">
				<div data-view="Header.Logo"></div>
			</div>

			<div class="header-content-middle">
				<ul class="header-secondary-navigation">
				    <li><a href="https://faculty.westacademic.com/" target="_blank">Faculty</a></li>
					<li><a href="/students" data-hashtag="/students" data-touchpoint="home">Students</a></li>
					<li><a href="/librarians" data-hashtag="/librarians" data-touchpoint="home">Librarians</a></li>
					<li><a href="/legal-professionals" data-hashtag="/legal-professionals" data-touchpoint="home">Legal professionals</a></li>
					<li><a href="https://reseller.westacademic.com/" target="_blank">Bookstores</a></li>
				</ul>

				<div data-view="SiteSearch"></div>
			</div>


			<div class="header-right-menu">
				<div class="header-menu-profile" data-view="Header.Profile"></div>
				<div class="header-menu-profile">
   					<div class="header-profile-menu-login-container">
					   <ul class="header-profile-menu-login">
					   		<li>
					   			<a class="header-profile-login-link" target="_blank" href="https://faculty.westacademic.com">
									<img style="height: 28px" src="/site/img/WAapple.png" alt="West Academic"> 
									<span>faculty</span></a>
							</li>
						</ul>
					</div>
				</div>  
				{{#unless isStandalone}}
				<!--<div class="header-menu-searchmobile" data-view="SiteSearch.Button"></div>-->
				<div class="header-menu-cart">
					<div class="header-menu-cart-dropdown" >
						<div data-view="Header.MiniCart"></div>
					</div>
				</div>
				{{/unless}}
			</div>
		</div>
		<div id="banner-header-bottom" class="content-banner banner-header-bottom" data-cms-area="header_banner_bottom" data-cms-area-filters="global"></div>
	</nav>

</div>

<div class="header-sidebar-overlay" data-action="header-sidebar-hide"></div>
<div class="header-secondary-wrapper{{#if isStandalone}} header-secondary-wrapper-standalone{{/if}}" data-view="Header.Menu" data-phone-template="header_sidebar" data-tablet-template="header_sidebar"></div>



{{!----
Use the following context variables when customizing this template:

	profileModel (Object)
	profileModel.addresses (Array)
	profileModel.addresses.0 (Array)
	profileModel.creditcards (Array)
	profileModel.firstname (String)
	profileModel.paymentterms (undefined)
	profileModel.phoneinfo (undefined)
	profileModel.middlename (String)
	profileModel.vatregistration (undefined)
	profileModel.creditholdoverride (undefined)
	profileModel.lastname (String)
	profileModel.internalid (String)
	profileModel.addressbook (undefined)
	profileModel.campaignsubscriptions (Array)
	profileModel.isperson (undefined)
	profileModel.balance (undefined)
	profileModel.companyname (undefined)
	profileModel.name (undefined)
	profileModel.emailsubscribe (String)
	profileModel.creditlimit (undefined)
	profileModel.email (String)
	profileModel.isLoggedIn (String)
	profileModel.isRecognized (String)
	profileModel.isGuest (String)
	profileModel.priceLevel (String)
	profileModel.subsidiary (String)
	profileModel.language (String)
	profileModel.currency (Object)
	profileModel.currency.internalid (String)
	profileModel.currency.symbol (String)
	profileModel.currency.currencyname (String)
	profileModel.currency.code (String)
	profileModel.currency.precision (Number)
	showLanguages (Boolean)
	showCurrencies (Boolean)
	showLanguagesOrCurrencies (Boolean)
	showLanguagesAndCurrencies (Boolean)
	isHomeTouchpoint (Boolean)
	cartTouchPoint (String)

----}}
