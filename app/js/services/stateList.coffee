angular.module('app').service 'stateList', ['dropdownFromJson', (dropdownFromJson) ->
  
 _items = new dropdownFromJson('listdata/states.json')
 
 return _items
]