angular.module('app').controller 'jobsubmissionController', [ 'jobService', 'urlService', 'notifications', '$location', '$routeParams', 
 class jobSubmissionController
  constructor: (@job, @urlService, @notifications, @location, @routeParams) ->
   @templates = { "success": 'success', "failure": 'failure', "invalid": 'invalid', "posting": 'posting'}
   if @routeParams.test
    @loadTemplate @routeParams.test
   else
    @checkForValidity()
    if @validJobRequest
     @loadTemplate @templates.posting
     @submitJobRequest()
    else
     @loadTemplate @templates.invalid
  
  loadTemplate: (name) ->
   @template = 'step3-' + name + '.html'
  
  checkForValidity: ->
   @validJobRequest = @job.isValidForSubmission()
  
  success: (data) =>
   @message = data
   @loadTemplate @templates.success
   @job.prepare()
  
  error: (data) =>
   @message = data
   @loadTemplate @templates.failure
   
  submitJobRequest: (logging) ->
   if @validJobRequest
    result = @urlService.postJobRequestData(@job.data, @job.sessionId )
    result.then @success, @error
   else 
    @loadTemplate @templates.invalid
   return
   #result.then = (data) => @response = data
  
  displayStep2Button: ->
   result = true
   if !@job.hasMultipleComponents()
    if !@job.medium?
     result = false
   
   result 
  
  step1: ->
   @location.path('/')
   return
   
  step2: ->
   if !@job.hasMultipleComponents()
    medium = ''
    if @job.medium?
     medium = @job.medium
    @location.path('/' + medium)
    
   else
    @location.path('/collateral')
    
   return
]