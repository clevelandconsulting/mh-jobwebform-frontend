describe "listManager", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, dropdown, dropdownFromJson) ->
  @mockDD = dropdown
  @mockDDJson = dropdownFromJson
  @subject = $injector.get 'listManager', {dropdown:@mockDD, dropdownFromJson:@mockDDJson}
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.mediumList.items).toBeDefined()
 Then -> expect(@subject.productList.items).toBeDefined()
 Then -> expect(@subject.multipleCollateralTypeList.items).toBeDefined()
 Then -> expect(@subject.relationshipManagerList.items).toBeDefined()
 Then -> expect(@subject.productManagerList.items).toBeDefined()
 Then -> expect(@subject.districtManagerList.items).toBeDefined()
 Then -> expect(@subject.stateList.items).toBeDefined()
 Then -> expect(@subject.schoolBuildingList.items).toBeDefined()
 Then -> expect(@subject.customerRequestList.items).toBeDefined()
 Then -> expect(@subject.distributionChannelList.items).toBeDefined()
