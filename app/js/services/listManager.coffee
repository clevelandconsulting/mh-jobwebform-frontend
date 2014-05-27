angular.module('app').service 'listManager', ['dropdown', 'dropdownFromJson',(dropdown,dropdownFromJson) ->
 
 mediumList = new dropdown()
 mediumList.add('Print/Digital', 'print-digital')
 mediumList.add('Email', 'email')
 mediumList.add('Microsite/Splash','microsite-splash')
 mediumList.add('Video', 'video')
 mediumList.add('Webinar', 'webinar')
 mediumList.add('Social Media', 'socialmedia')
 
 
 
 relationshipManagerList = new dropdownFromJson('listdata/managersRelationship.json')
 productManagerList = new dropdownFromJson('listdata/managersProduct.json')
 districtManagerList = new dropdownFromJson('listdata/managersDistrict.json')
 productList = new dropdownFromJson('listdata/products.json')
 multipleCollateralTypeList = new dropdownFromJson('listdata/multipleCollateralTypes.json')
 stateList = new dropdownFromJson('listdata/states.json')
 schoolBuildingList = new dropdownFromJson('listdata/schoolBuildings.json')
 emailObjectiveList = new dropdownFromJson('listdata/emailObjectives.json')
 emailListSourceList = new dropdownFromJson('listdata/emailSources.json')
 purposeList = new dropdownFromJson('listdata/purposes.json')
 productCategoryList = new dropdownFromJson('listdata/productCategories.json')
 customerRequestList = new dropdownFromJson('listdata/customerRequests.json')
 distributionChannelList = new dropdownFromJson('listdata/distributionChannels.json')
 
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
  'productCategoryList':productCategoryList,
  'customerRequestList':customerRequestList,
  'distributionChannelList':distributionChannelList
 }
 
 obj
 
]