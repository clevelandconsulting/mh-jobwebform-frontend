describe 'dropDownFromJson', ->
 Given -> module 'app'
 Given angular.mock.inject ($injector,$http, $httpBackend) ->
  @mockHttp = $http
  @httpBackend = $httpBackend
  @subjectClass = $injector.get 'dropdownFromJson', {http:@mockHttp}
  @expectedItems = [
    {name:'New Mexico',value:'New Mexico'},
    {name:'Oklahoma',value:'Oklahoma'},
  ]
 
 Then -> expect(@subjectClass).toBeDefined()
 
 describe "loading a url", ->
  Given ->
   @url = 'someurl'
   @httpBackend.whenGET(@url).respond([{'name':'New Mexico'},{'name':'Oklahoma'}])
   
  When -> 
   @subject = new @subjectClass(@url)
   @httpBackend.flush()
  
  Then -> expect(@subject).toBeDefined()
  Then -> expect(@subject.items).toEqual(@expectedItems)
  Then -> @httpBackend.expectGET(@url)