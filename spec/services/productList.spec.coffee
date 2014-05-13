describe 'productList', ->
 Given -> module 'app'
 Given angular.mock.inject (dropdown,$injector) ->
  @mockDD = dropdown
  @subject = $injector.get 'productList', {dropdown:@mockDD}
  @expectedItems = [
    {name:'Product 1',value:'Product 1'},
    {name:'Product 2',value:'Product 2'},
  ]
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.items).toEqual(@expectedItems)