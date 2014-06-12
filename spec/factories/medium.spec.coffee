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
  
 describe "hasElement()", ->
  Given ->
   @subject = new @subjectClass('anything')
   @someElement = 'something'
   @someArray = []
   
  describe "when the element is in the array", -> 
   Given -> @someArray.push(@someElement)
   When -> @result = @subject.hasElement(@someArray,@someElement)
   Then -> expect(@result).toBe(true);