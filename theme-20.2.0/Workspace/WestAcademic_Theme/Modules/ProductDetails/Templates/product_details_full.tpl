<div class="product-details-full">
	<div data-cms-area="item_details_banner" data-cms-area-filters="page_type"></div>

	<header class="product-details-full-header">
		<div id="banner-content-top" class="product-details-full-banner-top"></div>
	</header>
	<article class="product-details-full-content" itemscope itemtype="https://schema.org/Product">
		<meta itemprop="url" content="{{itemUrl}}">
		<div id="banner-details-top" class="product-details-full-banner-top-details"></div>

		<section class="product-details-full-main-content">
			<div class="product-details-full-content-header">

				<div data-cms-area="product_details_full_cms_area_1" data-cms-area-filters="page_type"></div>

				<h1 class="product-details-full-content-header-title" itemprop="name">{{model.item.custitem_long_title}}</h1>
				<div class="product-details-full-rating" data-view="Global.StarRating"></div>
				<div data-cms-area="item_info" data-cms-area-filters="path"></div>

			</div>
			<div class="product-details-full-main-content-left">
				<div class="product-details-full-image-gallery-container">
					<div id="banner-image-top" class="content-banner banner-image-top"></div>
					<div data-view="Product.ImageGallery"></div>
					<div id="banner-image-bottom" class="content-banner banner-image-bottom"></div>
					{{#if model.item.custitem_scafacultyurl}}
						<a href="{{model.item.custitem_scafacultyurl}}" target="_blank">
							<div class="sca-faculty-link">VIEW ON FACULTY WEBSITE</div>
						</a>
					{{/if}}

					<div data-cms-area="product_details_full_cms_area_2" data-cms-area-filters="path"></div>
					<div data-cms-area="product_details_full_cms_area_3" data-cms-area-filters="page_type"></div>
				</div>
			</div>

			<div class="product-details-full-main-content-right">
				<div class="product-details-full-main">

					{{#if isItemProperlyConfigured}}
					<form id="product-details-full-form" data-action="submit-form" method="POST">

						<section class="product-details-full-info">
							<div id="banner-summary-bottom" class="product-details-full-banner-summary-bottom"></div>
						</section>

						<div data-view="AvailableFormats.Options"></div>
						<section data-view="Product.Options"></section>

						<div data-cms-area="product_details_full_cms_area_4" data-cms-area-filters="path"></div>

						<!--Reenable Out-of-Stock Behavior Test -->
						<!-- 
						<div data-view="Product.Sku"></div>
						<div data-view="Product.Price"></div>
						<div data-view="Quantity.Pricing"></div>
						-->
						<div data-view="Product.Stock.Info"></div>
						

						{{#if isPriceEnabled}}

						<div class="product-details-add-to-cart">
							<div data-view="Quantity"></div>

							<section class="product-details-full-actions">

								<div class="product-details-full-actions-container">
									<div data-view="MainActionView"></div>

								</div>
								<!--<div class="product-details-full-actions-container">
									<div data-view="AddToProductList" class="product-details-full-actions-addtowishlist"></div>

									<div data-view="ProductDetails.AddToQuote" class="product-details-full-actions-addtoquote"></div>
								</div>-->

							</section>
						</div>

						{{/if}}

						<!--<div data-view="SocialSharing.Flyout" class="product-details-full-social-sharing"></div>-->

						<div class="product-details-full-main-bottom-banner">
							<div id="banner-summary-bottom" class="product-details-full-banner-summary-bottom"></div>
						</div>

						<div class="product-details-book-info">
							<div class="product-details-book-info-left">

								{{#if authors}}
								<div class="product-details-book-info-block">
									<b>Author(s)</b><br>
									<!--{{model.item.custitem19}}-->
									{{{authors}}}
								</div>
								{{/if}}

								{{#if model.item.custitembrand}}
								<div class="product-details-book-info-block">
									<b>Imprint</b><br>
									{{model.item.custitembrand}}
								</div>
								{{/if}}

								{{#if model.item.upccode}}
								<div class="product-details-book-info-block">
									<b>ISBN-13</b><br>
									{{model.item.upccode}}
								</div>
								{{/if}}

								{{#if model.item.custitem_subject}}
								<div class="product-details-book-info-block">
									<b>Primary Subject</b><br>
									{{model.item.custitem_subject}}
								</div>
								{{/if}}


							</div>
							<div class="product-details-book-info-right">

								{{#if model.item.custitem_webstore_format}}
								<div class="product-details-book-info-block">
									<b>Format</b><br>
									{{model.item.custitem_webstore_format}}
								</div>
								{{/if}}
								{{#if model.item.custitem1}}
								<div class="product-details-book-info-block">
									<b>Copyright</b><br>
									{{model.item.custitem1}}
								</div>
								{{/if}}

								{{#if model.item.custitem17}}
								<div class="product-details-book-info-block">
									<b>Series</b><br>
									{{model.item.custitem17}}
								</div>
								{{/if}}

							</div>
						</div>
					</form>
					{{else}}
					<div data-view="GlobalViewsMessageView.WronglyConfigureItem"></div>
					{{/if}}

					<div id="banner-details-bottom" class="product-details-full-banner-details-bottom" data-cms-area="item_info_bottom" data-cms-area-filters="page_type"></div>
				</div>
			</div>

			<div class="product-details-full-main-content-side">

				{{#if model.item.custitem_futureeditionurl}}
				<div>
					<a href="{{model.item.custitem_futureeditionurl}}" class="newer-edition-link ">Newer Edition Available »</a>
				</div>

				{{/if}}
				<!--<div data-view="StockDescription"></div>-->
				{{#if showDigitalAccessMessage}}
				<p>Access to digital products is available immediately after completing your purchase. Please visit
				<a href="https://eproducts.westacademic.com/" target="_blank">eproducts.westacademic.com</a> and sign in.
				</p>
				{{/if}}
				{{{model.item.custitem27}}}
				<!--{{{model.item.custitem9}}}-->

				{{#if model.item.custitem59}}
				<!--<div class="product-details-included-with-purchase">

                    <div class="product-details-included-with-purchase-top">
                        <img src="/site/img/devices-icon-black.svg" />
                        <b>Included with<br>your purchase</b>
                    </div>

                    <p>FREE 14-day digital access to this book immediately after purchase</p>
                </div>-->

				<div class="product-details-included-with-purchase">
					<a href="/immediate-online-access" data-toggle="show-in-modal">
						<span class="product-details-included-with-purchase-top">
								<img src="/site/img/laptop-icon-blue.svg">
								<b>Included with<br>your purchase</b>
						</span>

						<span>FREE 14-day digital access to this book immediately after purchase</span>
					</a>
				</div>
				{{/if}}

				<!-- POD Message -->
				{{#if model.item.custitem_print_on_demand_confirm}}
				<div class="product-details-included-with-purchase">
					<p>To purchase the spiralbound Print on Demand version of this book you must purchase the eBook version in this same transaction or have previously purchased the eBook version.  You may only purchase one Print on Demand version of this title. 
					<br><br>
					Print on Demand books may take 2-3 weeks to arrive.
					</p>
				</div>
				{{/if}}

				{{#if model.item.custitem_sas_done}}

				<div class="product-details-included-with-purchase">
					<a href="/study-aids-collection" target="_blank">
						<span class="product-details-included-with-purchase-top">

								<!--<img src="http://3668083-sb1.shop.netsuite.com/core/media/media.nl?id=793912&c=3668083_SB1&h=84c3bb19aba5d940b241" />-->

								<img src="/site/img/devices-icon.svg">

							<b>Also available in the Study Aids Collection</b>
						</span>

						<span>Easy online access to hundreds of study aids to help you succeed in law school.</span>
					</a>
				</div>

				{{/if}}

				{{#if model.item.custitem_display_mpre_link}}
				<!--<a href="/mpre" target="_blank">
                    <img src="/site/images/MPRE_Web_Icon.png">
                </a>-->

				<div class="product-details-included-with-purchase">
					<a href="/Christensens_The_Weekend_MPRE_Complete_Preparation_for_the_MPRE_in_Only_A_Weekends_Ti_9781634604444_" target="_blank">
						<span class="product-details-included-with-purchase-top">

								<!--<img src="http://3668083-sb1.shop.netsuite.com/core/media/media.nl?id=793912&c=3668083_SB1&h=84c3bb19aba5d940b241" />-->

								<img src="/site/img/study-aids-collection/video-icon.svg" width="40">

							<b>New Video Course available</b>
						</span>
						<span>Prepare for the MPRE in only a weeekend's time</span>
					</a>
				</div>
				{{/if}}
			</div>

		</section>

		<div data-cms-area="product_details_full_cms_area_5" data-cms-area-filters="page_type"></div>
		<div data-cms-area="product_details_full_cms_area_6" data-cms-area-filters="path"></div>

		<section data-view="Product.Information"></section>


		<div class="product-details-full-main-description-container">
			<h3>Description</h3>
			<div class="product-details-full-main-description">
				{{{model.item.custitem9}}}
			</div>
		</div>

		<div data-cms-area="product_details_full_cms_area_7" data-cms-area-filters="path"></div>

		<div data-view="ProductReviews.Center"></div>

		<div data-cms-area="product_details_full_cms_area_8" data-cms-area-filters="path"></div>

		<div class="product-details-full-content-related-items">
			<div data-view="Related.Items"></div>
		</div>

		<div class="product-details-full-content-correlated-items">
			<div data-view="Correlated.Items"></div>
		</div>
		<div id="banner-details-bottom" class="content-banner banner-details-bottom" data-cms-area="item_details_banner_bottom" data-cms-area-filters="page_type"></div>
	</article>
</div>



{{!----
Use the following context variables when customizing this template:

	model (Object)
	model.item (Object)
	model.item.internalid (Number)
	model.item.type (String)
	model.quantity (Number)
	model.options (Array)
	model.options.0 (Object)
	model.options.0.cartOptionId (String)
	model.options.0.itemOptionId (String)
	model.options.0.label (String)
	model.options.0.type (String)
	model.location (String)
	model.fulfillmentChoice (String)
	pageHeader (String)
	itemUrl (String)
	isItemProperlyConfigured (Boolean)
	isPriceEnabled (Boolean)

----}}
