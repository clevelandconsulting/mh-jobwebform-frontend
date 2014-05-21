describe "email", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, medium) ->
  @mockMedium = medium
  @subjectClass = $injector.get 'email', {medium:@mockMedium}
  
 
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
