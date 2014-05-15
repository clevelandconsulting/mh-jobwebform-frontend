describe 'utilities', ->
 Given -> module 'app'
 Given angular.mock.inject ($injector) ->
  @subject = $injector.get 'utilities', 


 describe "toggle()", ->
  Given -> 
   @list = [{value:'test'},{value:'ha'},{value:'blah'}]
   @selectedItems = ['test']
  
  describe "when removing to the list", ->
   Given -> 
    @newItem = 0
    @expectedItems = []
   
   When -> @result = @subject.toggle(@list, @selectedItems, @newItem)

   Then -> expect(@result).toEqual(@expectedItems)
  
  describe "when adding to the list", ->
   Given -> 
    @newItem = 2
    @expectedItems = ['test','blah']
   
   When -> @result = @subject.toggle(@list, @selectedItems, @newItem)

   Then -> expect(@result).toEqual(@expectedItems)
  
  describe "with invalid index", ->
   Given -> 
    @newItem = 3
    @expectedItems = ['test']
   
   When -> @result = @subject.toggle(@list, @selectedItems, @newItem)

   Then -> expect(@result).toEqual(@expectedItems)
  
  describe "when adding to the list when no selected items", ->
   Given -> 
    @newItem = 2
    @selectedItems = undefined
    @expectedItems = ['blah']
   
   When -> @result = @subject.toggle(@list, @selectedItems, @newItem)

   Then -> expect(@result).toEqual(@expectedItems)