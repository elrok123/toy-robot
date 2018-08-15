class ToyRobot
    def initialize(table)
        if table.is_a? Table
            @current_position = [nil, nil]
            @table = table 
        else
            raise ArgumentError, "Invalid table given to Toy Robot..."
        end
    end
    
    # Function to parse commands from an input source
    def parse_command_string(command_string)
        # Split our command into segments to be further parsed
        command_segments = command_string.split(" ")

        # Iterate over each command segment with the current index (i)
        command_segments.each_with_index do |command_segment, i|
            # Skip any command parameters, checks if segment contains a delimiter (,)
            next if command_segment.include? ","

            # Check which commdand we want to execute and execute the appropriate method
            case command_segment.to_sym
            when :MOVE
                this.move
            when :PLACE
                # Get our two position params from our command segments
                x_position = command_segments[i+1].tr(",", "").tr(" ", "")
                y_position = command_segments[i+2].tr(",", "").tr(" ", "")

                # Pass the X and Y co-ordinates to the place method
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
        if @table.valid_destination x, y, direction_to_face  
            return true
            return false
        end
    end
    
    # Function to report the robot's current X and Y co-ordinates and the direction it's facing
    def report
    end
end
