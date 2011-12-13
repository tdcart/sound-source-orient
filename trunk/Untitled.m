%%
%[ x,y,z ] = positionQuery( [] , [] );
clear all;clc;
%%
    global v;
    v = 333; %m\s @ air
      
    xyz0 = [3 4 0];
    
    xyz = zeros(5,3);
    xyz(1,:) = [6 1 0];
    xyz(2,:) = [-3 5 0];
    xyz(3,:) = [-1 -6 0];
    xyz(4,:) = [-13 0 0];
    xyz(5,:) = [20 0 0];
    
    
    
    t = ([xyz0;xyz]);
    
    t = [];
    for i=1:5
        t = [t ((xyz(i,1)-xyz0(1))^2+(xyz(i,2)-xyz0(2))^2+(xyz(i,3)-xyz0(3))^2)^0.5];
    end
    t = t/v;
    t0 = 0;
    
    distance = pdist(xyz);
    

      
      n = size(xyz,1);
%       A = zeros(n,1);
%       B = A;
%       C = A;
%       D = A;
      
      vt1 = v*t(1);
      xDt = 2*xyz(1,1)/vt1;
      yDt = 2*xyz(1,2)/vt1;
      zDt = 2*xyz(1,3)/vt1;
      
      xyz1Dvt1 = (xyz(1,1)^2 + xyz(1,2)^2 + xyz(1,3)^2)/vt1;
      
      eq = [];
      for i=2:n
        vti = (v*t(i));
        A = 2*xyz(i,1)/vti - xDt;
        B = 2*xyz(i,2)/vti - yDt;
        C = 2*xyz(i,3)/vti - zDt;
        D = vti - vt1 - ((xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2)/vti) + xyz1Dvt1;
        
        eq = [eq;strcat(num2str(A),'*x+',num2str(B),'*y+',num2str(C),'*z+',num2str(D))];
      end
      

    
    %rS = triu(sym('r',[4 4]),1);
%     syms x y r1 r2 r3 r0;
%     S = solve('r1 = ((6-x)^2+(1-y)^2)^0.5',...
%           'r2 = ((-3-x)^2+(5-y)^2)^0.5',...
%           'r3 = ((-1-x)^2+(-6-y)^2)^0.5',...
%           '5 = abs(r1 - r0)',...
%           '10 = abs(r2 - r0)',...
%           '5 = abs(r3 - r0)')
%     [S.x S.y S.r1 S.r2 S.r3 S.r0] 
      
      %%
    syms x y r1 r2 r3 r0;
    S = solve('r0 = ((x)^2+(y)^2)^0.5',...
          'r1 = ((6-x)^2+(1-y)^2)^0.5',...
          'r2 = ((-3-x)^2+(5-y)^2)^0.5',...
          'r3 = ((-1-x)^2+(-6-y)^2)^0.5',...
          strcat(num2str(distance(1)),' = abs(r1 - r2)'),...
          strcat(num2str(distance(2)),' = abs(r1 - r3)'),...
          strcat(num2str(distance(3)),' = abs(r2 - r3)'))
      
      [S.x S.y S.r1 S.r2 S.r3 S.r0] 
      
      %%
      syms x ;
      solutions_x = solve('5 = abs(8 - x)')
      
      %%

      