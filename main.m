% This is the code for AI HW #1

%% Initializing the Room

clear all
close all
clc

m = 10;
n = 10;
p = 1;

room = zeros(m,n);

for i = 1:m
    for j = 1:n
        if rand(1) <= p        
            room(i,j) = 1;           
        end
    end
end

loc = [n,1];
dir = [-1,0];

% To move just add dir to loc and the new 

%% Deterministic Reflex Agent

num_its = 100;

performance = zeros(num_its,1);

for z = 1:num_its

    if read_sensor(loc, room) == 1
        room(loc(1),loc(2)) = 0;
    elseif wall_sensor(loc, dir, room) == 1
        dir = turn_right(dir);
    else
        loc = loc + dir;
    end
    
    display(room)
    display(dir)
    display(loc)
    
%     figure(1)
%     waitforbuttonpress
    
    performance(z) = count_clean(room);
    
end

plot(performance);

%% Randomized Reflex Agent

num_its = 100;

performance = zeros(num_its,1);

for z = 1:num_its

    if read_sensor(loc, room) == 1
        room(loc(1),loc(2)) = 0;
    elseif wall_sensor(loc, dir, room) == 1
        dir = turn_right(dir);
    else
        loc = loc + dir;
    end
    
    display(room)
    display(dir)
    display(loc)
    
%     figure(1)
%     waitforbuttonpress
    
    performance(z) = count_clean(room);
    
end

plot(performance);

%% Deterministic Model-Based Reflex Agent