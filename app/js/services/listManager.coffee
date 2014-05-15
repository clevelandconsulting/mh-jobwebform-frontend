angular.module('app').service 'listManager', ['mediumList', 'productList', 'multipleCollateralTypeList', 'relationshipManagerList', 'productManagerList', 'districtManagerList', 'stateList', 'schoolBuildingList', 'emailObjectiveList','emailListSourceList', 'purposeList', 'productCategoryList',(mediumList,productList,multipleCollateralTypeList,relationshipManagerList,productManagerList,districtManagerList,stateList,schoolBuildingList, emailObjectiveList, emailListSourceList, purposeList, productCategoryList)->
 
 obj = {
  'mediumList':mediumList,
  'productList':productList,
  'multipleCollateralTypeList':multipleCollateralTypeList,
  'relationshipManagerList':relationshipManagerList,
  'productManagerList':productManagerList,
  'districtManagerList':districtManagerList,
  'stateList':stateList,
  'schoolBuildingList':schoolBuildingList,
  'emailObjectiveList':emailObjectiveList,
  'emailListSourceList':emailListSourceList,
  'purposeList':purposeList,
  'productCategoryList':productCategoryList
 }
 
 obj
 
]