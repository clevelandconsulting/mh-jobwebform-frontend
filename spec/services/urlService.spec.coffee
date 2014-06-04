describe "urlService", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, $http, $httpBackend, $rootScope) ->
  @mockHttp = $http
  @mockHttpBackend = $httpBackend
  @rootScope = $rootScope
  @sessionId = 'anything'
  @subject = $injector.get 'urlService', {$http:@mockHttp}
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.$http).toBe(@mockHttp)
 Then -> expect(@subject.jobRequestPostURL).toBeDefined()
 
 describe "postJobRequestData()", ->
  Given ->
   @someURL = 'http://foo'
   @action = '?action=sendjob&sessionId=' + @sessionId
   @someData = 'foo'
   @subject.jobRequestPostURL = @someURL
   
  describe "successfully posted", ->
   Given -> @mockHttpBackend.whenPOST(@someURL+@action).respond(200, {})
   
   When -> 
    @promise = @subject.postJobRequestData(@someData, @sessionId)
    @promise.then (response) => @result = response
    
    @mockHttpBackend.flush()
    @rootScope.$apply()
    
   Then -> @mockHttpBackend.expectPOST(@someURL+@action,@someData)
   Then -> expect(@result).toEqual("Your job was successfully posted.")
  
  describe "server error when posting", ->
   Given -> @mockHttpBackend.whenPOST(@someURL+@action).respond(500, {})
   
   When -> 
    success = ->
    @promise = @subject.postJobRequestData(@someData, @sessionId)
    @promise.then success, (response) => @result = response
    
    @mockHttpBackend.flush()
    @rootScope.$apply()
    
   Then -> @mockHttpBackend.expectPOST(@someURL+@action,@someData)
   Then -> expect(@result).toEqual("There was a problem posting your job. The server gave an error.")
   
 
 describe "deleteItemFromServer()", ->
  Given ->
   @file = 'anything here'
   @item = {isUploaded:true, file: {name: @file} }   
   @uploadPath = @subject.jobRequestPostURL + '?action=upload&name=' + @file + '&sessionId=' + @sessionId
  
  describe "with a successful response", ->
   #@mockHttpBackend.whenDELETE(@uploadPath)
   Given ->
    @response = 'The file was successfully deleted.' 
    @mockHttpBackend.whenDELETE(@uploadPath).respond(204,'')
    @mockHttpBackend.expectDELETE(@uploadPath)
   
   When -> 
    @promise = @subject.deleteItemFromServer(@item, @sessionId)
    @promise.then (response) => @result = response
    
    @mockHttpBackend.flush()
    @rootScope.$apply()
    
   Then -> @mockHttpBackend.verifyNoOutstandingExpectation()
   Then -> expect(@result).toEqual(@response)
   
  describe "with an unsuccessful response", ->
   #@mockHttpBackend.whenDELETE(@uploadPath)
   Given ->
    @success = ->
    @response = 'There was a problem deleting the file. The server gave an error.' 
    @mockHttpBackend.whenDELETE(@uploadPath).respond(500,'')
    @mockHttpBackend.expectDELETE(@uploadPath)
   
   When -> 
    @promise = @subject.deleteItemFromServer(@item, @sessionId)
    @promise.then @success, (response) => @result = response
    
    @mockHttpBackend.flush()
    @rootScope.$apply()
    
   Then -> @mockHttpBackend.verifyNoOutstandingExpectation()
   Then -> expect(@result).toEqual(@response)

