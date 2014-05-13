angular.module('app').service 'mediumList', ['dropdown', (dropdown) ->
 
 mediumList = new dropdown()
 
 mediumList.add('Print/Digital', 'print-digital')
 mediumList.add('Email', 'email')
 mediumList.add('Microsite/Splash','microsite-splash')
 mediumList.add('Video', 'video')
 mediumList.add('Webinar', 'webinar')
 mediumList.add('Social Media', 'socialmedia')
 
 return mediumList;

]