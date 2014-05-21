angular.module('app').controller 'jobsubmissionController', [ 'jobService','notifications', '$location', '$rootScope',
 class jobSubmissionController
  constructor: (@job, @notifications, @location, @scope) ->
   
  checkForValidity: ->
   if @job.data.mediums = {} or @job.data.collateral = {}
    false

]