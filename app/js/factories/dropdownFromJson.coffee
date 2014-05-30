angular.module('app').factory 'dropdownFromJson', ['$http', 'dropdown', ($http, dropdown) ->
 class dropdownFromJson extends dropdown
  constructor: (url) ->
   super()
   @load(url)
   
  load: (url) ->
   stateJson = $http.get(url).then (results) =>
    for item in results.data
     name = null
     value = null
     
     if item.name?
      name = item.name
     
     if item.value?
      value = item.value
      
     if name == null and value == null
      name = item
      value = item
     else if name == null
      name = value
     else if value == null
      value = name
     
     delete item.name
     delete item.value
     
     @add(name, value, item)
]