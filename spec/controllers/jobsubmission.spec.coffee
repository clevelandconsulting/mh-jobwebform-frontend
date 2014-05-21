describe "jobsubmission controller", ->
 Given -> module 'app'
 Given angular.mock.inject ($rootScope, $controller, $location, jobService, urlService, notifications, $q) ->
  @scope = $rootScope.$new()
  @mockJob = jobService
  @mockUrl = urlService
  @q = $q
  @mockNotifications = notifications
  @location = $location
  @location.path('/')
  @validity = true
  spyOn(@mockJob,"prepare").andCallThrough()
  spyOn(@mockJob,"isValidForSubmission").andReturn(@validity)
  @subject = $controller 'jobsubmissionController', {jobService:@mockJob, urlService:@mockUrl, notifications:@mockNotifications, location:@location}
  
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.job).toBe(@mockJob)
 Then -> expect(@subject.urlService).toBe(@mockUrl)
 Then -> expect(@subject.notifications).toBe(@mockNotifications)
 Then -> expect(@mockJob.isValidForSubmission).toHaveBeenCalled()
 Then -> expect(@subject.validJobRequest).toEqual(@validity)
 
 describe "checkForValidity()", ->
  Given -> @mockJob.prepare()
  When -> @result = @subject.checkForValidity()
  Then -> expect(@mockJob.isValidForSubmission).toHaveBeenCalled()
  
 describe "submitJobRequest()", ->
  Given -> 
   @apiResponse = 'foo'
   @apiResponseFunction = (data) =>
    if @succeedPromise
     @q.when @apiResponse
    else
     @q.reject @apiResponse
    
    
   spyOn(@mockUrl,"postJobRequestData").andCallFake @apiResponseFunction
  ###
   1. Check If Valid
   2. If Valid
    a. Post Job Data using URL service
    b. Get the results
   3.Display Results
    a. If not valid, notification that it's not valid and return
    b. If valid, display results of the POST
  ###
  
  describe "when job is valid for submission", ->
   Given -> @subject.isValidForSubmission = true
   
   describe "when response succeeds", ->
    Given -> @succeedPromise = true
    When -> 
     @promise = @subject.submitJobRequest()
     @promise.then (data) => @result = data
     @scope.$apply()
     
    Then -> expect(@mockUrl.postJobRequestData).toHaveBeenCalledWith(@mockJob.data)
    Then -> expect(@result).toBe(@apiResponse)
   # Test For results