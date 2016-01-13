% This is a function to turn the robot left

function [dir] = turn_left(cur_dir)

    if cur_dir == [-1,0]
        dir = [0,-1];
    elseif cur_dir == [0,-1]
        dir = [1,0];
    elseif cur_dir == [1,0]
        dir = [0,1];
    else
        dir = [-1,0];
    end
    
end