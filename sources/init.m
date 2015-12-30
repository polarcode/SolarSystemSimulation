% === init view ===
clear;
figure(1);
title('Solar System');
hold on;

% Axis configuration
xlabel('X'); ylabel('Y'); zlabel('Z');
axis([-150, 150, -150, 150, -150, 150]);
axis off;
axis vis3d;

% Background
% This creates the 'background' axes
ha = axes('units','normalized', 'position',[0 0 1 1]);
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
I=imread('imgs/SpaceBackground.png');
hi = imagesc(I)
set(hi,'alphadata',.9)
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', 'visible','off')

% Sun light
light('Position',[0 0 0],'Style','local');
lighting flat

% === start ===
speed = 10;
rotation = 1;
resolution = 70;
AU = 10; % definition of one astronomical unit (distance earth to sun)
radius = 10; % scale of size of planets (log10)

[sun, earth, mars, saturn, saturn_ring] = getUniverse(AU, radius, resolution);

material dull
shading interp

% This kind of sucks...
% it'd be nice if we could get this information from the surface object
satPos = [0,0,9.58*AU;...
          0,0,0;...
          0,0,0];

M_rot_sat = [cosd((1/29.45)*speed) -sind((1/29.45)*speed) 0;...
        sind((1/29.45)*speed) cosd((1/29.45)*speed) 0;...
        0 0 1];

% Run simulation
while 1
    % Orbit
    rotate(earth, [0,0,1], speed, [0,0,0])
    rotate(mars, [0,0,1], (1/1.88)*speed, [0,0,0])
    
    rotate(saturn, [0,0,1], (1/29.45)*speed, [0,0,0])
    rotate(saturn_ring, [0,0,1], (1/29.45)*speed, [0,0,0])
    
    % Spin / Rotation
    satPos = M_rot_sat * satPos;
    rotate(saturn_ring, [0,0,1], -(1/29.45)*rotation, [satPos(1,3), satPos(2,3), satPos(3,3)])

    drawnow;
end
