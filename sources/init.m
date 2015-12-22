% === init view ===
clear;
figure(1);
title('Solar System');
hold on;

% Axis configuration
xlabel('X'); ylabel('Y'); zlabel('Z');
axis([-100, 100, -100, 100, -100, 100]);
axis off;
axis vis3d;

% Background
% This creates the 'background' axes
ha = axes('units','normalized', 'position',[0 0 1 1]);
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
<<<<<<< HEAD
I=imread('imgs/SpaceBackground.png');
hi = imagesc(I)
set(hi,'alphadata',.9)
=======
hi = imagesc(imread('imgs/SpaceBackground.png'));
set(hi,'alphadata',.8)
>>>>>>> 4983c2f7a879d438e989b5670eedaa38f3a77e9a
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', 'visible','off')

% Sun light
light('Position',[0 0 0],'Style','local');
lighting flat
%lighting gouraud

<<<<<<< HEAD
[sun, earth, saturn, saturn_ring] = getUniverse(resolution);

material dull
%material metal

shading interp

satPos = [0,0,20;...
=======
% === start ===
rotation_angle = 1; % a.k.a. speed
resolution = 70;

[sun, earth, mars, saturn, saturn_ring] = getUniverse(resolution);

% This kind of sucks...
% it'd be nice if we could get this information from the surface object
satPos = [0,0,40;...
>>>>>>> 4983c2f7a879d438e989b5670eedaa38f3a77e9a
          0,0,0;...
          0,0,0];

M_rot = [cosd(rotation_angle) -sind(rotation_angle) 0;...
        sind(rotation_angle) cosd(rotation_angle) 0;...
        0 0 1];

% Run simulation
while 1
    % Orbit
    rotate(earth, [0,0,1], 10, [0,0,0])
    rotate(mars, [0,0,1], 5, [0,0,0])
    
    rotate(saturn, [0,0,1], rotation_angle, [0,0,0])
    rotate(saturn_ring, [0,0,1], rotation_angle, [0,0,0])
    
    % Spin / Rotation
    satPos = M_rot * satPos;
    rotate(saturn_ring, [0,0,1], -rotation_angle, [satPos(1,3), satPos(2,3), satPos(3,3)])

    drawnow;
end
