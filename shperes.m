clear;
figure(1);
title('Solar System');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on;
grid on;
axis vis3d;
format long
axis([-15, 15, -15, 15, -15, 15])

resolution = 50;

% Earth
[e_x,e_y,e_z] = sphere(resolution);
earth_texture = flipud(imresize(im2double(imread('earth.jpg')),size(e_x)));
earth = surf(e_x, e_y, e_z, earth_texture)
earth.EdgeColor = 'none'

% Saturn
[s_x,s_y,s_z] = sphere(resolution);
s_x = (s_x.*2)+10;
s_y = (s_y.*2);
s_z = (s_z.*2);
saturn_sphere_texture = flipud(imresize(im2double(imread('saturn-sphere.jpg')),size(s_x)));
saturn = surf(s_x, s_y, s_z, saturn_sphere_texture)
saturn.EdgeColor = 'none'


% Saturn ring
r = 1;
d = 3.5;

phi = linspace(0,2*pi,resolution)';
alpha = linspace(0,2*pi,resolution*10)';

tmp=[d+r*cos(phi), r*sin(phi)];
sr_x=cos(alpha)*tmp(:,1)';
sr_y=sin(alpha)*tmp(:,1)';
sr_z=tmp(:,2)';sr_z=sr_z(ones(1,length(alpha)),:);

sr_x = sr_x+10;
sr_y = sr_y;
sr_z = (sr_z./15);
saturn_ring_texture = flipud(imresize(im2double(imread('saturn-ring3.jpg')),size(sr_x)));
saturn_ring = surf(sr_x, sr_y, sr_z, saturn_ring_texture);
saturn_ring.EdgeColor = 'none'
hold off;

orbitAng = 1;
satPos = [0,0,5; 0,0,0; 0,0,0];
while 1
    rotate(earth, [0,0,1], 10, [0,0,0])
    
    % Umlauf
    rotate(saturn, [0,0,1], orbitAng, [0,0,0])
    rotate(saturn_ring, [0,0,1], orbitAng, [0,0,0])
    
    % Eigenrotation
    Rz = [cos(orbitAng) -sin(orbitAng) 0;...
        sin(orbitAng) cos(orbitAng) 0;...
        0 0 1];
    %satPos = Rz * satPos;
    
    %rotate(saturn, [0,0,1], orbitAng*2, [satPos(1,3), satPos(2,3), satPos(3,3)])
    %rotate(saturn_ring, [0,0,1], orbitAng*2, [satPos(1,3), satPos(2,3), satPos(3,3)])
    drawnow
end

  