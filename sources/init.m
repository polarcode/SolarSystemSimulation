% === init view ===
clear;
clf();
figure(1);
hold on;

% Axis configuration
axis([-310, 310, -310, 310, -310, 310]);
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

% UI
text(50, 50, 'Solar System', 'Color', 'cyan', 'FontSize', 12, 'EdgeColor', 'cyan');
fps_text = text(50, 120, ['FPS: ', 0], 'Color', [0 1 1], 'FontSize', 10);
speed_text = uicontrol('Style', 'text', 'Position', [20, 45, 120, 20],...
    'String', 'Speed of simulation', 'ForegroundColor', [0 1 1], 'BackgroundColor', [0, 0, 0]);
speed_slider = uicontrol('Style', 'slider', 'SliderStep', [1/80 1/80],...
    'Min', 0, 'Max', 40, 'Value', 1, 'Position', [20, 20, 120, 20]); 

set(ha, 'handlevisibility', 'off', 'visible', 'off')


material dull               %planet reflects more diffuse light and has no specular highlights
shading interp              %surfaces of planets won't be pixelated

% === start ===
AU = 10;                    % definition of one astronomical unit (distance earth to sun)
radius = 10;                % scale of size of planets (log10)
resolution = 50;

% some positions
pos_saturn = [0, 0, 9.58*AU;...
              0, 0, 0;...
              0, 0, 0];

pos_earth = [0, 0, AU;...
             0, 0, 0;...
             0, 0, 0];
axis_earth = [cosd(66.6), 0, sind(66.6)];


% --- creating the planets ---
sun           = getSun(resolution*4,    'imgs/sun.jpg',           [0, 0, 0],       log10(109.178*radius)*ones(1,3));

mercury       = getPlanet(resolution,   'imgs/mercury.jpg',       [0.39*AU, 0, 0], log10(0.382*radius)*ones(1,3), 0, [96, 96, 129]./255);
venus         = getPlanet(resolution,   'imgs/venus.jpg',         [0.73*AU, 0, 0], log10(0.95*radius)*ones(1,3),  0, [198, 157, 91]./255);

earth         = getPlanet(resolution*4, 'imgs/earth.jpg',        [pos_earth(1,3), pos_earth(2,3), pos_earth(3,3)],   log10(radius)*ones(1,3),      23.4, [110, 155, 73]./255);
moon          = getPlanet(resolution,   'imgs/moon.jpg',          [(AU+log10(radius*0.27*radius)+(0.0025*AU)), 0, 0], log10(0.27*radius)*ones(1,3) , 23.4, [0 0 0]);
rotate(moon, [0,1,0], 23.4, [pos_earth(1,3), pos_earth(2,3), pos_earth(3,3)]);

mars          = getPlanet(resolution,   'imgs/mars.jpg',          [1.38*AU, 0, 0], log10(0.533*radius)*ones(1,3), 0, [159, 117, 69]./255);
jupiter       = getPlanet(resolution,   'imgs/jupiter.jpg',       [5.2*AU, 0, 0],  log10(11.21*radius)*ones(1,3), 0, [230, 190, 165]./255);

saturn        = getPlanet(resolution,   'imgs/saturn-sphere.jpg', [pos_saturn(1,3), pos_saturn(2,3), pos_saturn(3,3)], log10(9.449*radius)*ones(1,3), 26, [208, 183, 152]./255);
saturn_ring   = getRing(resolution,     'imgs/saturn-ring.jpg', 3.5, 1, [pos_saturn(1,3), pos_saturn(2,3), pos_saturn(3,3)], [1,1,1/15], 26);

uranus        = getPlanet(resolution,   'imgs/uranus.jpg',        [19.22*AU, 0, 0], log10(4.01*radius)*ones(1,3), 0, [135, 193, 215]./255);
neptune       = getPlanet(resolution,   'imgs/neptune.jpg',       [30.1*AU, 0, 0],  log10(3.88*radius)*ones(1,3), 0, [60, 88, 185]./255);

% --- Run simulation ---
while 1
    tic();
    
    speed = get(speed_slider, 'Value');
    M_rot_sat = [cosd(0.034*speed), -sind(0.034*speed), 0;...
                 sind(0.034*speed),  cosd(0.034*speed), 0;...
                 0,                  0,                 1];
    M_rot_earth = [cosd(speed), -sind(speed), 0;...
                   sind(speed),  cosd(speed), 0;...
                   0,            0,           1];

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
    rotate(sun, [0,0,1], 40*speed, [0,0,0])

    pos_saturn = M_rot_sat * pos_saturn;
    rotate(saturn, [0,0,1], -0.034*speed, [pos_saturn(1,3), pos_saturn(2,3), pos_saturn(3,3)])
    rotate(saturn_ring, [0,0,1], -0.034*speed, [pos_saturn(1,3), pos_saturn(2,3), pos_saturn(3,3)])

    pos_earth = M_rot_earth * pos_earth;
    rotate(earth, axis_earth, 36*speed, [pos_earth(1,3), pos_earth(2,3), pos_earth(3,3)])

    % Moons
    rotate(moon, axis_earth, 13.3795*speed, [pos_earth(1,3), pos_earth(2,3), pos_earth(3,3)])

    drawnow;

    fps = num2str(round((1/toc())*10)/10);
    fps_text.String = ['FPS: ', fps];
end
