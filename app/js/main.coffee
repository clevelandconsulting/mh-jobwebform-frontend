angular.module "app", ['ngRoute']

angular.module('app').run ['$rootScope', '$timeout', ($rootScope, $timeout) ->
 $rootScope.$on '$viewContentLoaded', ->
  t = -> $(document).foundation()
  $timeout t, 500 
]