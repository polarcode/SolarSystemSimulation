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

% This creates the 'background' axes
ha = axes('units','normalized', ...
            'position',[0 0 1 1]);
% Move the background axes to the bottom
uistack(ha,'bottom');
% Load in a background image and display it using the correct colors
I=imread('SpaceBackground.png');
hi = imagesc(I)
set(hi,'alphadata',.8)
% Turn the handlevisibility off so that we don't inadvertently plot into the axes again
% Also, make the axes invisible
set(ha,'handlevisibility','off', ...
            'visible','off')

resolution = 70;

%Sun light
light('Position',[0 0 0],'Style','local');
lighting flat
%lighting gouraud

%material shiny
material dull
%material metal

shading interp

% Earth
[e_x,e_y,e_z] = sphere(resolution);
earth_texture = flipud(imresize(im2double(imread('earth.jpg')),size(e_x)));
earth = surf(e_x + 9, e_y, e_z, earth_texture);
earth.EdgeColor = 'none';

% Sun
[sun_x, sun_y, sun_z] = sphere (resolution*1);
sun_x = (sun_x * 5);
sun_y = (sun_y * 5);
sun_z = (sun_z * 5);
sun_texture = flipud(imresize(im2double(imread('sun.jpg')),size(sun_x)));
sun = surf(sun_x, sun_y, sun_z, sun_texture);
sun.BackFaceLighting = 'reverselit';
sun.EdgeColor = 'none';

% Saturn
[sat_x,sat_y,sat_z] = sphere(resolution);
sat_x = (sat_x * 2) + 15;
sat_y = (sat_y * 2);
sat_z = (sat_z * 2);
saturn_sphere_texture = flipud(imresize(im2double(imread('saturn-sphere.jpg')),size(sat_x)));

%C(:,:,1) = rand(resolution + 1);
%C(:,:,2) = rand(resolution + 1);
%C(:,:,3) = rand(resolution + 1);

saturn = surf(sat_x, sat_y, sat_z, saturn_sphere_texture)
saturn.EdgeColor = 'none';


% Saturn ring
r = 1;
d = 3.5;

phi = linspace(0,2*pi,resolution)';
alpha = linspace(0,2*pi,resolution*10)';

tmp=[d+r*cos(phi), r*sin(phi)];
sr_x=cos(alpha)*tmp(:,1)';
sr_y=sin(alpha)*tmp(:,1)';
sr_z=tmp(:,2)'
sr_z=sr_z(ones(1,length(alpha)),:);

sr_x = sr_x+15;
sr_y = sr_y;
sr_z = (sr_z./15);
saturn_ring_texture = flipud(imresize(im2double(imread('saturn-ring3.jpg')),size(sr_x)));
saturn_ring = surf(sr_x, sr_y, sr_z, saturn_ring_texture);
rotate(saturn_ring,[0 1 1],45,[15 0 0]);
saturn_ring.EdgeColor = 'none'
hold off;

orbitAng = 1;
satPos = [0,0,15;...
          0,0,0;...
          0,0,0];
      
i = 0;
while 1
    rotate(earth, [0,0,1], 10, [0,0,0])
 
    % Orbit
    rotate(saturn, [0,0,1], orbitAng, [0,0,0])
    rotate(saturn_ring, [0,0,1], orbitAng, [0,0,0])
    
    % Spin / Rotation
    Rz = [cosd(orbitAng) -sind(orbitAng) 0;...
          sind(orbitAng) cosd(orbitAng) 0;...
        0 0 1];
    satPos = Rz * satPos;
    
    %rotate(saturn, [0,0,1], orbitAng*2, [satPos(1,3), satPos(2,3), satPos(3,3)])
    %rotate(saturn_ring, [0,0,1], orbitAng*2, [satPos(1,3), satPos(2,3), satPos(3,3)])
    %pause(0.001);
    drawnow;
    %pause(100);
end

  