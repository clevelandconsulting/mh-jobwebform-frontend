describe "listManager", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, mediumList, productList, multipleCollateralTypeList, relationshipManagerList, productManagerList, districtManagerList, stateList, schoolBuildingList) ->
  @mockMediums = mediumList
  @mockMediums.items = [ 1,2,3,4,5,6 ]
  @mockProducts = productList
  @mockRelationshipManagers = relationshipManagerList
  @mockProductManagers = productManagerList
  @mockDistrictManagers = districtManagerList
  @mockMultipleCollateralTypes = multipleCollateralTypeList
  @mockStates = stateList
  @mockBuildings = schoolBuildingList
  @subject = $injector.get 'listManager', {mediumList:@mockMediums, productList:@mockProducts, multipleCollateralTypeList:@mockMultipleCollateralTypes, relationshipManagerList:@mockRelationshipManagers, productManagerList:@mockProductManagers, stateList:@mockStates,districtManagerList:@mockDistrictManagers, schoolBuildingList:@mockBuildings}
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.mediumList).toBe(@mockMediums)
 Then -> expect(@subject.productList).toBe(@mockProducts)
 Then -> expect(@subject.multipleCollateralTypeList).toBe(@mockMultipleCollateralTypes)
 Then -> expect(@subject.relationshipManagerList).toBe(@mockRelationshipManagers)
 Then -> expect(@subject.productManagerList).toBe(@mockProductManagers)
 Then -> expect(@subject.districtManagerList).toBe(@mockDistrictManagers)
 Then -> expect(@subject.stateList).toEqual(@mockStates)
 Then -> expect(@subject.schoolBuildingList).toEqual(@mockBuildings)
