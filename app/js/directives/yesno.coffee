angular.module('app').directive 'yesNo',  ->
  
 {
  restrict: 'E',
  require: 'ngModel',
  scope: { ngModel:"=", name: "@", label: "@", labelClass: "@", inputClass: "@" },
  replace: 'true',
  templateUrl: 'yesno.html'
 }