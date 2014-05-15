angular.module('app').service 'emailListSourceList', ['dropdownFromJson', (dropdownFromJson) ->
  
 _items = new dropdownFromJson('listdata/emailSources.json')
 
 return _items
]