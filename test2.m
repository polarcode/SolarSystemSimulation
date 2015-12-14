t = 0:pi/10:2*pi;
figure
[X,Y,Z] = cylinder(10);
asdf = surf(X,Y,Z)
axis square
axis([-20, 20, -20, 20, -20, 20])
rotate(asdf, [1,0,0], 90)
while 1
    rotate(asdf, [0,0,1], 1,[10,0,0])
    drawnow
end
