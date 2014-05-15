angular.module('app').service 'utilities',  ->
 

 class utilities
  toggle: (list,selectedItems,index) ->
   item = list[index]
   if item?
   
    if item.value?
     item = item.value
    
    if item.name?
     item = item.name
     
    found = false
    if selectedItems? and selectedItems.length?
     for items, n in selectedItems
      if item == items
       found = true
       selectedItems.splice(n,1)
       break;
    else
     selectedItems = []
         
    if !found
     selectedItems.push item
   
   selectedItems


 return new utilities()
