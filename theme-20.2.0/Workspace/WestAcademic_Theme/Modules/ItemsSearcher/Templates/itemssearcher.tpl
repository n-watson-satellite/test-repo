<input aria-label="Title, Author, ISBN, Series or Keyword" data-type="search-input" class="itemssearcher-input typeahead"
	placeholder="Title, Author, ISBN, Series or Keyword"
	type="search" autocomplete="off"
	{{#if showId}} id="{{id}}" {{/if}} {{#if showName}} name="{{name}}" {{/if}}
	maxlength="{{maxLength}}"/>




{{!----
Use the following context variables when customizing this template: 
	
	placeholderLabel (String)
	maxLength (Number)
	showId (Boolean)
	showName (Boolean)
	id (String)
	name (String)

----}}
