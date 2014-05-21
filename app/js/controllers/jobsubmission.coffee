angular.module('app').controller 'jobsubmissionController', [ 'jobService', 'urlService', 'notifications', '$location', '$rootScope',
 class jobSubmissionController
  constructor: (@job, @urlService, @notifications, @location, @scope) ->
   @checkForValidity()
   
  checkForValidity: ->
   @validJobRequest = @job.isValidForSubmission()
   
  submitJobRequest: ->
   result = @urlService.postJobRequestData(@job.data)
   result
   #result.then = (data) => @response = data

]