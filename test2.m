t = 0:pi/10:2*pi;
figure
[X,Y,Z] = sphere(30);
asdf = surf(X,Y,Z)
axis square
axis([-5, 5, -5, 5, -5, 5])
asdf.EdgeColor = 'none';
rotate(asdf, [1,0,0], 90)

%Sun light
light('Position',[3 3 0],'Style','local');
lighting flat
%lighting gouraud

%material shiny
%material dull
%material metal

while 1
    rotate(asdf, [0,0,1], 1,[0.5,0,0])
    drawnow
end
