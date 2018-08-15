class ToyRobot
    def initialize(table)
        # Check that we have been given a valid table
        if table.is_a? Table
            # Initialise our robots current position variable
            @current_position = {
                x: nil,
                y: nil,
                direction: nil
            }
            # Add our table to the instance
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

            if self.placed? 
                # Check which commdand we want to execute and execute the appropriate method
                case command_segment.to_sym
                when :MOVE
                    self.move
                when :PLACE
                    # Get our two position params from our command segments
                    x_position = command_segments[i+1].tr(",", "").tr(" ", "")
                    y_position = command_segments[i+2].tr(",", "").tr(" ", "")
                    direction_to_face = command_segments[i+3] 

                    # Pass the X and Y co-ordinates to the place method
                    self.place x_position, y_position, direction_to_face 
                when :REPORT

                end
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

    # Function to check if the robot is currently placed
    def placed?
        # check if we currently have everything we need for our current_position
        return !@current_position[:x].nil? || !@current_position[:y].nil? || !@current_position[:direction].nil?
    end
end
