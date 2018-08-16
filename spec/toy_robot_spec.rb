require "./lib/ToyRobot.rb"
require "./lib/Table.rb"

describe "ToyRobot" do
    describe ".new" do
        context "when given a table object" do
            it "should create a new instance of ToyRobot" do
                table = Table.new(5, 5)
                toy_robot = ToyRobot.new(table)
            end
        end
        context "when given an invalid object" do
            it "should not raise an argument error" do
                table = "" 

                expect{ ToyRobot.new(table) }.to raise_error(ArgumentError)
                
                table = 1 

                expect{ ToyRobot.new(table) }.to raise_error(ArgumentError)

                table = :bad_value 

                expect{ ToyRobot.new(table) }.to raise_error(ArgumentError)
            end
        end
    end
    describe ".parse_command_string" do
        context "when given a command string containing a PLACE comand" do
            it "should take a PLACE command and place the Toy Robot in the correct position" do
                table = Table.new(5, 5)
                toy_robot = ToyRobot.new(table)

                toy_robot.parse_command_string("PLACE 0, 0, SOUTH")
            end
        end
        context "when given a command string containing a MOVE command" do
            it "should take a MOVE command and move the Toy Robot 1 square in the direction it's currently facing" do
                table = Table.new(5, 5)
                toy_robot = ToyRobot.new(table)
                                                             
                toy_robot.parse_command_string("PLACE 0, 0, NORTH MOVE")
            end
        end

    end
end
