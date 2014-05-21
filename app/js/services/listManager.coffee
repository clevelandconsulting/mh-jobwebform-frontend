###
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
###
angular.module('app').service 'listManager', ['dropdown', 'dropdownFromJson',(dropdown,dropdownFromJson) ->
 
 mediumList = new dropdown()
 mediumList.add('Print/Digital', 'print-digital')
 mediumList.add('Email', 'email')
 mediumList.add('Microsite/Splash','microsite-splash')
 mediumList.add('Video', 'video')
 mediumList.add('Webinar', 'webinar')
 mediumList.add('Social Media', 'socialmedia')
 
 productList = new dropdown()
 productList.add('Product 1')
 productList.add('Product 2')
 
 multipleCollateralTypeList = new dropdown()
 multipleCollateralTypeList.add('Campaign - multiple collateral needed to support a marketing effor over a specific period of time','campaign')
 multipleCollateralTypeList.add('Event - mutiple collateral needed to support a corporate presence at a designated location','event')
 multipleCollateralTypeList.add('Package - Multiple collateral needed to support a sample build.','package')

 relationshipManagerList = new dropdown()
 relationshipManagerList.add('Manager 1')
 relationshipManagerList.add('Manager 2')

 productManagerList = new dropdown()
 productManagerList.add('Manager 1')
 productManagerList.add('Manager 2')
 
 districtManagerList = new dropdown()
 districtManagerList.add('Manager 1')
 districtManagerList.add('Manager 2')
 
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