angular.module('app').directive 'progressBar',  ->
  
 {
  restrict: 'E',
  require: 'step',
  scope: { currentStep: "=" },
  replace: 'true',
  #template: '<div>this is my directive</div>'
  templateUrl: 'directives/progressbar.html',
  controller: ($scope) ->
   $scope.step = ->
    if $scope.currentStep < 2
     $scope.currentStep + 1
    else
     2
   $scope.percentComplete = ->
    switch $scope.currentStep
     when 0 then p = 1
     when 1 then p = 50
     when 2 then p = 50
     when 3 then p = 100
    p
   $scope.label = ->
    s = $scope.step()
    if $scope.currentStep < 3
     'Step ' + s + ' of 2'
    else
     'Complete!'
 }