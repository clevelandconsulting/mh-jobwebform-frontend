describe "jobService", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, job) ->
  @mockJob = job
  @subject = $injector.get 'jobService', {job:@mockJob}
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject).toEqual(new @mockJob)
   
