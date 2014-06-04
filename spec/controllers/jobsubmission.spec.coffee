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
  @controller = $controller
  @apiResponse = 'foo'
  @apiResponseFunction = (data) =>
   if @succeedPromise
    @q.when @apiResponse
   else
    @q.reject @apiResponse
  spyOn(@mockJob,"prepare").andCallFake ->
  spyOn(@mockUrl,"postJobRequestData").andCallFake @apiResponseFunction
  
 describe "constructor", ->
  describe "when form validity is true", ->
   Given -> 
    @validity = true
    spyOn(@mockJob,"isValidForSubmission").andReturn(@validity)
    
   When -> @subject = @controller 'jobsubmissionController', {jobService:@mockJob, urlService:@mockUrl, notifications:@mockNotifications, location:@location}

   Then -> expect(@subject).toBeDefined()
   Then -> expect(@subject.job).toBe(@mockJob)
   Then -> expect(@subject.urlService).toBe(@mockUrl)
   Then -> expect(@subject.notifications).toBe(@mockNotifications)
   
   Then -> expect(@mockJob.isValidForSubmission).toHaveBeenCalled()
   Then -> expect(@subject.validJobRequest).toEqual(@validity)
   Then -> expect(@mockUrl.postJobRequestData).toHaveBeenCalledWith(@subject.job.data,@subject.job.sessionId)
   Then -> expect(@subject.template).toEqual('step3-posting.html')
  
  describe "when form validity is false", ->
   Given -> 
    @validity = false
    spyOn(@mockJob,"isValidForSubmission").andReturn(@validity)
    
   When -> @subject = @controller 'jobsubmissionController', {jobService:@mockJob, urlService:@mockUrl, notifications:@mockNotifications, location:@location}

   Then -> expect(@subject).toBeDefined()
   Then -> expect(@subject.job).toBe(@mockJob)
   Then -> expect(@subject.urlService).toBe(@mockUrl)
   Then -> expect(@subject.notifications).toBe(@mockNotifications)
   
   Then -> expect(@mockJob.isValidForSubmission).toHaveBeenCalled()
   Then -> expect(@subject.validJobRequest).toEqual(@validity)
   Then -> expect(@mockUrl.postJobRequestData).not.toHaveBeenCalled()
   Then -> expect(@subject.template).toEqual('step3-invalid.html')
   
   describe "submitJobRequest()", -> 
    describe "when job is not valid for submission", ->
     When -> @subject.submitJobRequest()
     Then -> expect(@mockUrl.postJobRequestData).not.toHaveBeenCalled()
     
   describe 'step1()', ->
    Given -> @location.path('/submit')
    When -> @subject.step1()
    Then -> expect(@location.path()).toEqual('/')
   
   describe 'displayStep2Button()', ->
   
    describe 'when multiple components', ->
     Given ->
      @mockJob.data.medium = undefined 
      spyOn(@mockJob,'hasMultipleComponents').andReturn(true)
     When -> @result = @subject.displayStep2Button()
     Then -> expect(@result).toBe(true)
     
    describe 'when single component', ->
     Given -> spyOn(@mockJob,'hasMultipleComponents').andReturn(false)
     describe 'with valid medium', ->
      Given -> @mockJob.data.medium = 'somevalidmedium'
      When -> @result = @subject.displayStep2Button()
      Then -> expect(@result).toBe(true)
     describe 'with invalid medium', ->
      Given -> @mockJob.data.medium = undefined
      When -> @result = @subject.displayStep2Button()
      Then -> expect(@result).toBe(false)
   
   describe 'step2()', ->
    Given -> @location.path('/submit')
    
    describe 'with single collateral', ->
     Given -> spyOn(@mockJob,'hasMultipleComponents').andReturn(false)
     
     describe 'and valid medium', ->
      Given ->
       @medium = 'print-digital'
       @mockJob.data.medium = @medium
      
      When -> @subject.step2()
      Then -> expect(@mockJob.hasMultipleComponents).toHaveBeenCalled()
      Then -> expect(@location.path()).toEqual('/' + @medium)
     
     describe 'and invalid medium', ->
      Given ->
       @medium = undefined
       @mockJob.data.medium = @medium
      
      When -> @subject.step2()
      Then -> expect(@mockJob.hasMultipleComponents).toHaveBeenCalled()
      Then -> expect(@location.path()).toEqual('/')
    
    describe 'with multiple collateral', ->
     Given -> spyOn(@mockJob,'hasMultipleComponents').andReturn(true)
     When -> @subject.step2()
     Then -> expect(@mockJob.hasMultipleComponents).toHaveBeenCalled()
     Then -> expect(@location.path()).toEqual('/collateral')
     
 describe 'when form validity is true', ->
  Given ->
   @validity = true
   spyOn(@mockJob,"isValidForSubmission").andReturn(@validity)
   @subject = @controller 'jobsubmissionController', {jobService:@mockJob, urlService:@mockUrl, notifications:@mockNotifications, location:@location}
 
  describe "checkForValidity()", ->
   Given -> @mockJob.prepare()
    
   When -> @result = @subject.checkForValidity()
   Then -> expect(@mockJob.isValidForSubmission).toHaveBeenCalled()
   
  describe "submitJobRequest()", -> 
   describe "when job is valid for submission", ->
    Given ->
     @expectedData =  @mockJob.data
     @subject.validJobRequest = true
    
    describe "when response succeeds", ->
     Given -> 
      @succeedPromise = true
      today = new Date()
      dd = today.getDate()
      if dd < 10
       dd = '0'+dd
      mm = today.getMonth()+1
      if mm < 10
       mm = '0' + mm
      yyyy = today.getFullYear()
      @expectedJob = {data: {collateral:{}, requestDate:yyyy + '-' + mm + '-' + dd, mediums:{}}}
      
     When -> 
      @subject.submitJobRequest()
      @scope.$apply()
      
     Then -> expect(@mockUrl.postJobRequestData).toHaveBeenCalledWith(@expectedData, @subject.job.sessionId)
     Then -> expect(@subject.message).toBe(@apiResponse)
     Then -> expect(@subject.template).toBe('step3-success.html')
     Then -> expect(@mockJob.data).toEqual(@expectedJob.data)
    
    describe "when response fails", ->
     Given -> @succeedPromise = false
     When -> 
      @subject.submitJobRequest()
      @scope.$apply()
      
     Then -> expect(@mockUrl.postJobRequestData).toHaveBeenCalledWith(@expectedData, @subject.job.sessionId)
     Then -> expect(@subject.message).toBe(@apiResponse)
     Then -> expect(@subject.template).toBe('step3-failure.html')
   
   
    