class urlService
 constructor: (@$http, @$q) ->
  @jobRequestPostURL = 'http://23.21.222.201/mhe-backend/index.php'
  #@jobRequestPostURL = 'http://mh-jobwebform-backend.dev/index.php'
  #@jobRequestPostURL = '/'
  
 
 postJobRequestData: (data, sessionId) ->
  #@$http.post(@jobRequestPostURL, data)
  
  d = @$q.defer()
   
  successFn = (response) =>
   results = 'Your job was successfully posted.'
   d.resolve results
  errorFn = (response) =>
   message = response
   switch response.status
    when 500 then message = "The server gave an error."
    when 401 then message = "This form is not authorized to post."
    when 404 then message = "Could not find the posting page."
    
   d.reject "There was a problem posting your job. " + message
   
  @$http.post(@jobRequestPostURL + '?action=sendjob&sessionId='+sessionId, {data:data}).then successFn, errorFn  
  d.promise
  
 
 deleteItemFromServer: (item, sessionId) ->
  d = @$q.defer()
   
  successFn = (response) =>
   results = 'The file was successfully deleted.'
   d.resolve results
  errorFn = (response) =>
   message = ''
   switch response.status
    when 500 then message = "The server gave an error."
    when 401 then message = "This user is not authorized to delete."
    when 404 then message = "Could not find the posting page."
    when 413 then message = "The request was too large."
    
   d.reject "There was a problem deleting the file. " + message
   
  @$http.delete(@jobRequestPostURL + '?action=upload&name='+ item.file.name + '&sessionId=' + sessionId ).then successFn, errorFn  
  d.promise
  

angular.module('app').service 'urlService', ['$http', '$q', ($http, $q) ->
 new urlService($http, $q)
]