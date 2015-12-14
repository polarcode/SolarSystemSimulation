[x,y,z] = sphere(50);



x = x.*2;

%mesh(x,y,z);
surf(x,y,z);

axis([-3,3,-3,3,-3,3])