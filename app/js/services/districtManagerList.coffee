angular.module('app').service 'districtManagerList', ['dropdown', (dropdown) ->
 
 _list = new dropdown()
 
 _list.add('Manager 1')
 _list.add('Manager 2')
 
 return _list;

]