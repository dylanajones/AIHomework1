% This is the code for AI HW #1

%% Initializing the Room

%Adding to test github loading ...

clear all
close all
clc

m = 10;
n = 10;
p = 1;

room = zeros(m,n);

% This loop allows for futher expansion if there is a probability of dirt
% being in a spot
for i = 1:m
    for j = 1:n
        if rand(1) <= p        
            room(i,j) = 1;           
        end
    end
end

% Start in the lower left corner facing upwards
% Going up means subtracting from the row
loc = [n,1];
dir = [-1,0];

% To move just add dir to loc and the new 

%% Deterministic Reflex Agent

% Number of actions the robot takes
num_its = 1000;

% Array to hold the performance of the robot
performance = zeros(num_its,1);

% Loop through all the actions
for z = 1:num_its
    
    % If-thens that describe the robots action
    if read_sensor(loc, room) == 1
        room(loc(1),loc(2)) = 0; % Clean the spot
    elseif wall_sensor(loc, dir, room) == 1
        dir = turn_right(dir);
    else
        loc = loc + dir;
    end
    
    performance(z) = count_clean(room);
    
end

figure(1)
plot(performance);

%% Randomized Reflex Agent

num_its = 1000;
num_runs = 100;
decison_prob = .9;

performance = zeros(num_runs, num_its);
num_actions_needed = zeros(num_runs,1);

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
    
    % Reintialize z before each run
    z = 0;
    
    % Loop to perform each run
    % Continue for a certain number of iterations
    while  (z < num_its )%&& count_clean(room) < ( m * n * 0.9 ) )
        
        z = z + 1;
        
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

        performance(y,z) = count_clean(room);

    end
    
    num_actions_needed(y) = z;
end
figure(1)
hold on
plot(mean(performance),'r');
hold off

figure(2)
hist(num_actions_needed);
title('Number of Actions Required to Clean 90% of the Room')
xlabel('Number of Actions Taken')
ylabel('Number of Agents')

s = sort(num_actions_needed);

display(mean(s(1:45)));

%% Deterministic Model-Based Reflex Agent

% Position 1 indicates if we should move forward
% Position 2 indicates if we should turn
% Position 3 indicates which direction we should turn
%   - 0 => turn right
%   - 0 => turn left

s_memory = [0,0,0];
time_end = 1;
num_actions = 0;

performance = zeros(num_its,1);

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

%     display(room)
%     display(dir)
%     display(loc)
%     display(s_memory)
% 
%     figure(1)
%     waitforbuttonpress

    performance(num_actions) = count_clean(room);
    
end

value = performance(num_actions);

for i = num_actions:num_its
    performance(i) = value;
end

figure(1)
hold on
plot(performance,'g');
hold off
title('Performance Compairison Graph for all Three Agents')
xlabel('Number of Actions')
ylabel('Number of Spots Cleaned')















