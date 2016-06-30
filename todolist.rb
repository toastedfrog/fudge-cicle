class TodoList
	attr_reader :title, :items

	def initialize(list_title = "New Todo")
		@title = list_title
		@items = Array.new
	end
	
	def add_item(*list)
		list.each do |new_item|
			item = Item.new(new_item)
			@items.push(item)
		end
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
	
	def item_complete(item)
		if item.is_a? Integer
			@items[item].mark_complete
		elsif item.is_a? String
			(get_item item).mark_complete
		end
	end
	
	def item_incomplete(item)
		if item.is_a? Integer
			@items[item].mark_incomplete
		elsif item.is_a? String
			(get_item item).mark_incomplete
		end
	end
	
	def complete?(item)
		if item.is_a? Integer
			@items[item].completed_status
		elsif item.is_a? String
			(get_item item).completed_status
		end
	end
	
	def print_list
		width = max_item_length
		puts format("%#{width}s", @title)
		@items.each do |item|
			item.print_item width
			puts "-"*item.description.length
		end
	end
	
	def save_list(filename = "#{@title}.todo")
		#save_file = File.new(filename, "w+")
		#file_string = Marshal.dump(self)
		#save_file << file_string
		#save_file.close
		File.open(filename, "w+") {|f| f.write(Marshal.dump(self))}
	end
	
	def load_list(filename = "listfile.todo")
		#load_file = File.open(filename, "r")
		#file_string = load_file.read
		#self << Marshal.load(file_string)
		#load_file.close
		loaded_todo = Marshal.load(File.read(filename))
		@title = loaded_todo.title
		@items.clear
		loaded_todo.items.each { |item| @items.push item }
	end
	
	# utility functions
	
	# retrieve item instance by description name
	def get_item(item_name)
		index = 0
		until (@items[index].description == item_name) || (index >= @items.length)
			index += 1
		end
		index >= @items.length ? nil : @items[index]
	end
	
	# sort out the maximum item description length
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
