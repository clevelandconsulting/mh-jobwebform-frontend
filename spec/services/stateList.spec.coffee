describe 'stateList', ->
 Given -> module 'app'
 Given angular.mock.inject (dropdownFromJson,$injector,$http, $httpBackend) ->
  @mockDD = dropdownFromJson
  @mockHttp = $http
  @httpBackend = $httpBackend
  @subject = $injector.get 'stateList', {dropdownFromJson:@mockDD}
  @expectedItems = [
    {name:'New Mexico',value:'New Mexico'},
    {name:'Oklahoma',value:'Oklahoma'},
  ]
 
 Then -> expect(@subject).toBeDefined()
 
 describe "items", ->
  Given ->
   @httpBackend.whenGET('listdata/states.json').respond([{'name':'New Mexico'},{'name':'Oklahoma'}])
  
  When -> 
   @result = @subject.items
   @httpBackend.flush()
  
  Then -> expect(@subject.items).toEqual(@expectedItems)