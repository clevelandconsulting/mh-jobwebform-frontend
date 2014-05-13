describe 'multipleCollateralTypeList', ->
 Given -> module 'app'
 Given angular.mock.inject (dropdown,$injector) ->
  @mockDD = dropdown
  @subject = $injector.get 'multipleCollateralTypeList', {dropdown:@mockDD}
  @expectedItems = [
    {name:'Campaign - multiple collateral needed to support a marketing effor over a specific period of time',value:'campaign'},
    {name:'Event - mutiple collateral needed to support a corporate presence at a designated location',value:'event'},
    {name: 'Package - Multiple collateral needed to support a sample build.', value:'package'}
  ]
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.items).toEqual(@expectedItems)
 


