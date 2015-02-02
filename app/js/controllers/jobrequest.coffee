###
 The jobRequestController has several steps
   
   Step 0:  Start the job request
   Step 1:  Add multiple jobs (might be bypassed if not a multiple job job)
   Step 2:  Update data on a job
   --Step 3:  Submission complete-- MOVED TO JOB SUBMISSION CONTROLLER


###


angular.module('app').controller 'jobrequestController', [ 'listManager', 'jobService', 'printdigital', 'email', 'micrositesplash', 'socialmedia', 'video', 'webinar', 'notifications', '$location', '$scope', '$routeParams', '$fileUploader', '$window', 'urlService', 'deviceDetector'
 class jobRequestController
  constructor: (@listManager, @job, @printdigital, @email, @micrositesplash, @socialmedia, @video, @webinar, @notifications, @location, @scope, @routeParams, @fileUploader, @window, @urlService, @device) ->
   #console.log @device
   
   if @device.raw.os.android || @device.raw.os.firefoxos || @device.raw.os.ios
    @basicFileInput = true
   else
    @basicFileInput = false
    
   #console.log @basicFileInput
   
   @currentMedium = @getCurrentMedium()
   @window.scrollTo(0,0)
   @window.onbeforeunload = (event) =>
    message = 'Any unsubmitted data will be lost, are you sure you want to do this?'
    #console.log event
    if (typeof event == 'undefined')
     event = @window.event
    if (event)
     event.returnValue = message
     
    message
   
   
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
   sessionId = @job.sessionId
   
   success = (event, xhr, item, response) =>
    if !data
      data = []
      
    index = data.indexOf(item.file.name)
    if ( index == -1 )
     data.push(item.file.name)
     item.addedToData = true
     @notifications.success('Your file was successfully uploaded!')
    
    data
   cancel = (event, xhr, item, type) => @removeItemFromData(item,type)
   error = (event, xhr, item, response, type) =>
       msg = item.file.name + ' failed to upload.';
       if response?
        if response.answer?
         msg = msg + ' ' + response.answer
        else
         msg = msg + ' ' + response
        
       @notifications.error( msg )
       @removeItemFromData(item, type)
   
   afterAddingFile = (event, item) ->
    if ( !item.isError )
     item.formData[0]['alias'] = item.alias
     item.progress = 0
     item.upload()

   whenAddingFileFailed = (event, item) => @notifications.error('Failed to add the file ' + item.file.name +  '.')
   
   successCreativeBrief = (event, xhr, item, response) => @job.creativeBrief = success(event,xhr,item,response)
   successCurrentMedium = (event, xhr, item, response) => @currentMedium.data.photo = success(event,xhr,item,response)
   
   cancelCreativeBrief = (event, xhr, item) => cancel(event,xhr,item,'creativeBrief')
   cancelCurrentMedium = (event, xhr, item) => cancel(event,xhr,item,'currentMedium.photo')
   
   errorCreativeBrief = (event, xhr, item, response) => error(event,xhr,item,response,'creativeBrief')
   errorCurrentMedium = (event, xhr, item, response) => error(event,xhr,item,response,'currentMedium.photo')
   
   @job.uploader = '';
   
   if @currentMedium?
    @currentMedium.uploader = @fileUploader.create({
     scope: @scope,                          # to automatically update the html. Default: $rootScope
     url: @urlService.jobRequestPostURL + '?action=upload&sessionId=' + sessionId,
     formData: [
      { }
     ],
     withCredentials: true
     filters: []
    })
    
    if @currentMedium.data.photo? > 0
     for file in @currentMedium.data.photo
      item = {
       file: {
           name: file,
       },
       progress: 100,
       isUploaded: true,
       isSuccess: true
      }
      item.remove = => @currentMedium.uploader.removeFromQueue(item);
      
      @currentMedium.uploader.queue.push(item);
     @currentMedium.uploader.progress = 100;
     
    @currentMedium.uploader.bind('cancel', cancelCurrentMedium)
    @currentMedium.uploader.bind('error', errorCurrentMedium)
    @currentMedium.uploader.bind('afteraddingfile', afterAddingFile)
    @currentMedium.uploader.bind('whenaddingfilefailed', whenAddingFileFailed) 
    @currentMedium.uploader.bind('success', successCurrentMedium)
   
   else   
    @job.uploader = @fileUploader.create({
     scope: @scope,                          # to automatically update the html. Default: $rootScope
     url: @urlService.jobRequestPostURL + '?action=upload&sessionId=' + sessionId,
     formData: [
      { }
     ],
     withCredentials: true
     filters: []
    })
    
    if @job.creativeBrief?
     for file in @job.creativeBrief
      item = {
       file: {
           name: file,
       },
       progress: 100,
       isUploaded: true,
       isSuccess: true
      }
      item.remove = => @job.uploader.removeFromQueue(item);
      
      @job.uploader.queue.push(item);
     @job.uploader.progress = 100;
      
     
    # ADDING FILTERS
    ### 
    @job.uploader.filters.push( (item) ->  # second user filter
        #console.info('filter2')
        true
    )
    ###
    # REGISTER HANDLERS
    @job.uploader.bind('cancel', cancelCreativeBrief)
    @job.uploader.bind('error', errorCreativeBrief)
    @job.uploader.bind('afteraddingfile', afterAddingFile)
    @job.uploader.bind('whenaddingfilefailed', whenAddingFileFailed) 
    @job.uploader.bind('success', successCreativeBrief)
    ###
    @job.uploader.bind('afteraddingall', (event, items) ->
        console.info('After adding all files', items)
    )
 
    @job.uploader.bind('beforeupload', (event, item) ->
        console.info('Before upload', item)
    )
 
    @job.uploader.bind('progress', (event, item, progress) ->
        console.info('Progress: ' + progress, item)
    )
 
    @job.uploader.bind('complete', (event, xhr, item, response) ->
        console.info('Complete', xhr, item, response)
    )
 
    @job.uploader.bind('progressall', (event, progress) ->
        console.info('Total progress: ' + progress)
    )
 
    @job.uploader.bind('completeall', (event, items) ->
        console.info('Complete all', items)
    )
    ###
  #console.log @currentMedium
  
  removeItem: (item, type) ->
   item.remove()
   @removeItemFromData(item, type)
  
  removeItemFromData: (item, type) ->
   if type == 'creativeBrief'
    data = @job.creativeBrief
   if type == 'currentMedium.photo'
    data = @currentMedium.data.photo
    
   if data and item.addedToData
    index = data.indexOf(item.file.name)
    if index > -1
     data.splice(index,1)
   
   if item.isUploaded and item.isSuccess
    success = ->
    @promise = @urlService.deleteItemFromServer(item, @job.sessionId)
    @promise.then success, (response) => @notifications.error(response)
  
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
    #remove the uploader if there is any.
    if @currentMedium.uploader?
     @currentMedium.uploader = undefined
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