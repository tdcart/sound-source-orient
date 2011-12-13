%%
%[ x,y,z ] = positionQuery( [] , [] );
clear all;clc;
%%
    global v;
    v = 0.3432; %km\s @ air
    xyz0 = [3 4 0];
    
    xyz = zeros(5,3);
    xyz(1,:) = [6 1 0];
    xyz(2,:) = [-3 5 0];
    xyz(3,:) = [-1 -6 0];
    xyz(4,:) = [-13 0 0];
    xyz(5,:) = [20 0 0];
    
    n = size(xyz,1);
    
    
    r = [];
    for i=1:n
        r = [r ((xyz(i,1)-xyz0(1))^2+(xyz(i,2)-xyz0(2))^2+(xyz(i,3)-xyz0(3))^2)^0.5];
    end
    t = r/v;
    t0 = 0;
    
    distance = pdist(xyz);
    

      
      
    A = zeros(n-1,1);
    B = A;
    C = A;
    D = A;
      
      vt1 = v*t(1);
      xDt1 = 2*xyz(1,1)/vt1;
      yDt1 = 2*xyz(1,2)/vt1;
      zDt1 = 2*xyz(1,3)/vt1;
      
      xyz1Dvt1 = (xyz(1,1)^2 + xyz(1,2)^2 + xyz(1,3)^2)/vt1;
      
      eq = cell(n-1,1);
      
      
      for i=2:n
        vti = (v*t(i));
        A(i-1) = 2*xyz(i,1)/vti - xDt1;
        B(i-1) = 2*xyz(i,2)/vti - yDt1;
        C(i-1) = 2*xyz(i,3)/vti - zDt1;
        D(i-1) = vti - vt1 - ((xyz(i,1)^2 + xyz(i,2)^2 + xyz(i,3)^2)/vti) + xyz1Dvt1;
        
        equation = strcat('0=(',num2str(A(i-1)),')*x+(',num2str(B(i-1)),')*y+(',num2str(C(i-1)),')*z+(',num2str(D(i-1)),')');
        eq(i-1) = {equation};
      end
      
      mat = [A B C];
      D = -1*D; 
      x = mat\D
      norm(mat*x-D)
    
   %%
    syms x y z;
    s=solve('0=(-3.8148)*x+(1.1726)*y+(0)*z+(4.9715)','0=(-3.0141)*x+(-1.5856)*y+(0)*z+(11.8133)','0=(-4.4049)*x+(-0.4714)*y+(0)*z+(10.7236)','0=(-0.53803)*x+(-0.4714)*y+(0)*z+(-0.96134)');
    
    [s.x s.y]
    %%
    
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

      