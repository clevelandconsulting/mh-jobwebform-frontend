
  
angular.module('app').factory 'socialmedia', ['medium', (medium) -> 
 class socialmedia extends medium
  constructor: () ->
   super('socialmedia')
  
  togglePurpose:(items,index) ->
   @data.purposes = @utilities.toggle(items,@data.purposes,index)
]