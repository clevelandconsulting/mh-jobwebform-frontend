angular.module "app", ['ngRoute', 'angularFileUpload', 'uuid', 'ng.deviceDetector']

angular.module('app').run ['$rootScope', '$timeout', ($rootScope, $timeout) ->
 $rootScope.$on '$viewContentLoaded', ->
  t = -> $(document).foundation()
  $timeout t, 500 
]

###
angular.module('app').config ['$compileProvider', ($compileProvider) ->
  $compileProvider.debugInfoEnabled(false)
]
###