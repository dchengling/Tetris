% define shapes
clear; close all; 
global get_to_the_bottom key_pertect map current_x current_y map_base current_shape ...
   current_shape_direction current_shape_num shapes dropSpeed width height
shapes = zeros(4,4,7,4);
%------------ direction 1  --------------
shapes(1:2,:,1,1) =  [[1,1,1,1]; 
                      [0,0,0,0]]; % I
shapes(1:2,:,2,1) =  [[1,1,1,0]; 
                      [1,0,0,0]]; % L
shapes(1:2,:,3,1) =  [[1,1,1,0]; 
                      [0,0,1,0]]; % flip L
shapes(1:2,:,4,1) =   [[1,1,0,0]; 
                       [1,1,0,0]]; % brick
shapes(1:2,:,5,1) =   [[1,1,0,0]; 
                       [0,1,1,0]]; % Z
shapes(1:2,:,6,1) =   [[0,1,1,0]; 
                       [1,1,0,0]]; % flip Z
shapes(1:2,:,7,1) =  [[0,1,0,0]; 
                      [1,1,1,0]]; %  T

%------------- direction 2  --------------

shapes(:,:,1,2) =    [[1,0,0,0]; 
                      [1,0,0,0];
                      [1,0,0,0];
                      [1,0,0,0];]; % I
shapes(:,:,2,2) =    [[1,1,0,0]; 
                      [0,1,0,0];
                      [0,1,0,0];
                      [0,0,0,0];]; % L
shapes(:,:,3,2) =    [[0,1,0,0]; 
                      [0,1,0,0];
                      [1,1,0,0];
                      [0,0,0,0]]; % flip L
shapes(1:2,:,4,2) =   [[1,1,0,0]; 
                       [1,1,0,0]]; % brick
shapes(:,:,5,2) =     [[0,1,0,0]; 
                       [1,1,0,0];
                       [1,0,0,0];
                       [0,0,0,0]]; % Z
shapes(:,:,6,2) =     [[1,0,0,0]; 
                       [1,1,0,0];
                       [0,1,0,0];
                       [0,0,0,0]]; % flip Z
shapes(:,:,7,2) =    [[1,0,0,0]; 
                      [1,1,0,0];
                      [1,0,0,0];
                      [0,0,0,0]]; %  T

%------------- direction 3  --------------

shapes(:,:,1,3) =    [[1,1,1,1]; 
                      [0,0,0,0];
                      [0,0,0,0];
                      [0,0,0,0];]; % I
shapes(:,:,2,3) =    [[0,0,1,0]; 
                      [1,1,1,0];
                      [0,0,0,0];
                      [0,0,0,0];]; % L
shapes(:,:,3,3) =    [[1,0,0,0]; 
                      [1,1,1,0];
                      [0,0,0,0];
                      [0,0,0,0]]; % flip L
shapes(1:2,:,4,3) =   [[1,1,0,0]; 
                       [1,1,0,0]]; % brick
shapes(:,:,5,3) =     [[1,1,0,0]; 
                       [0,1,1,0];
                       [0,0,0,0];
                       [0,0,0,0]]; % Z
shapes(:,:,6,3) =     [[0,1,1,0]; 
                       [1,1,0,0];
                       [0,0,0,0];
                       [0,0,0,0]]; % flip Z
shapes(:,:,7,3) =    [[1,1,1,0]; 
                      [0,1,0,0];
                      [0,0,0,0];
                      [0,0,0,0]]; %  T

%------------- direction 4  --------------

shapes(:,:,1,4) =    [[1,0,0,0]; 
                      [1,0,0,0];
                      [1,0,0,0];
                      [1,0,0,0];]; % I
shapes(:,:,2,4) =    [[1,0,0,0]; 
                      [1,0,0,0];
                      [1,1,0,0];
                      [0,0,0,0];]; % L
