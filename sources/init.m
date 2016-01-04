% === init view ===
clear;
clf();
figure(1);
hold on;

% Axis configuration
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
hi = imagesc(I);
set(hi,'alphadata',.9);
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible

text(50,50,'Solar System','Color','cyan','FontSize',12,'EdgeColor','cyan');
t = text(50,120,['FPS: ',0],'Color',[0 1 1],'FontSize',10);

set(ha,'handlevisibility','off', 'visible','off')

% Sun light
light('Position',[0 0 0],'Style','local');
lighting flat

% === start ===
speed = 1;
rotation = 1;
resolution = 50;
AU = 10; % definition of one astronomical unit (distance earth to sun)
radius = 10; % scale of size of planets (log10)

[sun, mercury, venus, earth, moon, mars, jupiter, saturn, saturn_ring, uranus, neptune] = getUniverse(AU, radius, resolution);

material dull
shading interp

% This kind of sucks...
% it'd be nice if we could get this information from the surface object
pos_saturn = [0,0,9.58*AU;...
          0,0,0;...
          0,0,0];

pos_earth = [0,0,AU;...
          0,0,0;...
          0,0,0];
axis_earth = [cosd(66), 0, sind(66)];

M_rot_sat = [cosd(0.034*speed) -sind(0.034*speed) 0;...
            sind(0.034*speed) cosd(0.034*speed) 0;...
            0 0 1];

M_rot_earth = [cosd(speed) -sind(speed) 0;...
            sind(speed) cosd(speed) 0;...
            0 0 1];

% Run simulation
while 1
    tic();
    % Orbit
    rotate(mercury, [0,0,1], 4.1521*speed, [0,0,0])
    rotate(venus, [0,0,1], 1.6255*speed, [0,0,0])
    rotate(earth, [0,0,1], speed, [0,0,0])
    rotate(moon, [0,0,1], speed, [0,0,0])
    rotate(mars, [0,0,1], 0.5317*speed, [0,0,0])
    rotate(jupiter, [0,0,1], 0.0843*speed, [0,0,0])
    
    rotate(saturn, [0,0,1], 0.034*speed, [0,0,0])
    rotate(saturn_ring, [0,0,1], 0.034*speed, [0,0,0])
    
    rotate(uranus, [0,0,1], 0.0119*speed, [0,0,0])
    rotate(neptune, [0,0,1], 0.0061*speed, [0,0,0])

    % Spin / Rotation
    pos_saturn = M_rot_sat * pos_saturn;
    rotate(saturn_ring, [0,0,1], -0.034*rotation, [pos_saturn(1,3), pos_saturn(2,3), pos_saturn(3,3)])
    
    pos_earth = M_rot_earth * pos_earth;
    rotate(earth, axis_earth, 36*speed, [pos_earth(1,3), pos_earth(2,3), pos_earth(3,3)])

    % Moons
    rotate(moon, [0,0,1], 13.3795*speed, [pos_earth(1,3), pos_earth(2,3), pos_earth(3,3)])
    
    drawnow;
 
    fps = num2str(round((1/toc())*10)/10);
    t.String = ['FPS: ', fps];
  
end
