angular.module('app').service 'productList', ['dropdown', (dropdown) ->
 
 _list = new dropdown()
 
 _list.add('Product 1')
 _list.add('Product 2')
 
 return _list;

]