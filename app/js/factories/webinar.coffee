angular.module('app').factory 'webinar', ['medium', (medium) -> 
 class email extends medium
  constructor: (@useFieldMarketing) ->
   super('webinar')
   @data.presenter = {}
   @data.additionalInformation = {}
   
]