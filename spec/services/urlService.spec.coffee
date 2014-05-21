describe "urlService", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, $http, $httpBackend, $rootScope) ->
  @mockHttp = $http
  @mockHttpBackend = $httpBackend
  @rootScope = $rootScope
  @subject = $injector.get 'urlService', {$http:@mockHttp}
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.$http).toBe(@mockHttp)
 Then -> expect(@subject.jobRequestPostURL).toBeDefined()
 
 describe "postJobRequestData()", ->
  Given ->
   @someURL = 'http://foo'
   @someData = 'foo'
   @subject.jobRequestPostURL = @someURL
   
  describe "successfully posted", ->
   Given -> @mockHttpBackend.whenPOST(@someURL).respond(200, {})
   
   When -> 
    @promise = @subject.postJobRequestData(@someData)
    @promise.then (response) => @result = response
    
    @mockHttpBackend.flush()
    @rootScope.$apply()
    
   Then -> @mockHttpBackend.expectPOST(@someURL,@someData)
   Then -> expect(@result).toEqual("Your job was successfully posted.")
  
  describe "server error when posting", ->
   Given -> @mockHttpBackend.whenPOST(@someURL).respond(500, {})
   
   When -> 
    success = ->
    @promise = @subject.postJobRequestData(@someData)
    @promise.then success, (response) => @result = response
    
    @mockHttpBackend.flush()
    @rootScope.$apply()
    
   Then -> @mockHttpBackend.expectPOST(@someURL,@someData)
   Then -> expect(@result).toEqual("There was a problem posting your job. The server gave an error.")