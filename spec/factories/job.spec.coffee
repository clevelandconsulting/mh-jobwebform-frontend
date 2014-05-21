describe "job", ->
 Given -> module 'app'
 Given angular.mock.inject ($injector, printdigital) ->
  @mockPrintDigital = printdigital
  @subjectClass = $injector.get 'job'
  @subject = new @subjectClass()
  today = new Date()
  dd = today.getDate()
  if dd < 10
   dd = '0'+dd
  mm = today.getMonth()+1
  if mm < 10
   mm = '0' + mm
  yyyy = today.getFullYear()
  @expectedDate = yyyy + '-' + mm + '-' + dd
  
 Then -> expect(@subject).toBeDefined()
 Then -> expect(@subject.mediums).toEqual({})
 Then -> expect(@subject.data.collateral).toEqual({})
 Then -> expect(@subject.data.requestDate).toEqual(@expectedDate)
 
 describe "isValidForSubmission()", ->
  Given -> 
   @foo = 'foo'
   @foo2 = 'foo2'
  describe "when has all required base data", ->
   Given ->
    @subject.requestorName = @foo
    @subject.fieldMarketing = true
    @subject.product = @foo
    @subject.costCenter = @foo
    
   describe "and single collateral", ->
    Given -> 
     @subject.multipleCollateral = 'no'
    
    describe "that is valid", ->
     Given ->
      @subject.medium = @foo 
      @subject.data.collateral[@foo] = @foo
      
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(true)
     
    describe "that is invalid", ->
     Given ->
      @subject.medium = @foo 
      @subject.data.collateral[@foo] = undefined
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
    describe "that has an undefined medium", ->
     Given -> @subject.medium = undefined 
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
    describe "that is missing a medium", ->
     Given -> @subject.medium = '' 
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
   describe "and multiple collateral", ->
    Given ->
     @subject.multipleCollateral = 'yes'
     @subject.data.mediums[@foo] = true
     @subject.data.mediums[@foo2] = true
    
    describe "that are all valid", ->
     Given -> 
      @subject.data.collateral[@foo] = @foo
      @subject.data.collateral[@foo2] = @foo2
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(true)
    
    describe "that has one invalid", ->
     Given -> 
      @subject.data.collateral[@foo] = @foo
      @subject.data.collateral[@foo2] = undefined
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
    describe "that has all invalid", ->
     Given -> 
      @subject.data.collateral[@foo] = undefined
      @subject.data.collateral[@foo2] = undefined
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
    describe "that has an undefined mediums", ->
     Given -> @subject.mediums = undefined 
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
    describe "that is missing any medium", ->
     Given -> @subject.mediums = [] 
     When -> @result = @subject.isValidForSubmission()
     Then -> expect(@result).toBe(false)
    
  describe "when has correct medium", ->
   Given ->
    @subject.medium = @foo
    @subject.multipleCollateral = 'no'
    @subject.data.collateral[@foo] = @foo
    
   describe "but is missing requestor name", ->
    Given ->
     @subject.fieldMarketing = true
     @subject.product = @foo
     @subject.costCenter = @foo
     
    When -> @result = @subject.isValidForSubmission()
    Then -> expect(@result).toBe(false)
   
   describe "but is missing field marketing", ->
    Given ->
     @subject.requestorName = @foo
     @subject.product = @foo
     @subject.costCenter = @foo
     
    When -> @result = @subject.isValidForSubmission()
    Then -> expect(@result).toBe(false)
   
   describe "but is missing product", ->
    Given ->
     @subject.requestorName = @foo
     @subject.fieldMarketing = true
     @subject.costCenter = @foo
     
    When -> @result = @subject.isValidForSubmission()
    Then -> expect(@result).toBe(false)
   
   describe "but is missing cost center", ->
    Given ->
     @subject.requestorName = @foo
     @subject.fieldMarketing = true
     @subject.product = @foo
     
    When -> @result = @subject.isValidForSubmission()
    Then -> expect(@result).toBe(false)
    
     
 
 describe "addToCollateral()", ->
  Given -> @subject.data.collateral = {} 
   
  describe "with an actual medium object", ->
   Given ->
    @sample = new @mockPrintDigital(true)
    @expectedCollateral = {'print-digital':[@sample]}
   
   When -> @subject.addToCollateral(@sample)
   Then -> expect(@subject.data.collateral).toEqual(@expectedCollateral)
  
  describe "removeFromCollateral()", ->
  
  
  describe "with an actual medium object and an index that exists", ->
   Given ->
    @sample = new @mockPrintDigital(true)
    @subject.data.collateral = {'print-digital':[@sample,@sample]}
    @newMock = new @mockPrintDigital(false)
    @expectedCollateral = {'print-digital':[@sample,@newMock]}
   
   When -> @subject.addToCollateral(@newMock,1)
   Then -> expect(@subject.data.collateral).toEqual(@expectedCollateral)
  
  describe "without an actual medium object", ->
   Given ->
    @sample = 'something'
    @expectedCollateral = {}
   
   When -> @fn = => @subject.addToCollateral(@sample)
   Then -> expect(@fn).toThrow('You can only add mediums as collateral!')
  
 describe "getters and setters", ->
  Given -> 
   @subject.data = {}
   @somedata = 'data'
   
  describe 'requestorName', ->
   When -> @subject.requestorName = @somedata
   Then -> expect(@subject.data.requestorName).toBe(@somedata)
   Then -> expect(@subject.requestorName).toBe(@somedata)
  
  describe 'requestDate', ->
   When -> @subject.requestDate = @somedata
   Then -> expect(@subject.data.requestDate).toBe(@somedata)
   Then -> expect(@subject.requestDate).toBe(@somedata)
  
  describe 'fieldMarketing', ->
   When -> @subject.fieldMarketing = @somedata
   Then -> expect(@subject.data.fieldMarketing).toBe(@somedata)
   Then -> expect(@subject.fieldMarketing).toBe(@somedata)
  
  describe 'product', ->
   When -> @subject.product = @somedata
   Then -> expect(@subject.data.product).toBe(@somedata)
   Then -> expect(@subject.product).toBe(@somedata)
 
  describe 'portfolio', ->
   When -> @subject.portfolio = @somedata
   Then -> expect(@subject.data.portfolio).toBe(@somedata)
   Then -> expect(@subject.portfolio).toBe(@somedata)
   
  describe 'costCenter', ->
   When -> @subject.costCenter = @somedata
   Then -> expect(@subject.data.costCenter).toBe(@somedata)
   Then -> expect(@subject.costCenter).toBe(@somedata)
  
  describe 'discipline', ->
   When -> @subject.discipline = @somedata
   Then -> expect(@subject.data.discipline).toBe(@somedata)
   Then -> expect(@subject.discipline).toBe(@somedata)
  
  describe 'multipleCollateral', ->
   When -> @subject.multipleCollateral = @somedata
   Then -> expect(@subject.data.multipleCollateral).toBe(@somedata)
   Then -> expect(@subject.multipleCollateral).toBe(@somedata)

  describe 'multipleCollateralType', ->
   When -> @subject.multipleCollateralType = @somedata
   Then -> expect(@subject.data.multipleCollateralType).toBe(@somedata)
   Then -> expect(@subject.multipleCollateralType).toBe(@somedata)
  
  describe 'mediums', ->
   When -> @subject.mediums = @somedata
   Then -> expect(@subject.data.mediums).toBe(@somedata)
   Then -> expect(@subject.mediums).toBe(@somedata)
       
    
  describe 'medium', ->
   When -> @subject.medium = @somedata
   Then -> expect(@subject.data.medium).toBe(@somedata)
   Then -> expect(@subject.medium).toBe(@somedata)
  
  describe 'title', ->
   When -> @subject.title = @somedata
   Then -> expect(@subject.data.title).toBe(@somedata)
   Then -> expect(@subject.title).toBe(@somedata)
   
  describe 'relationshipManager', ->
   When -> @subject.relationshipManager = @somedata
   Then -> expect(@subject.data.relationshipManager).toBe(@somedata)
   Then -> expect(@subject.relationshipManager).toBe(@somedata)
  
  describe 'productManager', ->
   When -> @subject.productManager = @somedata
   Then -> expect(@subject.data.productManager).toBe(@somedata)
   Then -> expect(@subject.productManager).toBe(@somedata)
  
  describe 'districtManager', ->
   When -> @subject.districtManager = @somedata
   Then -> expect(@subject.data.districtManager).toBe(@somedata)
   Then -> expect(@subject.districtManager).toBe(@somedata)
 
 describe "hasMultipleComponents()", ->
  Given -> @subject.data = {}   
  
  describe "when form data has yes", ->
   Given -> @subject.multipleCollateral = 'yes'
   When -> @result = @subject.hasMultipleComponents()
   Then -> expect(@result).toBe(true)
   
  describe "when form data has no", ->
   Given -> @subject.multipleCollateral = 'no'
   When -> @result = @subject.hasMultipleComponents()
   Then -> expect(@result).toBe(false)
  
  describe "when form data has undefined", ->
   When -> @result = @subject.hasMultipleComponents()
   Then -> expect(@result).toBe(false)
 
 describe "noMediums() with nothing", ->
  Given -> @subject.data = {mediums:{}}
  When -> @result = @subject.noMediums()
  Then -> expect(@result).toBe(true)
  
 describe "noMediums() with everything true", ->
  Given -> @subject.data = {mediums:{'somemedium':true}}
  When -> @result = @subject.noMediums()
  Then -> expect(@result).toBe(false)
 
 describe "noMediums() with everything false", ->
  Given -> @subject.data = {mediums:{'somemedium':false}}
  When -> @result = @subject.noMediums()
  Then -> expect(@result).toBe(true)
  
 describe "isFieldMarketing()", ->
  Given -> @subject.data = {}   
  
  describe "when form data has Sales Rep", ->
   Given -> @subject.fieldMarketing = 'Sales Rep'
   When -> @result = @subject.isFieldMarketing()
   Then -> expect(@result).toBe(true)
   
  describe "when form data has sales rep", ->
   Given -> @subject.fieldMarketing = 'sales rep'
   When -> @result = @subject.isFieldMarketing()
   Then -> expect(@result).toBe(true)
   
  describe "when form data has Consultant", ->
   Given -> @subject.fieldMarketing = 'Consultant'
   When -> @result = @subject.isFieldMarketing()
   Then -> expect(@result).toBe(true)
   
  describe "when form data has consultant", ->
   Given -> @subject.fieldMarketing = 'consultant'
   When -> @result = @subject.isFieldMarketing()
   Then -> expect(@result).toBe(true)
   
  describe "when form data has Neither", ->
   Given -> @subject.fieldMarketing = 'Neither'
   When -> @result = @subject.isFieldMarketing()
   Then -> expect(@result).toBe(false)
  
  describe "when form data has undefined", ->
   When -> @result = @subject.isFieldMarketing()
   Then -> expect(@result).toBe(false)