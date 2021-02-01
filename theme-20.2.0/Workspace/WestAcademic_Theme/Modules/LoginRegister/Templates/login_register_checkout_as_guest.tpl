
<!--{{#unless hideRegister}}

<div class="login-register-checkout-as-guest-register-header collapse in" id="register-show-view">
	<p class="login-register-checkout-as-guest-description">
		{{translate 'Create a West Academic account and you will receive FREE shipping on all orders placed using that account.'}}
	</p>
	&lt;!&ndash;<button class="login-register-checkout-as-guest-button-show" data-toggle="collapse" data-target="#register-show-view,#register-view">
		{{translate 'Create Account'}}
	</button>&ndash;&gt;

	<div class="login-register-register-form-controls-group">
		<button class="login-register-register-form-submit" onclick="window.location.href = 'https://signin.westacademic.com/Registration/WizardStep1?ReturnUrl=http://www.westacademic.com/autoSignIn=true&signInUrl=https://signin.westacademic.com/SAML/NetSuiteSSO?isStore=true';">
			{{translate 'Create Account'}}
		</button>
	</div>

</div>
{{/unless}}-->

<div class="login-register-checkout-as-guest-header collapse {{#unless hideRegister}}in{{/unless}}" id="guest-show-view">

	<p class="login-register-checkout-as-guest-description">
		{{translate 'Checkout as a guest and you will have an opportunity to create an account when you are finished.'}}
	</p>
	{{#if expandGuestUserEnabled}}
	<button href="#" class="login-register-checkout-as-guest-button-show" data-toggle="collapse" data-target="#guest-show-view,#guest-view">
		{{translate 'Checkout as a Guest'}}
	</button>
	<p class="login-register-checkout-as-guest-description"> 
		<span style="font-weight: bold;">Please note:</span> All digital products, including the immediate 14-day online access for most casebooks, will require you to create an account or sign in. 
	</p>
	{{else}}
	<form class="login-register-checkout-as-guest-form" method="POST" novalidate>
		<div class="login-register-checkout-as-guest-control-group">
			<button type="submit" class="login-register-checkout-as-guest-submit">
				{{translate 'Checkout as a Guest'}}
			</button>
		</div>
	</form>
	{{/if}}
</div>
<div class="login-register-checkout-as-guest-body collapse {{#if hideRegister}}in{{/if}}" id="guest-view">
	<p class="login-register-checkout-as-guest-description">
		{{#if hideRegister}}
		{{translate 'Checkout as a Guest'}}
		{{else}}
		{{translate 'Checkout as a guest and you will have an opportunity to create an account when you are finished.'}}
		{{/if}}
	</p>
	<form class="login-register-checkout-as-guest-form" method="POST" novalidate>

		{{#if showGuestFirstandLastname}}
		<div class="login-register-checkout-as-guest-control-group" data-validation="control-group">
			<label class="login-register-checkout-as-guest-control-label" for="guest-firstname">
				{{translate 'First Name <small class="login-register-checkout-as-guest-required">*</small>'}}
			</label>
			<div class="login-register-checkout-as-guest-controls" data-validation="control">
				<input type="text" name="firstname" id="guest-firstname" class="login-register-checkout-as-guest-input">
			</div>
		</div>

		<div class="login-register-checkout-as-guest-control-group" data-validation="control-group">
			<label class="login-register-checkout-as-guest-control-label" for="guest-lastname">
				{{translate 'Last Name <small class="login-register-checkout-as-guest-required">*</small>'}}
			</label>
			<div class="login-register-checkout-as-guest-controls" data-validation="control">
				<input type="text" name="lastname" id="guest-lastname" class="login-register-checkout-as-guest-input">
			</div>
		</div>
		{{/if}}

		{{#if isRedirect}}
		<div class="login-register-checkout-as-guest-form-controls-group" data-validation="control-group">
			<div class="login-register-checkout-as-guest-register-form-controls" data-validation="control">
				<input value="true" type="hidden" name="redirect" id="redirect" >
			</div>
		</div>
		{{/if}}

		{{#if showGuestEmail}}
		<div class="login-register-checkout-as-guest-control-group" data-validation="control-group">
			<label class="login-register-checkout-as-guest-control-label" for="guest-email">
				{{translate 'Email Address <small class="login-register-checkout-as-guest-required">*</small>'}}
			</label>
			<div class="login-register-checkout-as-guest-controls" data-validation="control">
				<input type="email" name="email" id="guest-email" class="login-register-checkout-as-guest-input" placeholder="{{translate 'your@email.com'}}" value="">
				<p class="login-register-checkout-as-guest-help-block">
					<small>{{translate 'We need your email address to contact you about your order.'}}</small>
				</p>
			</div>
		</div>
		{{/if}}

		<div class="login-register-checkout-as-guest-form-messages" data-type="alert-placeholder"></div>

		<div class="login-register-checkout-as-guest-control-group">
			<button type="submit" class="login-register-checkout-as-guest-submit">
				{{translate 'Proceed to Checkout'}}
			</button>
		</div>
	</form>
</div>





{{!----
Use the following context variables when customizing this template: 
	
	isRedirect (Boolean)
	hideRegister (Boolean)
	showGuestFirstandLastname (Boolean)
	showGuestEmail (Boolean)
	expandGuestUserEnabled (Boolean)

----}}
