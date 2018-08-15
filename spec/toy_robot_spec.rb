require "./lib/ToyRobot"
require "./lib/Table"

describe "ToyRobot" do
    describe ".new" do
        context "when given a table object"
            it "should create a new instance of ToyRobot" do
                table = Table.new(5, 5)
                toy_robot = ToyRobot.new(table)
            end
        end
    end
end
