class ToyRobot
    
    DIRECTION_INFORMATION = {
        NORTH: { coordinate: :y, operation_value: +1, left: :WEST, right: :EAST },
        EAST:  { coordinate: :x, operation_value: +1, left: :NORTH, right: :SOUTH },
        SOUTH: { coordinate: :y, operation_value: -1, left: :EAST, right: :WEST },
        WEST:  { coordinate: :x, operation_value: -1, left: :SOUTH, right: :NORTH } 
    }

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

            # Check which commdand we want to execute and execute the appropriate method
            case command_segment.upcase.to_sym
            when :MOVE
                self.move
            when :PLACE
                # Get our X, Y and direction information from the command params
                place_params = self.get_command_coords_and_direction(command_segments, i)

                # Pass the X and Y co-ordinates to the place method
                if place_params != false
                    self.place place_params[:x], place_params[:y], place_params[:direction]
                end
            when :LEFT
                self.rotate :left
            when :RIGHT
                self.rotate :right
            when :REPORT
                self.report
            end
        end
    end

    # Function to get x and y coordinates along with the direction from a PLACE command's params
    def get_command_coords_and_direction(command_segments, index)
        if command_segments[index+1].include? ","
            
            # Get our x coord from the first param
            params = command_segments[index+1].split(",")

            if self.is_numeric? params[0]
                # Set our x coord from the first split element
                x_coord = params[0].to_i
            else
                # If no y coord was found, return an error
                puts "Invalid X co-ordinate given to the PLACE command, skipping command..."
                return false
            end
            

            # Check if the second paramater is numberic and if so use that as our y coord
            if !params[1].nil? 
                # Strip comma
                y_coord = params[1].to_i 
            elsif self.is_numeric? command_segments[index+2].tr!(",", "")
                # If we found the y coord in the next command segment use this
                y_coord = command_segments[index+2].to_i
            else
                # If no y coord was found, return an error
                puts "Invalid Y co-ordinate given to the PLACE command, skipping command..."
                return false
            end

            # Check if we have a direction to face as well
            if !params[2].nil?
                direction = params[2].tr(" ", "")
                return {x: x_coord, y: y_coord, direction: direction}
            elsif command_segments[index+3] == "NORTH" || command_segments[index+3] == "EAST" || command_segments[index+3] == "SOUTH" || command_segments[index+3] == "WEST"
                direction = command_segments[index+3]
                return {x: x_coord, y: y_coord, direction: direction}
            else
                puts "Invalid direction given to the PLACE command, skipping command"
                return false
            end
        else
            puts "Invalid PLACE command, skipping command..."
            return false
        end
    end

    # Function to rotate the Toy Robot based on current orientation
    def rotate(direction_to_rotate)
        # Check that we have been placed
        if self.placed?
            @current_position[:direction] = self.get_direction_constant[direction_to_rotate] 
            puts "The Toy Robot has rotated to face #{@current_position[:direction]}"
        else
            puts "The Toy Robot has not been placed, skipping command..."
            return false
        end
    end
    
    # Function to move the robot 1 square in the direction it's currently facing
    def move
        # Check that we have been placed
        if self.placed?
            # Create a new version to hold our new position for validation later
            new_position = @current_position.dup
            
            # Get our direction constant to establish whether we want to operate on the X or Y co-ordinate and whether to subtract or add based on direction
            direction_constant = self.get_direction_constant

            # Calculate our new position operating on the correct coordinate with the correct operation using the constants we have on the class
            new_position[direction_constant[:coordinate]] = new_position[direction_constant[:coordinate]] + direction_constant[:operation_value] 
            # Check if the new position is valid move to this position
            if @table.valid_destination new_position[:x], new_position[:y]
                # Set our new valid position
                @current_position = new_position 
                puts "The Toy Robot has moved to (#{@current_position[:x]}, #{@current_position[:y]}) facing #{@current_position[:direction]}..."
            else
                puts "The Toy Robot cannot move any further, position unchanged, skipping command..."
                return false
            end
        else
            puts "The Toy Robot has not been placed, skipping command..."
            return false
        end
    end

    # Function to get direction constant details based on the current position's direction
    def get_direction_constant
        # Use const_get to get the classes direction constants based on the direction string (NORTH, EAST, SOUTH and WEST)
        return DIRECTION_INFORMATION[@current_position[:direction].upcase.to_sym]
    end

    # Function to take an X and Y co-ordinate to place the robot at along with a resulting direction to face in
    def place(x, y, direction_to_face)
        # Check if we're working with a valid destination
        if @table.valid_destination x, y  
            # Set our new position instance variable values
            @current_position[:x] = x
            @current_position[:y] = y
            @current_position[:direction] = direction_to_face

            puts "Toy Robot placed at (#{@current_position[:x]}, #{@current_position[:y]}) facing #{@current_position[:direction]}"

            return true
        else
            puts "Invalid placement given, please specify a valid place within the range of the table in the format X, Y e.g. PLACE 1, 2" 
            return false
        end
    end
    
    # Function to report the robot's current X and Y co-ordinates and the direction it's facing
    def report
        # Check that we have been placed
        if self.placed?
            puts "The robot is currently in position (#{@current_position[:x]}, #{@current_position[:y]}) facing #{@current_position[:direction]}..."
            return true
        else
            puts "The Toy Robot has not been placed, skipping command..."
            return false
        end
    end

    # Function to check if the robot is currently placed
    def placed?
        # check if we currently have everything we need for our current_position
        return !@current_position[:x].nil? && !@current_position[:y].nil? && !@current_position[:direction].nil?
    end

    # Function to determine if string is a number
    def is_numeric?(value)
        !!Float(value) rescue false 
    end
end
