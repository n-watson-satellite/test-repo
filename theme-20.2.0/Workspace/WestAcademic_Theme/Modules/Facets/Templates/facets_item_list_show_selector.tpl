<select data-type="navigator" class="facets-item-list-show-selector" aria-label="Select the number of results to be displayed per page">
	{{#each options}}
	<option value="{{configOptionUrl}}" class="{{className}}" {{#if isSelected}} selected="" {{/if}} >{{name}}</option>
	{{/each}}
</select>




{{!----
Use the following context variables when customizing this template: 
	
	options (Array)

----}}
