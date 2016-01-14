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

num_its = 500;

performance = zeros(num_its,1);

for z = 1:num_its

    if read_sensor(loc, room) == 1
        room(loc(1),loc(2)) = 0;
    elseif wall_sensor(loc, dir, room) == 1
        dir = turn_right(dir);
    else
        loc = loc + dir;
    end
    
%     display(room)
%     display(dir)
%     display(loc)
    
%     figure(1)
%     waitforbuttonpress
    
    performance(z) = count_clean(room);
    
end

plot(performance);

%% Randomized Reflex Agent

num_its = 500;
num_runs = 50;
decison_prob = .75;

performance = zeros(num_runs, num_its);

for y = 1:num_runs
    
    % Reintialize the room before each run
    room = zeros(m,n);

    for i = 1:m
        for j = 1:n
            if rand(1) <= p        
                room(i,j) = 1;           
            end
        end
    end
    
    % Reintialize the robot before each run
    loc = [n,1];
    dir = [-1,0];
    
    % Loop to perform each run
    for z = 1:num_its

        if read_sensor(loc, room) == 1
            room(loc(1),loc(2)) = 0;
        elseif wall_sensor(loc, dir, room) == 1
            if rand(1) <= .5
                dir = turn_right(dir);
            else
                dir = turn_left(dir); 
            end
        else
            if rand(1) <= decison_prob
                loc = loc + dir;
            else
                if rand(1) <= .5
                    dir = turn_right(dir);
                else
                    dir = turn_left(dir);
                end
            end
        end

%         display(room)
%         display(dir)
%         display(loc)
% 
%         figure(1)
%         waitforbuttonpress

        performance(y,z) = count_clean(room);

    end
end
figure(1)
hold on
plot(mean(performance));

%% Deterministic Model-Based Reflex Agent

% Position 1 indicates if we should move forward
% Position 2 indicates if we should turn
% Position 3 indicates which direction we should turn
%   - 0 => turn right
%   - 0 => turn left

s_memory = [0,0,0];
time_end = 1;
num_actions = 0;

while time_end ~= 0
    num_actions = num_actions + 1;
    if (read_sensor(loc, room) == 1)
        room(loc(1),loc(2)) = 0;
    elseif ( s_memory(1) == 1 && wall_sensor(loc, dir, room) == 1 )
        time_end = 0;
    elseif ( s_memory(1) == 1 )
        loc = loc + dir;
        s_memory(1) = 0;
        s_memory(2) = 1;
    elseif ( s_memory(2) == 1)
        if ( s_memory(3) == 0 )
            dir = turn_right(dir);
            s_memory(3) = 1;
        else
            dir = turn_left(dir);
            s_memory(3) = 0;
        end
        
        s_memory(2) = 0;
    elseif ( wall_sensor(loc, dir, room) == 1 )   
        if s_memory(3) == 0;
            dir = turn_right(dir);
        else
            dir = turn_left(dir);
        end

        s_memory(1) = 1;

    else
        loc = loc + dir;
    end

%         display(room)
%         display(dir)
%         display(loc)
%         display(s_memory)
% 
%         figure(1)
%         waitforbuttonpress
        
        performance(num_actions) = count_clean(room);
    
end

plot(performance);

















