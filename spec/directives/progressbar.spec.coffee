describe "progress-bar", ->
 Given -> module('app')
 Given inject ($rootScope, $compile, $templateCache) ->
  @scope = $rootScope.$new()
  @compile = $compile
  @directiveTemplate =  null #'<div>this is my directive</div>'
  req = new XMLHttpRequest()
  req.onload = => @directiveTemplate = this.responseText
  req.open "get", "app/templates/directives/progressbar.html", false
  req.send()
  
  $templateCache.put('directives/progressbar.html', @directiveTemplate);
  
 Given ->
  @validTemplate = '<progress-bar current-step="data"></progress-bar>'
  @createDirective = (data, template) =>
    # Setup scope state
    @scope.data = data or @defaultData

    # Create directive
    elm = @compile(template or @validTemplate) @scope

    # Trigger watchers
    @scope.$digest()

    # Return
    elm
    
  @defaultData = 0
  # Provide any mocks needed
  #module ($provide) ->
   #$provide.value 'Name', new MockName()
   # Make sure CoffeeScript doesn't return anything
   #null
   
  # Inject in angular constructs otherwise,
  #  you would need to inject these into each test

 describe 'when created with 0', ->
  Given -> @element = @createDirective 0
  
  When -> 
   @labelText = @element.find('label').text()
   @spanWidth = @element.find('div').find('span')[0].attributes[1].nodeValue
   
  Then -> expect(@spanWidth).toBe 'width: 1%'
  Then -> expect(@labelText).toBe 'Step 1 of 2'

  describe "and current step changes to 1", ->
   Given -> 
    @scope.data = 1
    @scope.$digest()
    
   When -> 
    @labelText = @element.find('label').text()
    @spanWidth = @element.find('div').find('span')[0].attributes[1].nodeValue
    
   Then -> expect(@spanWidth).toBe 'width: 50%'
   Then -> expect(@labelText).toBe 'Step 2 of 2'
  
  describe "and current step changes to 2", ->
   Given -> 
    @scope.data = 2
    @scope.$digest()
    
   When -> 
    @labelText = @element.find('label').text()
    @spanWidth = @element.find('div').find('span')[0].attributes[1].nodeValue
    
   Then -> expect(@spanWidth).toBe 'width: 50%'
   Then -> expect(@labelText).toBe 'Step 2 of 2'
  
  describe "and current step changes to 3", ->
   Given -> 
    @scope.data = 3
    @scope.$digest()
    
   When -> 
    @labelText = @element.find('label').text()
    @spanWidth = @element.find('div').find('span')[0].attributes[1].nodeValue
    
   Then -> expect(@spanWidth).toBe 'width: 100%'
   Then -> expect(@labelText).toBe 'Complete!'
 
 describe 'should throw error when currentStep attribute not defined', ->
  When -> @invalidTemplate = ->
   @createDirective null, '<progress-bar></progress-bar>'
   # Note: older versions of Angular throw this error as: 'No controller: ngModel'
   # More recently it is: Controller 'ngModel', required by directive 'myDir', can't be found!
  Then -> expect(@invalidTemplate).toThrow()