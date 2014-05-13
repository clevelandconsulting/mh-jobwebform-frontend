describe 'mediumList', ->
 Given -> module 'app'
 Given angular.mock.inject (dropdown,$injector) ->
  @mockDD = dropdown
  @subject = $injector.get 'mediumList', {dropdown:@mockDD}
  @expectedItems = [
    {name:'Print/Digital',value:'print-digital'},
    {name:'Email',value:'email'},
    {name:'Microsite/Splash',value:'microsite-splash'},
    {name:'Video',value:'video'},
    {name:'Webinar',value:'webinar'},
    {name:'Social Media',value:'socialmedia'}
  ]
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.items).toEqual(@expectedItems)