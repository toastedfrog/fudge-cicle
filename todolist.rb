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
	
	def item_complete(item_name)
		(get_item item_name).mark_complete
	end
	
	def item_incomplete(item_name)
		(get_item item_name).mark_incomplete
	end
	
	def complete?(item_name)
		(get_item item_name).completed_status
	end
	
	def print_list
		width = max_item_length
		puts format("%#{width}s", @title)
		@items.each do |item|
			item.print_item width
			puts "-"*item.description.length
		end
	end
	
	# utility
	
	def get_item(item_name)
		@items.bsearch {|item| item.description == item_name}
	end
	
	def max_item_length
		max_length = 0
		@items.each do |item|
			if item.description.length > max_length
				max_length = item.description.length
			end
		end
		max_length
	end
	
end

class Item
	attr_reader :description, :completed_status
	
	def initialize(item_description)
		@description = item_description
		@completed_status = false
	end
	
	def mark_complete
		@completed_status = true
	end
	
	def mark_incomplete
		@completed_status = false
	end
	
	# Print function
	def print_item(width = @description.length)
		separator_min_width = 3
		separator = "*"*(width-@description.length+separator_min_width)
		puts "#{@description}  #{separator}  #{@completed_status?"Complete":"Incomplete"}"
	end
	
end
