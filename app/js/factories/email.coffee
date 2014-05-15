
  
angular.module('app').factory 'email', ['medium', 'utilities', (medium, utilities) -> 
 class email extends medium
  constructor: (@useFieldMarketing) ->
   @utilities = utilities
   super('email')
   
  toggleState:(items,index) ->
   @data.deploymentStates = @utilities.toggle(items,@data.deploymentStates,index)
   
  toggleBuilding:(items,index) ->
   @data.schoolBuildings = @utilities.toggle(items,@data.schoolBuildings,index)
   
  toggleObjective:(items,index) ->
   @data.primaryObjectives = @utilities.toggle(items,@data.primaryObjectives,index)
   
  toggleSource:(items,index) ->
   @data.listSources = @utilities.toggle(items,@data.listSources,index)
]