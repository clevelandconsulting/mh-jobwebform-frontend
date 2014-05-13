
  
angular.module('app').factory 'email', ['medium', (medium) -> 
 class email extends medium
  constructor: (@useFieldMarketing) ->
   super('email')
]