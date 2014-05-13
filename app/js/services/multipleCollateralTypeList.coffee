angular.module('app').service 'multipleCollateralTypeList', ['dropdown', (dropdown) ->
 
 _list = new dropdown()
 
 _list.add('Campaign - multiple collateral needed to support a marketing effor over a specific period of time','campaign')
 _list.add('Event - mutiple collateral needed to support a corporate presence at a designated location','event')
 _list.add('Package - Multiple collateral needed to support a sample build.','package')
 
 return _list;

]