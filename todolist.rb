class TodoList
	attr_reader :title, :items

	def initialize(list_title)
		@title = list_title
		@items = Array.new
	end
	
	def add_item(new_item)
		item = Item.new(new_item)
		@items.push(item)
	end
	
end

class Item
	attr_reader :description, :completed_status
	
	def initialize(item_description)
		@description = item_description
		@completed_status = false
	end
end
