class urlService
 constructor: (@$http, @$q) ->
  @jobRequestPostURL = 'http://localhost:8000/jobpost'
 
 postJobRequestData: (data) ->
  #@$http.post(@jobRequestPostURL, data)
  
  d = @$q.defer()
   
  successFn = (response) =>
   results = 'Your job was successfully posted.'
   d.resolve results
  errorFn = (response) =>
   switch response.status
    when 500 then message = "The server gave an error."
    when 401 then message = "This form is not authorized to post."
    when 404 then message = "Could not find the posting page."
    
   d.reject "There was a problem posting your job. " + message
   
  @$http.post(@jobRequestPostURL, data).then successFn, errorFn  
  d.promise
  

angular.module('app').service 'urlService', ['$http', '$q', ($http, $q) ->
 new urlService($http, $q)
]