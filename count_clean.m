% This is a function to count the number of clean squares

function [count] = count_clean(room)
    
    dims = size(room);
    r = dims(1);
    c = dims(2);
    
    count = 0;
    
    for i = 1:r
        for j = 1:c
            if room(i,j) == 0
                count = count + 1;
            end
        end
    end
    
end