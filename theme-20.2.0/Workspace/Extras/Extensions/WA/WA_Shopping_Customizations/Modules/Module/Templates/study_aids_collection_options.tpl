<div class="study-aids-collection-buy-box">
    <div class="study-aids-collection-options">
        <label for="study-aids-collection-options">subscription length</label>
        <select data-action="select-studyaids-item" id="study-aids-collection-options">
            {{#each studyAidsCollectionItems}}
            <option value="{{internalId}}" {{#ifEquals internalId ../selectedItem.internalId}}selected{{/ifEquals}}>{{duration}}</option>
            {{/each}}
        </select>
    </div>
    <div class="subscription-price-block">
        <label>total cost</label>

        <div class="subscription-price">
            {{#if selectedItem.priceFormatted}}
            ${{selectedItem.price}}

            {{else}}
            $30
            {{/if}}
        </div>

    </div>
    <div class="study-aids-collection-buy">
        <button class="button-large button-primary" data-action="buy-subscription" data-item-id="{{selectedItem.internalId}}">Add to Cart</button>
        <a href="https://subscription.westacademic.com/free-trial" target="_blank" class="free-trial-button">Free 2-day trial</a>
    </div>
</div>

