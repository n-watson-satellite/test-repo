<select data-type="navigator" class="facets-item-list-sort-selector" aria-label="Filter By">
	{{#each options}}
	<option value="{{configOptionUrl}}" class="{{className}}" {{#if isSelected}} selected="" {{/if}} >{{translate name}}</option>
	{{/each}}
</select>




{{!----
Use the following context variables when customizing this template: 
	
	options (Array)

----}}
