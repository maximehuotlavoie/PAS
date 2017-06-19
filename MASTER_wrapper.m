% This wrapper will run the MASTER peri-op script every few minutes for five hours
% or until the user stops.
wrapper_counter = 1

while exist('wrapper_counter')
    MASTER_periop
    pause(