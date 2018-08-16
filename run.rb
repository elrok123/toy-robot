require "./lib/ToyRobot"
require "./lib/Table"

table = Table.new(5, 5)
toy_robot = ToyRobot.new(table)

puts "\n******************"
puts "Running 1st Sample:"
toy_robot.parse_command_string("PLACE 0,0,NORTH MOVE REPORT")
puts "\n******************"
puts "Running 2nd Sample:"
toy_robot.parse_command_string("PLACE 0,0,NORTH LEFT REPORT")
puts "\n******************"
puts "Running 3rd Sample:"
toy_robot.parse_command_string("PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT")

puts "-----------------"
puts "Extra Samples:"
toy_robot.parse_command_string("RUBBISH PLACE 1,2,EAST FAKE COMMAND MOVE MOVE LEFT MOVE REPORT")

toy_robot.parse_command_string("PLACE 1,2,WEST MOVE MOVE MOVE MOVE MOVE MOVE MOVE REPORT")
