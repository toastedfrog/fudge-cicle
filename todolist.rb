class TodoList
	attr_reader :title, :items

	def initialize(list_title)
		@title = list_title
		@items = Array.new
	end
	
end

class Item
    # methods and stuff go here
end
