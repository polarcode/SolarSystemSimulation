clear
t = 0:pi/10:2*pi;
figure(1)
hold on
axis([-5, 5, -5, 5, -5, 5])
grid on;

[X1,Y1,Z1] = sphere(30);
[X2,Y2,Z2] = sphere(30);

hg = hggroup;

asdf1 = surf(X1,Y1,Z1,'parent',hg);
asdf2 = surfl(X2+2,Y2+2,Z2);


axis square

% asdf1.EdgeColor = 'none';
asdf1.BackFaceLighting = 'unlit'
% asdf1.AmbientStrength = 0
% asdf1.DiffuseStrength = 1
asdf1.DiffuseStrength = 0.9
%asdf2.EdgeColor = 'none';

%light
light('Position',[0,1,0],'Style','local','visible','on');
%light('Position','camlight','Style','local','visible','on');
% light('Position',[-1,-1,0],'Style','local','visible','on');
% light('Position',[1,1,0],'Style','local','visible','on');
% light('Position',[1,-1,0],'Style','local','visible','on');
% light('Position',[0,0,1.1],'Style','local','visible','on');
% light('Position',[0,0,-1.1],'Style','local','visible','on');
lighting gouraud
%lighting none
%material dull

shading interp

while 1
    rotate(asdf2, [0,0,1], 1,[0,0,0])
    drawnow
end
