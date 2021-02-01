{{log this}}

<section class="item-relations">
    <p>Available formats:</p>
    <div class="item-format-tiles">

        {{#each formatTiles}}
            {{#if itemUrl}}<a class="item-format-tile" href="{{itemUrl}}">{{else}}<div class="item-format-tile-selected">{{/if}}
                <span>
                    {{format}}
                </span>
                <b class="item-format-price">
                    {{itemPrice}}
                </b>
        {{#if itemUrl}}</a>{{else}}</div> {{/if}}
        {{/each}}

    </div>
</section>


<!--
  Available helpers:
  {{ getExtensionAssetsPath "img/image.jpg"}} - reference assets in your extension
  
  {{ getExtensionAssetsPathWithDefault context_var "img/image.jpg"}} - use context_var value i.e. configuration variable. If it does not exist, fallback to an asset from the extension assets folder
  
  {{ getThemeAssetsPath context_var "img/image.jpg"}} - reference assets in the active theme
  
  {{ getThemeAssetsPathWithDefault context_var "img/theme-image.jpg"}} - use context_var value i.e. configuration variable. If it does not exist, fallback to an asset from the theme assets folder
-->