shapes(:,:,3,4) =    [[1,1,0,0]; 
                      [1,0,0,0];
                      [1,0,0,0];
                      [0,0,0,0]]; % flip L
shapes(1:2,:,4,4) =   [[1,1,0,0]; 
                       [1,1,0,0]]; % brick
shapes(:,:,5,4) =     [[0,1,0,0]; 
                       [1,1,0,0];
                       [1,0,0,0];
                       [0,0,0,0]]; % Z
shapes(:,:,6,4) =     [[1,0,0,0]; 
                       [1,1,0,0];
                       [0,1,0,0];
                       [0,0,0,0]]; % flip Z
shapes(:,:,7,4) =    [[0,1,0,0]; 
                      [1,1,0,0];
                      [0,1,0,0];
                      [0,0,0,0]]; %  T

% define game size
width = 10;
height = 20;

%define the game map
map = zeros(height,width);
map_base = zeros(height,width);
get_to_the_bottom = 1;
dropSpeed = 0.5;

colormap([0,0,0;0.5,0.5,0.8]);
% map(1:3,:) = 2;
image(map+1);
axis equal
axis off
set(gcf, 'name', 'Tetris', 'menubar', 'none', 'numbertitle', 'off', 'KeyPressFcn', @keypress)
key_pertect = 1;
% set(gca,'position',[-0.4,-0.3,1.8,1.6]);

% get current shape
current_shape_num = randi([1, 7]);
current_shape_direction = 1;
current_shape = shapes(:,:,current_shape_num,current_shape_direction);


% get initial position
current_x = ceil(width / 2);
current_y = 0;

% update figure
while true

    [get_to_the_bottom,map,current_y] = block_move_down(map_base, current_shape, current_x, current_y, map, height);

    if get_to_the_bottom == 1 % block in the map already get to the bottom or map full
        if current_y == 0 % map already full, can not lay a new block
            fprintf("Game Over!\n");
            break;
        else % block move to the bottom
            [map_base, map] = rm_row(width, height, map);
            image(map+1),axis equal off;  % plot the map          
            pause(dropSpeed);
            [current_shape_num, current_shape_direction, current_shape, current_x, current_y, dropSpeed] = ...
                selet_a_new_shape(shapes, width);
            
        end
    else
        image(map+1),axis equal off;  % plot the map
        key_pertect = 0;
        pause(dropSpeed);  % pause the block half second
        key_pertect = 1;        
    end
end

function keypress(~, evt)
global get_to_the_bottom key_pertect map map_base current_x current_y current_shape...
    current_shape_num current_shape_direction shapes dropSpeed width height
