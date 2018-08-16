require "./lib/ToyRobot"
require "./lib/Table"

table = Table.new(5, 5)
toy_robot = ToyRobot.new(table)

toy_robot.parse_command_string("PLACE 1, 2 WEST MOVE LEFT")

