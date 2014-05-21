describe "jobsubmission controller", ->
 Given -> module 'app'
 Given angular.mock.inject ($rootScope, $controller, $location, jobService, notifications) ->
  @scope = $rootScope.$new()
  @mockJob = jobService
  @mockNotifications = notifications
  @location = $location
  @location.path('/')
  @subject = $controller 'jobsubmissionController', {jobService:@mockJob, notifications:@mockNotifications, location:@location}
  spyOn(@mockJob,"prepare").andCallThrough()
  
 Then -> expect(@subject).toBeDefined()
 
 describe "checkForValidity()", ->
  Given -> @mockJob.prepare()

  When -> @result = @subject.checkForValidity()
  
  Then -> @expect(@result).toBe(false)
  
  