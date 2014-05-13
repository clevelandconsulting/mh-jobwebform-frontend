
  
angular.module('app').factory 'printdigital', ['medium', (medium) -> 
 class printdigital extends medium
  constructor: (@useFieldMarketing) ->
   super('print-digital')
]