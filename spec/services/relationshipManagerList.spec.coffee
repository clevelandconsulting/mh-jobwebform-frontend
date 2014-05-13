describe 'relationshipManagerList', ->
 Given -> module 'app'
 Given angular.mock.inject (dropdown,$injector) ->
  @mockDD = dropdown
  @subject = $injector.get 'relationshipManagerList', {dropdown:@mockDD}
  @expectedItems = [
    {name:'Manager 1',value:'Manager 1'},
    {name:'Manager 2',value:'Manager 2'},
  ]
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.items).toEqual(@expectedItems)