if key_pertect == 0
    switch evt.Key
        case 'leftarrow'
            if current_x > 1  
                map_test = map_base;
                [shapeRowBeginTest,shapeRowEndTest,shapeColBeginTest,shapeColEndTest] = get_shape_bound(current_shape);
                map_test(current_y+shapeRowBeginTest:current_y+shapeRowEndTest,current_x+shapeColBeginTest-1-1:current_x+shapeColEndTest-1-1) = ...
                    map_test(current_y+shapeRowBeginTest:current_y+shapeRowEndTest,current_x+shapeColBeginTest-1-1:current_x+shapeColEndTest-1-1) + ...
                    current_shape(shapeRowBeginTest:shapeRowEndTest,shapeColBeginTest:shapeColEndTest);
                if sum(map_test(:) == 2) == 0 
                    current_x = current_x - 1;
                    map = map_test;
                    image(map+1),axis equal off;
                end
            end
        case 'rightarrow'
            [shapeRowBegin,shapeRowEnd,shapeColBegin,shapeColEnd] = get_shape_bound(current_shape);
            if current_x < 10 - (shapeColEnd-shapeColBegin) 
                map_test = map_base;
                
                map_test(current_y+shapeRowBegin:current_y+shapeRowEnd,current_x+shapeColBegin-1+1:current_x+shapeColEnd-1+1) = ...
                    map_test(current_y+shapeRowBegin:current_y+shapeRowEnd,current_x+shapeColBegin-1+1:current_x+shapeColEnd-1+1) + ...
                    current_shape(shapeRowBegin:shapeRowEnd,shapeColBegin:shapeColEnd);
                if sum(map_test(:) == 2) == 0                
    
                    current_x = current_x + 1;
                    map = map_test;
                    image(map+1),axis equal off;
                end
            end
        case 'downarrow'
             dropSpeed = 0.05;
        case 'uparrow'
            map_test = map_base;
            current_shape_test = shapes(:,:,current_shape_num,mod(current_shape_direction,4)+1);
            [shapeRowBeginTest,shapeRowEndTest,shapeColBeginTest,shapeColEndTest] = get_shape_bound(current_shape_test);

            current_x_test = current_x;
            while current_x_test+shapeColEndTest-1 > width
                current_x_test = current_x_test - 1;
            end

            map_test(current_y+shapeRowBeginTest:current_y+shapeRowEndTest,current_x_test+shapeColBeginTest-1:current_x_test+shapeColEndTest-1) = ...
                map_test(current_y+shapeRowBeginTest:current_y+shapeRowEndTest,current_x_test+shapeColBeginTest-1:current_x_test+shapeColEndTest-1) + ...
                current_shape_test(shapeRowBeginTest:shapeRowEndTest,shapeColBeginTest:shapeColEndTest);
            if sum(map_test(:) == 2) == 0               
                current_shape = current_shape_test;
                current_shape_direction = mod(current_shape_direction,4)+1;
                map = map_test;
                current_x = current_x_test;
                image(map+1),axis equal off;
            end
    end
end
end

function [get_to_the_bottom,map,y]=block_move_down(map_base, current_shape, current_x, current_y, curr_map, height)
    
    get_to_the_bottom = 1;
    y = current_y;
    map = curr_map;

    map_test = map_base;
    [shapeRowBegin,shapeRowEnd,shapeColBegin,shapeColEnd] = get_shape_bound(current_shape);
    
    if current_y+shapeRowEnd <= height
        map_test(current_y+shapeRowBegin:current_y+shapeRowEnd,current_x+shapeColBegin-1:current_x+shapeColEnd-1) = ...
            map_test(current_y+shapeRowBegin:current_y+shapeRowEnd,current_x+shapeColBegin-1:current_x+shapeColEnd-1) + ...
            current_shape(shapeRowBegin:shapeRowEnd,shapeColBegin:shapeColEnd);
        if sum(map_test(:) == 2) == 0 % block in the map not get to the bottom, block continue move forward
            map = map_test;
            y = current_y + 1; % next y to try
            get_to_the_bottom = 0;
        end
    end

    
end

function [map_base, map_update] = rm_row(width, height, map)
    % if a line full, delete the line
    map_update = map;
    for i = 1:height
        if sum(map_update(i, :)) == width
            map_update = [zeros(1, width); map_update([1:i-1,i+1:height],:)];
        end
    end
    map_base = map_update;
end

function [current_shape_num, current_shape_direction, current_shape, current_x, current_y, dropSpeed] = ...
    selet_a_new_shape(shapes, width)

    current_shape_num = randi([1, 7]);
    current_shape_direction = 1;
    current_shape = shapes(:,:,current_shape_num,current_shape_direction);
    current_x = ceil(width / 2)-1;
    current_y = 0;
    dropSpeed = 0.5;
end

function [shapeRowBegin,shapeRowEnd,shapeColBegin,shapeColEnd] = get_shape_bound(current_shape)

    shapeRowIdx = find(sum(current_shape,2)~=0);
    shapeRowBegin = shapeRowIdx(1); shapeRowEnd = shapeRowIdx(end);
    shapeColIdx = find(sum(current_shape,1)~=0);
    shapeColBegin = shapeColIdx(1); shapeColEnd = shapeColIdx(end);

end

