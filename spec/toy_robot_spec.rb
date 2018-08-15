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
end
