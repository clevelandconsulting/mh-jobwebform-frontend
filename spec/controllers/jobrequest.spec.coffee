##NEED TO IMPLEMENT ROUTING

describe "jobrequest controller", ->
 Given -> module 'app'
 Given angular.mock.inject ($rootScope, $controller, $location, urlService, listManager, jobService, printdigital, email, micrositesplash, socialmedia, video, webinar,notifications, $q, $httpBackend) ->
  @scope = $rootScope.$new()
  @mockUrlService = urlService
  @mockJob = jobService
  @mockListManager = listManager
  @mockNotifications = notifications
  @mockPrintDigital = printdigital
  @mockemail = email
  @mockmicrositesplash = micrositesplash
  @mocksocialmedia = socialmedia
  @mockvideo = video
  @mockwebinar = webinar
  @location = $location
  @location.path('/')
  @q = $q
  @httpBackend = $httpBackend
  @subject = $controller 'jobrequestController', {listManager:@mockListManager, jobService:@mockJob, printdigital:@mockPrintDigital, notifications:@mockNotifications, $location:@location, $scope:@scope, urlService:@mockUrlService}
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.currentStep).toBe(0)
 Then -> expect(@subject.template).toBe('step0.html')
 Then -> expect(@subject.mediumList).toBe(@mockListManager.mediumList)
 Then -> expect(@subject.mediumGang).toEqual(@mockListManager.mediumList.gangByCount(3))
 Then -> expect(@subject.productList).toBe(@mockListManager.productList)
 Then -> expect(@subject.multipleCollateralTypeList).toBe(@mockListManager.multipleCollateralTypeList)
 Then -> expect(@subject.relationshipManagerList).toBe(@mockListManager.relationshipManagerList)
 Then -> expect(@subject.productManagerList).toBe(@mockListManager.productManagerList)
 Then -> expect(@subject.districtManagerList).toBe(@mockListManager.districtManagerList)
 Then -> expect(@subject.stateList).toBe(@mockListManager.stateList)
 Then -> expect(@subject.schoolBuildingList).toBe(@mockListManager.schoolBuildingList)
 Then -> expect(@subject.emailObjectiveList).toBe(@mockListManager.emailObjectiveList)
 Then -> expect(@subject.emailListSourceList).toBe(@mockListManager.emailListSourceList)
 Then -> expect(@subject.purposeList).toBe(@mockListManager.purposeList)
 Then -> expect(@subject.productCategoryList).toBe(@mockListManager.productCategoryList)
 Then -> expect(@subject.customerRequestList).toBe(@mockListManager.customerRequestList)
 Then -> expect(@subject.distributionChannelList).toBe(@mockListManager.distributionChannelList)
 Then -> expect(@subject.job).toEqual(@mockJob)
 Then -> expect(@subject.notifications).toBe(@mockNotifications)
 Then -> expect(@subject.currentMedium).toEqual(null)
 
 describe "submit()", ->
  Given ->
   @startingPath = '/somepath'
   @location.path(@startingPath)
  
  describe "when job validity is true", ->
   Given -> spyOn(@mockJob,'isValidForSubmission').andReturn(true)
   
   describe "with single collateral", ->
    Given ->
     @subject.job.multipleCollateral = 'no'
     @subject.job.data.collateral = {} 
     @medium = new @mockPrintDigital
     @subject.currentMedium = @medium
    
    When -> @subject.submit()
    
    Then -> expect(@subject.job.data.collateral[@medium.type]).toEqual([@medium])
    Then -> expect(@location.path()).toEqual('/submit')
    
   describe "with multiple collateral", ->
    Given -> 
     @subject.job.multipleCollateral = 'yes'
     @subject.currentMedium = new @mockPrintDigital
     @subject.job.data.collateral = {}
   
    When -> @subject.submit()
   
    Then -> expect(@subject.job.data.collateral).toEqual({})
    Then -> expect(@location.path()).toEqual('/submit')
  
  describe "when job validity is false", ->
   Given ->
    spyOn(@mockJob,'isValidForSubmission').andReturn(false)
    spyOn(@mockNotifications,'error')
    
   When -> @subject.submit()
   
   Then -> expect(@location.path()).toEqual(@startingPath)
   Then -> expect(@mockNotifications.error).toHaveBeenCalled()
 
 describe "delete()",->
  Given -> 
   @medium = 'print-digital'
   @subject.job.data.collateral[@medium] = ['something', 'anotherthing']
   
   
  describe "when there is an index in the path", ->
   Given ->
    @index = 0
    @location.path('/' + @medium + '/' + (@index+1))
   
   When -> @subject.delete()
   Then -> expect(@location.path('/collateral'))
   Then -> expect(@subject.job.data.collateral[@medium]).toEqual(['anotherthing'])
 
 describe "cancel()", ->
  Given -> 
   @location.path('/somepath')
   spyOn(@mockJob, "prepare")
  
  When -> @subject.cancel()
  
  Then -> expect(@location.path()).toEqual('/')
  Then -> expect(@mockJob.prepare).toHaveBeenCalled()
 
 describe "previous()", ->
  Given -> @location.path('/somepath')
  
  describe "when current step is 1", ->
   Given -> @subject.currentStep = 1
   When -> @subject.previous()
   Then -> expect(@location.path()).toEqual('/')
   
  describe "when current step is 2", ->
   Given -> @subject.currentStep = 2
   When -> @subject.previous()
   Then -> expect(@location.path()).toEqual('/')

 describe "goToMedium()",->
  Given -> 
   @medium = 'print-digital'
   @index = 0
   @location.path('')
    
  When -> @subject.goToMedium(@medium,@index)
  Then -> expect(@location.path()).toEqual '/' + @medium + '/' + (@index+1)
 
 describe "done()", ->
  Given ->
   @medium = new @mockPrintDigital()
   @subject.currentMedium = @medium
   @subject.job.data.collateral = []
   
  describe "when collateral for the medium is undefined", ->
   Given -> 
    @subject.job.data.collateral['print-digital']=undefined
    @expectedResult = [@medium]
    
   When -> @subject.done()
  
   Then -> expect(@subject.job.data.collateral['print-digital']).toEqual(@expectedResult)
   Then -> expect(@location.path()).toEqual('/collateral')
   
  describe "when collateral for the medium is has an object", ->
   Given -> 
    @previous = 'somethign'
    @subject.job.data.collateral['print-digital']=[@previous]
    @expectedResult = [@previous,@medium]
    
   When -> @subject.done()
  
   Then -> expect(@subject.job.data.collateral['print-digital']).toEqual(@expectedResult)
   Then -> expect(@location.path()).toEqual('/collateral')
   
  describe "when collateral for the medium is has an object and the index matches that object", ->
   Given -> 
    @previous = new @mockPrintDigital()
    @previous.data.estimatedQuantity = 4000;
    @location.path('/print-digital/1')
    @subject.job.data.collateral['print-digital']=[@previous]
    @expectedResult = [@medium]
    
   When -> @subject.done()
  
   Then -> expect(@subject.job.data.collateral['print-digital']).toEqual(@expectedResult)
   Then -> expect(@location.path()).toEqual('/collateral')
 
 describe "removeItemFromData ()", ->
  Given ->
   @file = "anything"
   @anotherFile = 'anything else'
   @apiResponse = 'foo'
   @apiResponseFunction = (data) =>
    if @succeedPromise
     @q.when @apiResponse
    else
     @q.reject @apiResponse
   spyOn(@mockUrlService,"deleteItemFromServer").andCallFake @apiResponseFunction
   
  describe "when added to data for creative brief", ->
   Given ->
    @type = 'creativeBrief'
    @item = {addedToData:true, file: {name: @file} }
    @subject.job.sessionId = 'anything'
    
   describe "and file is uploaded and deleted unsuccessfully", ->
    Given -> 
     @item['isUploaded'] = @item['isSuccess'] = true
     @succeedPromise = false
     @httpBackend.whenGET(/listdata*/).respond(200,{})
     spyOn(@mockNotifications,"error")
     
    When -> 
     @subject.removeItemFromData(@item, @type)
     @scope.$apply()
     
    Then -> expect(@mockUrlService.deleteItemFromServer).toHaveBeenCalledWith(@item, @subject.job.sessionId)
    Then -> expect(@mockNotifications.error).toHaveBeenCalledWith(@apiResponse)
   
   describe "and file is not uploaded", ->
    Given -> @item['isUploaded'] = false
    When -> @subject.removeItemFromData(@item, @type)
    Then -> expect(@mockUrlService.deleteItemFromServer).not.toHaveBeenCalledWith(@item, @subject.job.sessionId)
   
   describe "and the file is in the brief", ->
    Given ->
     @subject.job.creativeBrief = [@file,@anotherFile]
     @expectedBrief = [@anotherFile]
   
    When -> @subject.removeItemFromData(@item, @type)
    Then -> expect(@subject.job.creativeBrief).toEqual(@expectedBrief)
  
   describe "and the file is not in the brief", ->
    Given ->
     @subject.job.creativeBrief = [@anotherFile]
     @expectedBrief = [@anotherFile]
    
    When -> @subject.removeItemFromData(@item, @type)
    Then -> expect(@subject.job.creativeBrief).toEqual(@expectedBrief)
 
 
  describe "when added to data for current medium photo", ->
   Given ->
    @type = 'currentMedium.photo'
    @subject.currentMedium = {data:{}}
    @item = {addedToData:true, file: {name: @file} }
    @subject.job.sessionId = 'anything'
    
   describe "and file is uploaded and deleted unsuccessfully", ->
    Given -> 
     @item['isUploaded'] = @item['isSuccess'] = true
     @succeedPromise = false
     @httpBackend.whenGET(/listdata*/).respond(200,{})
     spyOn(@mockNotifications,"error")
     
    When -> 
     @subject.removeItemFromData(@item, @type)
     @scope.$apply()
     
    Then -> expect(@mockUrlService.deleteItemFromServer).toHaveBeenCalledWith(@item, @subject.job.sessionId)
    Then -> expect(@mockNotifications.error).toHaveBeenCalledWith(@apiResponse)
   
   describe "and file is not uploaded", ->
    Given -> @item['isUploaded'] = false
    When -> @subject.removeItemFromData(@item, @type)
    Then -> expect(@mockUrlService.deleteItemFromServer).not.toHaveBeenCalledWith(@item, @subject.job.sessionId)
   
   describe "and the file is in the photos", ->
    Given ->
     @subject.currentMedium.data.photo = [@file,@anotherFile]
     @expectedBrief = [@anotherFile]
   
    When -> @subject.removeItemFromData(@item, @type)
    Then -> expect(@subject.currentMedium.data.photo).toEqual(@expectedBrief)
  
   describe "and the file is not in the brief", ->
    Given ->
     @subject.currentMedium.data.photo = [@anotherFile]
     @expectedBrief = [@anotherFile]
    
    When -> @subject.removeItemFromData(@item, @type)
    Then -> expect(@subject.currentMedium.data.photo).toEqual(@expectedBrief)

 
 describe "keyToHeader()", ->
  Given -> 
   @key = 'print-digital'
   @header = 'Print/Digital'
  When -> @result = @subject.keyToHeader(@key)
  Then -> expect(@result).toEqual(@header)
 
 describe "newMedium()", ->
  Given -> @somemedium = 'anything'
  When -> @result = @subject.newMedium(@somemedium)
  Then -> expect(@location.path()).toBe('/'+@somemedium)
 
 describe "getMediumListTemplate()", ->
  describe "with a key", ->
   Given -> 
    @somekey = 'key'
    @template = 'list/key-list.html'
   
   When -> @result = @subject.getMediumListTemplate(@somekey)
   
   Then -> expect(@result).toEqual(@template)
   
  describe "without key", ->
   Given -> 
    @somekey = ''
    @template = ''
   
   When -> @result = @subject.getMediumListTemplate(@somekey)
   
   Then -> expect(@result).toEqual(@template)
 
 describe "addCurrentMedium()", ->
  Given -> spyOn(@mockJob, 'addToCollateral')
   
  describe "when current medium is an actual medium", ->
   Given ->
    @sample = new @mockPrintDigital(true)
    @subject.currentMedium = @sample
    
   When -> @subject.addCurrentMedium()
   Then -> expect(@mockJob.addToCollateral).toHaveBeenCalledWith(@sample, undefined)
   Then -> expect(@mockJob.addToCollateral.callCount).toBe(1)
   
  describe "when current medium is an actual medium", ->
   Given ->
    @sample = null
    @subject.currentMedium = @sample
    
   When -> @subject.addCurrentMedium()
  
   Then -> expect(@mockJob.addToCollateral).not.toHaveBeenCalled()
   
 
 describe "getCurrentMedium()", ->
  describe "when location is /", ->
   Given -> @location.path('/')
   When -> @result = @subject.getCurrentMedium()
   Then -> expect(@result).toBe(null)
   
  describe "when location is /print-digital", ->
   describe "not using field marketing", ->
    Given -> 
     @location.path('/print-digital')
     @mockJob.fieldMarketing = 'Neither'
     
    When -> @result = @subject.getCurrentMedium()
    Then -> expect(@result.type).toBe('print-digital')
    Then -> expect(@result.useFieldMarketing).toBe(false)
    
   describe "using field marketing", ->
    Given -> 
     @location.path('/print-digital')
     @mockJob.fieldMarketing = 'Consultant'
     
    When -> @result = @subject.getCurrentMedium()
    Then -> expect(@result.type).toBe('print-digital')
    Then -> expect(@result.useFieldMarketing).toBe(true)
    
    
  describe "when location is /email", ->
   describe "not using field marketing", ->
    Given -> 
     @location.path('/email')
     @mockJob.fieldMarketing = 'Neither'
     
    When -> @result = @subject.getCurrentMedium()
    Then -> expect(@result.type).toBe('email')
    Then -> expect(@result.useFieldMarketing).toBe(false)
    
   describe "using field marketing", ->
    Given -> 
     @location.path('/email')
     @mockJob.fieldMarketing = 'Consultant'
     
    When -> @result = @subject.getCurrentMedium()
    Then -> expect(@result.type).toBe('email')
    Then -> expect(@result.useFieldMarketing).toBe(true)
    
  describe "when location is /microsite-splash", ->
   Given -> @location.path('/microsite-splash')
   When -> @result = @subject.getCurrentMedium()
   Then -> expect(@result.type).toBe('microsite-splash')
  
  describe "when location is /video", ->
   Given -> @location.path('/video')
   When -> @result = @subject.getCurrentMedium()
   Then -> expect(@result.type).toBe('video')
   
  describe "when location is /webinar", ->
   Given -> @location.path('/webinar')
   When -> @result = @subject.getCurrentMedium()
   Then -> expect(@result.type).toBe('webinar')
  
  describe "when location is /socialmedia", ->
   Given -> @location.path('/socialmedia')
   When -> @result = @subject.getCurrentMedium()
   Then -> expect(@result.type).toBe('socialmedia')
   
  describe "when location is has an index", ->
   Given -> 
    @location.path('/socialmedia/1')
    @subject.job.data.collateral = []
   
   describe "add a medium at that index exists", ->
    Given ->
     @newMedia = new @mocksocialmedia()
     @subject.job.data.collateral['socialmedia'] = [@newMedia]
     
    When -> @result = @subject.getCurrentMedium()
    Then -> expect(@result.type).toBe('socialmedia')
    Then -> expect(@result).toBe(@newMedia)
   
   describe "no medium at that index exists", ->
    Given ->
    When -> @result = @subject.getCurrentMedium()
    Then -> expect(@result).toBeNull
    Then -> expect(@location.path()).toEqual('/socialmedia')
 
 describe "next() with valid form", ->
  When -> @result = @subject.next(true)
  Then -> expect(@subject.submitted).toBe(true)
  
  describe "when current step is 0", ->
   Given -> @subject.currentStep = 0
   
   describe "with a single job", ->
    Given -> 
     spyOn(@mockNotifications,"error")
     @subject.job.multipleCollateral = "no"
    
    describe "and a medium is provided", ->
     Given ->
      medium = 'somemedium'
      @expectedTemplate = medium + ".html"
      @subject.job.medium = medium
      
     When -> 
      @result = @subject.next(false)
      #@scope.$digest()
      
     Then -> expect(@subject.currentStep).toBe(2)
     Then -> expect(@location.path()).toBe('/'+@subject.job.medium)
    
    describe "and medium is undefined", ->
     Given -> 
      medium = undefined
      @expectedTemplate = "step0.html"
      @subject.job.medium = medium
     
     When -> @result = @subject.next(false)
    
     Then -> expect(@subject.currentStep).toBe(0)
     Then -> expect(@location.path()).toBe('/')
     Then -> expect(@mockNotifications.error).toHaveBeenCalledWith("You must first select a medium for the job.")
    
    describe "and medium is empty", ->
     Given -> 
      medium = ''
      @expectedTemplate = "step0.html"
      @subject.job.medium = medium
     
     When -> @result = @subject.next(false)
    
     Then -> expect(@subject.currentStep).toBe(0)
     Then -> expect(@location.path()).toBe('/')
     Then -> expect(@mockNotifications.error).toHaveBeenCalledWith("You must first select a medium for the job.")
    
   describe "with multiple jobs", ->
    Given -> @subject.job.multipleCollateral = "yes"
    When -> @result = @subject.next(false)
   
    Then -> expect(@subject.currentStep).toBe(1)
    Then -> expect(@location.path()).toBe('/collateral')
    
  describe "when current step is 1", ->
   Given -> @subject.currentStep = 1
   When -> @result = @subject.next(false)
   Then -> expect(@subject.currentStep).toBe(3)
   Then -> expect(@location.path()).toBe('/complete')
   
  
   
