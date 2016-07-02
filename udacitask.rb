require_relative 'todolist.rb'

# Creates a new todo list
mylist = TodoList.new

# Add four new items
mylist.add "Meet Van Gogh", "Brush My Teeth", "Ride a Dinosaur", "Eat a Tuna Fish Sandwich"

# Print the list
mylist.print

# Delete the first item
mylist.delete 1

# Print the list
mylist.print

# Delete the second item
mylist.delete 2

# Print the list
mylist.print

# Update the completion status of the first item to complete
mylist.complete 1

# Print the list
mylist.print

# Update the title of the list
mylist.rename "Realistic Goals"

# Print the list
mylist.print
