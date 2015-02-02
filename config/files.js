/* Exports a function which returns an object that overrides the default &
 *   plugin file patterns (used widely through the app configuration)
 *
 * To see the default definitions for Lineman's file paths and globs, see:
 *
 *   - https://github.com/linemanjs/lineman/blob/master/config/files.coffee
 */
module.exports = function(lineman) {
  //Override file patterns here
  return {

    // As an example, to override the file patterns for
    // the order in which to load third party JS libs:
    //
    coffee: {
	    app: [
    	 	"app/js/main.coffee",
    	 	"app/js/**/*.coffee"
    	]
    },
    js: {
    	vendor: [
    	    //"vendor/bower/js-base64/base64.js",
    	    "vendor/bower/jquery/dist/jquery.js",
    	    "vendor/bower/toastr/toastr.js",
    	    "vendor/underscore/underscore.js",
         "vendor/bower/angular/angular.js",
         "vendor/bower/modernizr/modernizr.js",
         "vendor/bower/foundation/js/foundation.js",
         "vendor/bower/foundation/js/foundation.abide.js",
         "vendor/bower/autofill-event/src/autofill-event.js",
         "vendor/bower/angular-route/angular-route.js",
         "vendor/bower/angular-file-upload/angular-file-upload.js",
         "vendor/bower/ng-device-detector/ng-device-detector.js",
         "vendor/bower/angular-uuid-service/uuid-svc.js",
         "vendor/bower/angular-base64/angular-base64.js",
         "vendor/js/**/*.js"  //Note that this glob remains for traditional vendor libs
     ],
     specHelpers: [
         "vendor/bower/angular-mocks/angular-mocks.js",
         "spec/helpers/**/*.js"
     ]
    },
    sass: {
      vendor: [
         "vendor/bower/foundation/scss/normalize.scss",
         "vendor/bower/foundation/scss/foundation.scss",
         "vendor/fonts/foundation-general-enclosed/sass/general_enclosed_foundicons_ie7.scss",
         "vendor/fonts/foundation-general-enclosed/sass/general_enclosed_foundicons.scss"
      ]  
    },
    css: {
      vendor: [
         "vendor/bower/toastr/toastr.css"
      ]
    }
    
  };
};
