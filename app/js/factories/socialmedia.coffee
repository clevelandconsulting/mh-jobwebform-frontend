
  
angular.module('app').factory 'socialmedia', ['medium', (medium) -> 
 class socialmedia extends medium
  constructor: () ->
   super('socialmedia')

]