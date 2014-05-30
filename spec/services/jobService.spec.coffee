describe "jobService", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, job) ->
  @mockJob = job
  @subject = $injector.get 'jobService', {job:@mockJob}
  @expectedJob = new @mockJob
  @expectedJob.sessionId = @subject.sessionId
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject).toEqual(@expectedJob)
   
