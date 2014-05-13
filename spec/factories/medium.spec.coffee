describe "medium", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector) ->
  @subjectClass = $injector.get 'medium'
  
 describe "constructor with a type", ->
  Given ->
   @sometype ='something'
   @subject = new @subjectClass(@sometype)
 
  Then -> expect(@subject).toBeDefined()
  Then -> expect(@subject.type).toBe(@sometype)
  Then -> expect(@subject.data).toEqual({})