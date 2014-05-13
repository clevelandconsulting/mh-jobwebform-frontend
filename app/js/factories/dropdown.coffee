angular.module('app').factory 'dropdown', ->
 class dropDown
  constructor: ->
   @items = []
  
  add: (name, value) ->
   if name?
    if !value? 
     value = name
    
    obj = {name: name, value: value}
    @items.push obj
   
  gangByCount: (count) ->
   items = []
   gangItems = []
   
   for item, i in @items
    gangItems.push(item)
    
    if (i+1) % 3 == 0
     items.push gangItems
     gangItems = []
   
   if gangItems.length > 0
    items.push gangItems
   
   items
  