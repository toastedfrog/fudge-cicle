require_relative 'todolist.rb'

# Creates a new todo list
mylist = TodoList.new

# Add four new items
mylist.add_item "Turn Into a Dolphin", "Rob a Bank", "Eat a Tuna Fish Sandwich", "Meet Van Gogh"

# Print the list
mylist.print_list

# Delete the first item
mylist.delete_item 0

# Print the list
mylist.print_list

# Delete the second item
mylist.delete_item 1

# Print the list
mylist.print_list

# Update the completion status of the first item to complete
mylist.item_complete 0

# Print the list
mylist.print_list

# Update the title of the list
mylist.rename "Things I'm Going to Accomplish on Tuesday"

# Print the list
mylist.print_list
