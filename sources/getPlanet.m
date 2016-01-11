function [planet,orbit] = getPlanet(resolution, imgFile, pos, scale, tiltD, orbitColor)
    [x,y,z] = sphere(resolution);
    x = x*scale(1) + pos(1); y = y*scale(2) + pos(2); z = z*scale(3) + pos(3);
    
    texture = flipud(imresize(im2double(imread(imgFile)),size(x)));
    planet = surf(x, y, z, texture,'EdgeColor', 'none');

    rotate(planet, [0,1,0], tiltD, [pos]);
    
    planet.AmbientStrength = 0.20;
    planet.DiffuseStrength = 1.0;
    planet.SpecularStrength = 0.0;

    if norm(orbitColor) > 0
        orbit = getPlanetOrbit([0,0,0], [0,0,1], norm(pos), orbitColor);
    end
end
