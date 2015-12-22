clear;
figure(1);
title('Solar System');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on;
grid on;
axis vis3d;
%format long
axis([-30, 30, -30, 30, -30, 30])
axis off
orbitAng = 1;

% This creates the 'background' axes
ha = axes('units','normalized', ...
            'position',[0 0 1 1]);
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
I=imread('imgs/SpaceBackground.png');
hi = imagesc(I)
set(hi,'alphadata',.9)
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
            'visible','off')

resolution = 70;

%Sun light
light('Position',[0 0 0],'Style','local');
lighting flat
%lighting gouraud

[sun, earth, saturn, saturn_ring] = getUniverse(resolution);

material dull
%material metal

shading interp

satPos = [0,0,20;...
          0,0,0;...
          0,0,0];

while 1
    rotate(earth, [0,0,1], 10, [0,0,0])

    % Orbit
    rotate(saturn, [0,0,1], orbitAng, [0,0,0])
    rotate(saturn_ring, [0,0,1], orbitAng, [0,0,0])
    
    % Spin / Rotation
    Mr_saturn = [cosd(orbitAng) -sind(orbitAng) 0;...
                sind(orbitAng) cosd(orbitAng) 0;...
                0 0 1];
    satPos = Mr_saturn * satPos;
    
    rotate(saturn_ring, [0,0,1], -orbitAng, [satPos(1,3), satPos(2,3), satPos(3,3)])
    %pause(0.001);
    drawnow;
    %pause(100);
end

  
