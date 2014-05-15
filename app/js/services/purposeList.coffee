angular.module('app').service 'purposeList', ['dropdownFromJson', (dropdownFromJson) ->
  
 _items = new dropdownFromJson('listdata/purposes.json')
 
 return _items
]