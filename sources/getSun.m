function sun = getSun(resolution, img, pos, scale, ambStrength)
    [x,y,z] = sphere(resolution);
    x = x*scale(1) + pos(1); y = y*scale(2) + pos(2); z = z*scale(3) + pos(3);
    
    texture = flipud(imresize(im2double(imread(img)),size(x)));
    sun = surf(x, y, z, texture,'EdgeColor', 'none');

    sun.AmbientStrength = 0.85;

    % Sun light
    light('Position', pos,'Style', 'local');
    lighting flat;
end
