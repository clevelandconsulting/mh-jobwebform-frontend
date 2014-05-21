angular.module('app').directive 'selectList', ['utilities', (utilities) ->
  
 {
  restrict: 'E',
  require: 'ngModel',
  scope: { ngModel:"=", items: "=" },
  replace: 'true',
  templateUrl: 'directives/selectlist.html'
  controller: ($scope, utilities) ->
   $scope.toggle = (index) ->
    $scope.ngModel = utilities.toggle($scope.items,$scope.ngModel,index)

 }
 
]