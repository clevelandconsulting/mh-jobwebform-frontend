describe "email", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, medium, utilities) ->
  @mockMedium = medium
  @mockUtilities = utilities;
  @subjectClass = $injector.get 'email', {medium:@mockMedium, utilities:@mockUtilities}
  
 
 describe "when using fieldmarketing", ->
  Given -> @subject = new @subjectClass(true)
 
  Then -> expect(@subject).toBeDefined()
  Then -> expect(@subject.useFieldMarketing).toBe(true)
  Then -> expect(@subject.type).toBe('email')
  
 describe "when not using fieldmarketing", ->
  Given -> @subject = new @subjectClass(false)
 
  Then -> expect(@subject).toBeDefined()
  Then -> expect(@subject.useFieldMarketing).toBe(false)
  Then -> expect(@subject.type).toBe('email')
 
 describe "toggles", ->
  Given ->
   @subject = new @subjectClass(false)
   @selected = 'anything here'
   @newItem = 0
   @list = 'anything'
   spyOn(@mockUtilities,'toggle')
 
  describe  "toggleState()", ->
   Given -> @subject.data.deploymentStates = @selected
   When -> @subject.toggleState(@list,@newItem)
   Then -> expect(@mockUtilities.toggle).toHaveBeenCalledWith(@list,@selected,@newItem)
  
  describe  "toggleBuilding()", ->
   Given -> @subject.data.schoolBuildings = @selected
   When -> @subject.toggleBuilding(@list,@newItem)
   Then -> expect(@mockUtilities.toggle).toHaveBeenCalledWith(@list,@selected,@newItem)
  
  describe  "toggleObjective()", ->
   Given -> @subject.data.primaryObjectives = @selected
   When -> @subject.toggleObjective(@list,@newItem)
   Then -> expect(@mockUtilities.toggle).toHaveBeenCalledWith(@list,@selected,@newItem)
   
  describe  "toggleSource()", ->
   Given -> @subject.data.listSources = @selected
   When -> @subject.toggleSource(@list,@newItem)
   Then -> expect(@mockUtilities.toggle).toHaveBeenCalledWith(@list,@selected,@newItem)