angular.module('app').directive 'help',  ->
  
 {
  restrict: 'E',
  require: 'currentStep',
  scope: { currentStep: "=" , text: '='},
  replace: 'true',
  templateUrl: 'help.html',
  controller: ($scope) ->
   $scope.step = ->
    switch $scope.currentStep
     when 0 then s = "One"
     else
      s = "Two"
    s 
     
   $scope.label = ->
    s = $scope.step()
    if $scope.currentStep < 3
     'Step ' + s + ' of Two'
    else 
     ''

 }