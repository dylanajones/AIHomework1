% This is the wall sensor

function [r] = wall_sensor(loc, dir, room)
    
    next_loc = loc + dir;
    
    dims = size(room);
    r = dims(1);
    c = dims(2);
    
    if (next_loc(1) <= r && next_loc(1) > 0 && next_loc(2) <= c && next_loc(2) > 0)
        r = 0;
    else
        r = 1;
    end
    
end