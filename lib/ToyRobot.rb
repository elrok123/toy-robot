require "./lib/Table"

class ToyRobot
    def initialize()
        @current_position = [nil, nil]
        @table = Table.new(5, 5)
    end
    
    # Function to parse commands from an input source
    def parse_command_string(command_string)
        # Split our command into segments to be further parsed
        command_segments = command_string.split(" ")

        command_segments.each_with_index do |command_segment, i|
            case command_segment.to_sym
            when :MOVE
                this.move
            when :PLACE
                x_position = command_segments[i+1]
                y_position = command_segments[i+2]

                this.place x_position, y_position 
            when :REPORT
            end
        end
    end

    # Function to take a command and execute a run sequence
    def read_command(command)
        
    end
    
    # Function to move the robot 1 square in the direction it's currently facing
    def move
    end

    # Function to take an X and Y co-ordinate to place the robot at along with a resulting direction to face in
    def place(x, y, direction_to_face)
        if 
            return true
            return false
    end
    
    # Function to report the robot's current X and Y co-ordinates and the direction it's facing
    def report
    end

end
