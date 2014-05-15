angular.module('app').service 'productCategoryList', ['dropdownFromJson', (dropdownFromJson) ->
  
 _items = new dropdownFromJson('listdata/productCategories.json')
 
 return _items
]