% This is the code for AI HW #1

%% Initializing the Room

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
dir = [1,0];

%% Deterministic Reflex Agent



%% Randomized Reflex Agent

%% Deterministic Model-Based Reflex Agent