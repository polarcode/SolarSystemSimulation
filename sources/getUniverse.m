function [sun, earth, mars, saturn, saturn_ring] = getUniverse(AU, radius, resolution)

    sun = getPlanet(resolution, 'imgs/sun.jpg', [0,0,0], log10(109.178*radius)*ones(1,3));

    earth = getPlanet(resolution, 'imgs/earth2.jpg', [AU,0,0], log10(radius)*ones(1,3));

    mars = getPlanet(resolution, 'imgs/mars.jpg', [1.38*AU,0,0], log10(0.533*radius)*ones(1,3));

    saturn_pos = [9.58*AU, 0, 0];
    saturn = getPlanet(resolution, 'imgs/saturn-sphere.jpg', saturn_pos, log10(9.449*radius)*ones(1,3));
    saturn_ring = getRing(resolution, 'imgs/saturn-ring3.jpg', 3.5, 1, saturn_pos, [1,1,1/15]);
    rotate(saturn_ring,[0 1 1],45,saturn_pos);
end

function planet = getPlanet(resolution , img, pos, scale)
    [x,y,z] = sphere(resolution);
    x = x*scale(1) + pos(1); y = y*scale(2) + pos(2); z = z*scale(3) + pos(3);
    
    texture = flipud(imresize(im2double(imread(img)),size(x)));
    planet = surf(x, y, z, texture, 'EdgeColor', 'none');
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
