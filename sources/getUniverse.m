function [sun, mercury, venus, earth, moon, mars, jupiter, saturn, saturn_ring, uranus, neptune] = getUniverse(AU, radius, resolution)
    sun = getPlanet(4*resolution, 'imgs/sun.jpg', [0,0,0], log10(109.178*radius)*ones(1,3));
    mercury = getPlanet(resolution, 'imgs/mercury.jpg', [0.39*AU,0,0], log10(0.382*radius)*ones(1,3));
    venus = getPlanet(resolution, 'imgs/venus.jpg', [0.73*AU,0,0], log10(0.95*radius)*ones(1,3));
    
    earth_pos = [AU,0,0];
    earth = getPlanet(4*resolution, 'imgs/earth2.jpg', earth_pos, log10(radius)*ones(1,3));
    rotate(earth, [0,1,0], 24, earth_pos);
    moon = getPlanet(resolution, 'imgs/moon.jpg', [(AU+log10(radius*0.27*radius)+(0.0025*AU)),0,0], log10(0.27*radius)*ones(1,3));
    
    mars = getPlanet(resolution, 'imgs/mars.jpg', [1.38*AU,0,0], log10(0.533*radius)*ones(1,3));
    jupiter = getPlanet(resolution, 'imgs/jupiter.jpg', [5.2*AU,0,0], log10(11.21*radius)*ones(1,3));

    saturn_pos = [9.58*AU, 0, 0];
    saturn = getPlanet(resolution, 'imgs/saturn-sphere.jpg', saturn_pos, log10(9.449*radius)*ones(1,3));
    saturn_ring = getRing(resolution, 'imgs/saturn-ring3.jpg', 3.5, 1, saturn_pos, [1,1,1/15]);
    rotate(saturn_ring,[0 1 1],45,saturn_pos);

    uranus = getPlanet(resolution, 'imgs/uranus.jpg', [19.22*AU,0,0], log10(4.01*radius)*ones(1,3));
    neptune = getPlanet(resolution, 'imgs/neptune.jpg', [30.1*AU,0,0], log10(3.88*radius)*ones(1,3));

end

function planet = getPlanet(resolution , img, pos, scale)
    [x,y,z] = sphere(resolution);
    x = x*scale(1) + pos(1); y = y*scale(2) + pos(2); z = z*scale(3) + pos(3);
    
    texture = flipud(imresize(im2double(imread(img)),size(x)));
    planet = surf(x, y, z, texture,'EdgeColor', 'none');
end

function ring = getRing(resolution, img, radius, width, pos, scale)
    phi = linspace(0,2*pi,resolution)';
    alpha = linspace(0,2*pi,resolution*10)';

    tmp=[radius + width*cos(phi), width*sin(phi)];
    x = cos(alpha)*tmp(:,1)';
    y = sin(alpha)*tmp(:,1)';
    z = tmp(:,2)';
    z = z(ones(1,length(alpha)),:);

    x = x*scale(1) + pos(1); y = y*scale(2) + pos(2); z = z*scale(3) + pos(3);
    
    texture = flipud(imresize(im2double(imread(img)),size(x)));
    ring = surf(x, y, z, texture, 'EdgeColor', 'none');
end