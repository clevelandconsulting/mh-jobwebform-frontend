angular.module('app').service 'emailObjectiveList', ['dropdownFromJson', (dropdownFromJson) ->
  
 _items = new dropdownFromJson('listdata/emailObjectives.json')
 
 return _items
]