angular.module('app').factory 'webinar', ['medium', 'utilities', (medium, utilities) -> 
 class email extends medium
  constructor: (@useFieldMarketing) ->
   @utilities = utilities
   super('webinar')
   @data.presenter = {}
   @data.additionalInformation = {}
   
  togglePurpose:(items,index) ->
   @data.purposes = @utilities.toggle(items,@data.purposes,index)
   
]