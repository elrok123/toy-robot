class Table
    def initialize(table_grid_x, table_grid_y)
       @max_x = table_grid_x
       @max_y = table_grid_y
    end

    # Function to check if a destination is a valid place on the table
    def valid_destination(x_position, y_position)
        if x_position > 0 && x_position < @max_x
            if y_position > 0 && y_position < @max_y
                return true  
            else
                puts "Invalid Y position provided..."
                retrun false
            end
        else
            puts "Invalid X position provided..."
            return false
        end
    end
end
