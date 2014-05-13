angular.module('app').config ['$routeProvider', (routeProvider) ->
 routeProvider
 .when('/', {controller:'jobrequestController', templateUrl:'main.html'})
 .when('/collateral', {controller:'jobrequestController', templateUrl: 'main.html'})
 .when('/print-digital/:index?',{controller:'jobrequestController', templateUrl: 'main.html'})
 .when('/webinar/:index?',{controller:'jobrequestController', templateUrl: 'main.html'})
 .when('/email/:index?',{controller:'jobrequestController', templateUrl: 'main.html'})
 .when('/socialmedia/:index?',{controller:'jobrequestController', templateUrl: 'main.html'})
 .when('/video/:index?',{controller:'jobrequestController', templateUrl: 'main.html'})
 .when('/microsite-splash/:index?',{controller:'jobrequestController', templateUrl: 'main.html'})
 .otherwise {redirectTo:'/'}
]
###
angular.module('app').run [ '$rootScope', '$location', 'routeValidation', ($roo$

 routeValidation.addNonValidationRoute '/'

 $rootScope.$on '$locationChangeStart', routeValidation.validateRoute

]
###