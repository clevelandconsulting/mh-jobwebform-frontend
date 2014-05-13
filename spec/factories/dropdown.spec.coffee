describe "dropdown", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector) ->
  @subjectClass = $injector.get 'dropdown'
  @subject = new @subjectClass()
 
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.items).toEqual([])
 
 describe "add()", ->
  Given ->
   @name = 'anyname'
   @value = 'anyvalue'
   @subject.items = []
   
  describe "with just a name", ->
   Given -> @expectedArray = [{name:@name,value:@name}]
   When -> @subject.add(@name)
   Then -> expect(@subject.items).toEqual(@expectedArray)
  
  describe "with a name and value", ->
   Given -> @expectedArray = [{name:@name,value:@value}]
   When -> @subject.add(@name, @value)
   Then -> expect(@subject.items).toEqual(@expectedArray)
   
  describe "with nothing", ->
   Given -> @expectedArray = []
   When -> @subject.add()
   Then -> expect(@subject.items).toEqual(@expectedArray)
   
 describe 'gangByCount()', ->
  Given -> 
   @subject.items = [
    {name:'Print/Digital',value:'Print/Digital'},
    {name:'Email',value:'Email'},
    {name:'Microsite/Splash',value:'Microsite/Splash'},
    {name:'Video',value:'Video'},
    {name:'Webinar',value:'Webinar'},
    {name:'Social Media',value:'Social Media'}
   ]
   @count = 3
   @expectedGanged = [
    [{name:'Print/Digital',value:'Print/Digital'},
    {name:'Email',value:'Email'},
    {name:'Microsite/Splash',value:'Microsite/Splash'}],
    [{name:'Video',value:'Video'},
    {name:'Webinar',value:'Webinar'},
    {name:'Social Media',value:'Social Media'}
    ]
   ]
  When -> @result = @subject.gangByCount(3)
  
  Then -> expect(@result).toEqual(@expectedGanged)