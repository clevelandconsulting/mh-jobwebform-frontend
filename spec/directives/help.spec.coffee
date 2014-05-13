describe "help", ->
 Given -> module('app')
 Given inject ($rootScope, $compile, $templateCache) ->
  @scope = $rootScope.$new()
  @compile = $compile
  @directiveTemplate =  null #'<div>this is my directive</div>'
  req = new XMLHttpRequest()
  req.onload = => @directiveTemplate = this.responseText
  req.open "get", "app/templates/help.html", false
  req.send()
  
  $templateCache.put('help.html', @directiveTemplate);
  
 Given ->
  @validTemplate = '<help current-step="step" text="data"></help>'
  @createDirective = (step, data, template) =>
   # Setup scope state
   @scope.data = data or @defaultData
   @scope.step = step or @defaultStep
   # Create directive
   elm = @compile(template or @validTemplate) @scope

   # Trigger watchers
   @scope.$digest()

   # Return
   elm
    
  @defaultStep = 0
  @defaultData = 'hahaha'
  # Provide any mocks needed
  #module ($provide) ->
   #$provide.value 'Name', new MockName()
   # Make sure CoffeeScript doesn't return anything
   #null
   
  # Inject in angular constructs otherwise,
  #  you would need to inject these into each test

 describe 'when created with 0', ->
  Given -> @element = @createDirective 0
  When -> @labelText = @element.find('h4').text()
  Then -> expect(@labelText).toBe 'Step One of Two'

  describe "and current step changes to 1", ->
   Given -> 
    @scope.step = 1
    @scope.$digest()
    
   When -> @labelText = @element.find('h4').text()
   Then -> expect(@labelText).toBe 'Step Two of Two'
  
  describe "and current step changes to 2", ->
   Given -> 
    @scope.step = 2
    @scope.$digest()
    
   When -> @labelText = @element.find('h4').text()
   Then -> expect(@labelText).toBe 'Step Two of Two'
  
  describe "and current step changes to 3", ->
   Given -> 
    @scope.step = 3
    @scope.$digest()
    
   When -> @labelText = @element.find('h4').text()
   Then -> expect(@labelText).toBe ''
 
 describe 'should throw error when currentStep attribute not defined', ->
  When -> @invalidTemplate = ->
   @createDirective null, '<help></help>'
   # Note: older versions of Angular throw this error as: 'No controller: ngModel'
   # More recently it is: Controller 'ngModel', required by directive 'myDir', can't be found!
  Then -> expect(@invalidTemplate).toThrow()