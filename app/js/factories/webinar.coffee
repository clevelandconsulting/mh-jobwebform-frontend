
  
angular.module('app').factory 'webinar', ['medium', (medium) -> 
 class webinar extends medium
  constructor: () ->
   super('webinar')
]