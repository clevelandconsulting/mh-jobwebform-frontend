describe "routes", ->
 Given -> module('app')
 Given inject ($route) ->
  @route = $route

 Then -> expect(@route).toBeDefined()

 describe "main route", ->
  When -> @mainRoute = @route.routes['/']
  Then -> expect(@mainRoute.controller).toBe('jobrequestController')
  Then -> expect(@mainRoute.templateUrl).toBe('main.html')

 describe "collateral route", ->
  When -> @collateralRoute = @route.routes['/collateral']
  Then -> expect(@collateralRoute.controller).toBe('jobrequestController')
  Then -> expect(@collateralRoute.templateUrl).toBe('main.html')
  
 describe "submit route", ->
  When -> @collateralRoute = @route.routes['/submit/:test?']
  Then -> expect(@collateralRoute.controller).toBe('jobsubmissionController')
  Then -> expect(@collateralRoute.templateUrl).toBe('main.html')

 describe "default route", ->
  When -> @defaultRoute = @route.routes[null]
  Then -> expect(@defaultRoute.redirectTo).toBe('/')