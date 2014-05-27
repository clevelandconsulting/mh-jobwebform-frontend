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
  
  districtManager:
   get: -> @data.districtManager
   set: (value) -> @data.districtManager = value

  creativeBrief:
   get: -> @data.creativeBrief
   set: (value) -> @data.creativeBrief = value

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
 
 isValidForSubmission: (logging) ->
  result = true
  
  if !@requestorName? or @requestorName == ''
   result = false
  else if !@fieldMarketing? or @fieldMarketing == ''
   result = false
  else if !@product? or @product == ''
   result = false
  else if !@costCenter? or @costCenter == ''
   result = false
  
  if logging
   console.log 'base data result', result
  
  if result 
   if !@hasMultipleComponents()
    if logging 
     console.log 'checking single collateral'
    if !@medium? or @medium == ''
     if logging
      console.log 'no medium'
     result = false
    else if !@data.collateral[@medium]?
     if logging
      console.log 'no collateral for medium', @medium, @data.medium
     result = false
     
   else
    if logging
     console.log 'checking multiple collateral', @mediums
    if !@mediums? or @mediums == '' or @mediums.length == 0
     result = false
    else
     for key of @mediums
      if !(@data.collateral[key]?)
       result = false
  
  result

angular.module('app').factory 'job', -> job