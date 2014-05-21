class job
 constructor: ->
  @prepare()
  
 prepare: ->
  today = new Date()
  dd = today.getDate()
  if dd < 10
   dd = '0'+dd
  mm = today.getMonth()+1
  if mm < 10
   mm = '0' + mm
  yyyy = today.getFullYear()
  @data = {collateral:{}, requestDate:yyyy + '-' + mm + '-' + dd}
  @mediums = {}
 
 @getter: (name) -> @data[name]
 @setter: (name, value) -> @data[name] = value
 
 Object.defineProperties @prototype,
  requestorName:
   get: -> @data.requestorName
   set: (value) -> @data.requestorName = value
   
  requestDate:
   get: -> @data.requestDate
   set: (value) -> @data.requestDate = value
  
  fieldMarketing:
   get: -> @data.fieldMarketing
   set: (value) -> @data.fieldMarketing = value
  
  product:
   get: -> @data.product
   set: (value) -> @data.product = value
  
  portfolio:
   get: -> @data.portfolio
   set: (value) -> @data.portfolio = value
   
  costCenter:
   get: -> @data.costCenter
   set: (value) -> @data.costCenter = value
   
  discipline:
   get: -> @data.discipline
   set: (value) -> @data.discipline = value
  
  multipleCollateral:
   get: -> @data.multipleCollateral
   set: (value) -> @data.multipleCollateral = value
   
  multipleCollateralType:
   get: -> @data.multipleCollateralType
   set: (value) -> @data.multipleCollateralType = value
  
  mediums:
   get: -> @data.mediums
   set: (value) -> @data.mediums = value
  
  medium:
   get: -> @data.medium
   set: (value) -> @data.medium = value
  
  title:
   get: -> @data.title
   set: (value) -> @data.title = value
  
  relationshipManager:
   get: -> @data.relationshipManager
   set: (value) -> @data.relationshipManager = value
   
  productManager:
   get: -> @data.productManager
   set: (value) -> @data.productManager = value
  
  districtManager:
   get: -> @data.districtManager
   set: (value) -> @data.districtManager = value
  
 noMediums: ->
  if @data.mediums?
   for key of @data.mediums
    if @data.mediums[key]
     return false
  
  true
 
 noMediumKeys: ->
  if @data.mediums?
   for key of @data.mediums
     return false
  
  true
 
 addToCollateral: (medium, index) ->
  if !medium.type?
   throw new Error('You can only add mediums as collateral!')
  type = medium.type
  if !@data.collateral[type]?
   @data.collateral[type] = []
  
  if index?
   @data.collateral[type][index] = medium
  else
   @data.collateral[type].push medium
   
 hasMultipleComponents: ->
  if @multipleCollateral?
   @multipleCollateral == 'yes'
  else
   false
 
 isFieldMarketing: ->
  if @fieldMarketing?
   f = @fieldMarketing.toLowerCase()
   f == 'sales rep' || f == "consultant"
  else
   false
 
 isValidForSubmission: ->
  result = true
  
  if !@hasMultipleComponents()
   #console.log 'medium collateral',@data.collateral[@medium]
   if !@data.collateral[@medium]?
    result = false
    
  else
   for key of @mediums
    if !(@data.collateral[key]?)
     result = false
  
  result

angular.module('app').factory 'job', -> job