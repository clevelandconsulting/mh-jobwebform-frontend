###
 The jobRequestController has several steps
   
   Step 0:  Start the job request
   Step 1:  Add multiple jobs (might be bypassed if not a multiple job job)
   Step 2:  Update data on a job
   --Step 3:  Submission complete-- MOVED TO JOB SUBMISSION CONTROLLER


###


angular.module('app').controller 'jobrequestController', [ 'listManager', 'jobService', 'printdigital', 'email', 'micrositesplash', 'socialmedia', 'video', 'webinar', 'notifications', '$location', '$rootScope', '$routeParams'
 class jobRequestController
  constructor: (@listManager, @job, @printdigital, @email, @micrositesplash, @socialmedia, @video, @webinar, @notifications, @location, @scope, @routeParams) ->
   @currentMedium = @getCurrentMedium()
   
   #pull out list services
   @mediumList = @listManager.mediumList
   @productList = @listManager.productList
   @multipleCollateralTypeList = @listManager.multipleCollateralTypeList
   @relationshipManagerList = @listManager.relationshipManagerList
   @productManagerList = @listManager.productManagerList
   @districtManagerList = @listManager.districtManagerList
   @stateList = @listManager.stateList
   @schoolBuildingList = @listManager.schoolBuildingList
   @emailObjectiveList = @listManager.emailObjectiveList
   @emailListSourceList = @listManager.emailListSourceList
   @purposeList = @listManager.purposeList
   @productCategoryList = @listManager.productCategoryList
   @customerRequestList = @listManager.customerRequestList
   @distributionChannelList = @listManager.distributionChannelList
   @helpText = 'Here is the help!'
   @setCurrentStep()
   @mediumGang = @mediumList.gangByCount(3)
   @changeTemplate()
   @scope.$on 'invalid', -> console.log 'invalid!!'
   #console.log 'constructd', @currentStep
  
  keyToHeader: (key) ->
   if key? & key != ''
    key = @toTitleCase(key)
    header = key.replace(/-/g,'/')
   else
    ''

  toTitleCase: (str) ->
   fn = (txt) -> txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
   return str.replace(/([^\W_]+[^\s-]*) */g, fn )
  
  newMedium: (medium) ->
   @location.path('/' + medium)
  
  addCurrentMedium: ->
   if @currentMedium?
    @job.addToCollateral(@currentMedium,@getIndexAndMediumType()[0])
  
  getIndexAndMediumType: ->
   path = @location.path().split("/")
   mediumType = path[1]
   
   if path.length > 2
    index = parseInt(path[2])-1
   
   [index,mediumType]
  
  getCurrentMedium: ->
   medium = null
   arr = @getIndexAndMediumType()
   index = arr[0]
   mediumType = arr[1]
   
   if index? && !isNaN(index) && index >= 0
    #We have an index, check to see if we can find a medium there
    if @job.data.collateral[mediumType]? and @job.data.collateral[mediumType][index]
     medium = @job.data.collateral[mediumType][index]
     

   else
    #no index, make a new one
    switch mediumType
     when 'print-digital' then medium = new @printdigital(@job.isFieldMarketing())
     when 'email' then medium = new @email(@job.isFieldMarketing())
     when 'microsite-splash' then medium = new @micrositesplash()
     when 'socialmedia' then medium = new @socialmedia()
     when 'video' then medium = new @video()
     when 'webinar' then medium = new @webinar()
   
   if medium == null && mediumType != ''
    @location.path('/' + mediumType)
    
   medium
  
  getMediumListTemplate: (key)->
   if key? && key != ''
    'list/' + key + '-list.html'
   else
    ''
  
  setCurrentStep: ->
   #console.log 'path', @location.path()
   switch @location.path()
    when '/' then @currentStep = 0
    when '/collateral' then @currentStep = 1
    when '/complete' then @currentStep = 3
    else @currentStep = 2
  
  changeTemplate: ->
   @template = 'step' + @currentStep + '.html'
   if @currentStep == 2
    @mediumTemplate = 'medium/' + @currentMedium.type + '.html'
  
  goToMedium: (medium,index) ->
   number = parseInt(index)+1;
   @location.path '/' + medium + '/' + number
  
  deleteCollateral: (mediumType, index) ->
   if mediumType? and index? and !isNaN(index) and index >= 0
    @job.data.collateral[mediumType].splice(index,1)
  
  submit: ->
   if !@job.hasMultipleComponents() 
    @addCurrentMedium()
    
   if @job.isValidForSubmission()
    @location.path('/submit')
   else
    @notifications.error('Not everything required has been filled out.')
  
  delete: ->
   arr = @getIndexAndMediumType()
   index = arr[0]
   mediumType = arr[1]
   
   if index? && !isNaN(index) && index >= 0
    if @job.data.collateral[mediumType]? and @job.data.collateral[mediumType][index]
     @deleteCollateral(mediumType,index)
   
   @location.path('/collateral')
  
  previous: ->
   if @currentStep=1 or @currentStep=2
    @location.path('/')
  
  cancel: ->
   @job.prepare()
   @location.path('/')
  
  next: (inValid) ->
   @submitted = true
   if inValid
    @notifications.error('Please fill out all the required fields before moving to the next step.')
   else
    if @currentStep == 0
     if @job.hasMultipleComponents()
      @currentStep = 1
      @location.path('/collateral')
     else 
      if @job.medium? && @job.medium != ''
       @currentStep = 2
       @location.path('/'+@job.medium)
      else
       @notifications.error("You must first select a medium for the job.")
    else
     @currentStep = 3
     @location.path('/complete')
   
   return
  
  done: ->
   @addCurrentMedium()
   @location.path('/collateral')
]