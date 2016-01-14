function ring = getRing(resolution, img, radius, width, pos, scale, tiltD)
    phi = linspace(0,2*pi,resolution)';
    alpha = linspace(0,2*pi,resolution*10)';

    tmp = [radius + width*cos(phi), width*sin(phi)];
    x = cos(alpha)*tmp(:,1)';
    y = sin(alpha)*tmp(:,1)';
    z = tmp(:,2)';
    z = z(ones(1,length(alpha)),:);

    x = x*scale(1) + pos(1); y = y*scale(2) + pos(2); z = z*scale(3) + pos(3);
    
    texture = flipud(imresize(im2double(imread(img)),size(x)));
    ring = surf(x, y, z, texture, 'EdgeColor', 'none');
    rotate(ring, [0, 1, 0], tiltD, pos);
end
