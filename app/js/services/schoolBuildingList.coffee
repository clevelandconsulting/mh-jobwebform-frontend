angular.module('app').service 'schoolBuildingList', ['dropdownFromJson', (dropdownFromJson) ->
  
 _items = new dropdownFromJson('listdata/schoolBuildings.json')
 
 return _items
]