% This is a function for reading sensor

function [r] = read_sensor(loc, room)
    r = room(loc(1),loc(2));
end