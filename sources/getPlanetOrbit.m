function orbit = getPlanetOrbit(center, normal, radius, color)
    theta = 0:0.01:(2*pi+0.01);
    v = null(normal);
    points = repmat(center',1,size(theta,2))+radius*(v(:,1)*cos(theta)+v(:,2)*sin(theta));
    orbit = plot3(points(1,:),points(2,:),points(3,:),'Color',color);
end
