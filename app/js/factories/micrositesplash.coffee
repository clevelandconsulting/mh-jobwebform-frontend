
  
angular.module('app').factory 'micrositesplash', ['medium', (medium) -> 
 class micrositesplash extends medium
  constructor: () ->
   super('microsite-splash')
   @data.priorities = {}
]