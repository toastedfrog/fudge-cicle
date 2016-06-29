class TodoList
	attr_reader :title, :items

	def initialize(list_title = "New Todo")
		@title = list_title
		@items = Array.new
	end
	
	def add_item(new_item)
		item = Item.new(new_item)
		@items.push(item)
	end
	
	def delete_item(*list)
		list.each do |list_item|
			if list_item.is_a? String
				@items.delete_if { |todo_item| todo_item.description == list_item }
			elsif list_item.is_a? Integer
				@items.delete_at list_item
			end
		end
	end
	
	def rename(new_name)
		@title = new_name
	end
	
end

class Item
	attr_reader :description, :completed_status
	
	def initialize(item_description)
		@description = item_description
		@completed_status = false
	end
end
