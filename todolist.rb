class TodoList
	attr_reader :title, :items

	def initialize(list_title = "New Todo")
		@title = list_title
		@items = Array.new
	end
	
	# Accepts an array of descriptor strings
	def add(*list)
		list.each do |new_item|
			item = Item.new(new_item)
			@items.push(item)
		end
	end
	
	# Accepts item numbers or descriptor strings
	def delete(*list)
		list.each do |list_item|
			if list_item.is_a? String
				@items.delete_if { |todo_item| todo_item.description == list_item }
			elsif list_item.is_a? Integer
				@items.delete_at list_item-1
			end
		end
	end
	
	def rename(new_name)
		@title = new_name
	end
	
	# Marks an item complete; accepts item number or descriptor
	def complete(item)
		if item.is_a? Integer
			@items[item-1].mark_complete
		elsif item.is_a? String
			(get_item item).mark_complete
		end
	end
	
	# Marks an item incomplete; accepts item number or descriptor
	def incomplete(item)
		if item.is_a? Integer
			@items[item-1].mark_incomplete
		elsif item.is_a? String
			(get_item item).mark_incomplete
		end
	end
	
	# Returns true/false if an item is complete; accepts item number or descriptor
	def complete?(item)
		if item.is_a? Integer
			@items[item-1].completed_status
		elsif item.is_a? String
			(get_item item).completed_status
		end
	end
	
	# Pretty-prints the list
	def print(spaces = 1, min_separator = 3)
		description_length = max_item_length
		width = description_length+spaces*2+min_separator+"Incomplete".length
		title_position = (width+@title.length)/2
		puts format("%#{title_position}s", "-"*@title.length)
		puts format("%#{title_position}s", @title)
		puts format("%#{title_position}s", "-"*@title.length)
		@items.each_index do |index|
			@items[index].print_item index+1, description_length, spaces, min_separator
		end
	end
	
	# Marshals the object and saves to a file
	def save(filename = "#{@title}.todo")
		File.open(filename, "w+") {|f| f.write(Marshal.dump(self))}
	end
	
	# Reconstitutes an object from file and replaces instance data with file data
	def load(filename = "#{@title}.todo")
		loaded_todo = Marshal.load(File.read(filename))
		@title = loaded_todo.title
		@items.clear
		loaded_todo.items.each { |item| @items.push item }
	end
	
	# Alphabetizes the list by description
	def sort_description
		@items.sort_by! {|item| item.description}
	end
	
	# Sorts the list by completeness
	def sort_complete
		@items.sort_by! {|item| item.completed_status ? "B" : "A"}
	end
	
	# Utility functions
	# ******
	# Retrieve item instance by description name
	def get_item(item_name)
		index = 0
		until (@items[index].description == item_name) || (index >= @items.length)
			index += 1
		end
		index >= @items.length ? nil : @items[index]
	end
	
	# Find the maximum item description length in the list
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

	# Sets the completion status to true	
	def mark_complete
		@completed_status = true
	end
	
	# Sets the completion status to false
	def mark_incomplete
		@completed_status = false
	end
	
	# Print function; minimum separator width is set by a variable
	def print_item(item_num = "", width = @description.length, spacing = 2, min_separator = 3)
		separator = "*"*(width-@description.length+min_separator)
		spaces = " "*spacing
		puts "#{format("%-3s",item_num)}#{@description}#{spaces}#{separator}#{spaces}#{@completed_status?"Complete":"Incomplete"}"
			puts " "*3+"-"*@description.length
	end
	
end
