class medium
 constructor: (@type) ->
  @data = {}
 
 hasElement: (arr,elm) ->
  result = false
  if arr? && arr instanceof Array
   for element in arr
    if elm == element
     result = true
  
  result
  
angular.module('app').factory 'medium', -> medium