%%
%[ x,y,z ] = positionQuery( [] , [] );
clear all;clc;
%%
    global v;
    v = 0.3432; %km\s @ air
    xyzSource = [2 3 0]; %source of sound
    
    xyz0 = [4 4 0]; %the first station that recieves the sound wave
    
    %the other 7 , sorted by time of recieve (distance from emitter)
    xyz(1,:) = [6 1 0];
    xyz(2,:) = [-3 5 0];
    xyz(3,:) = [-1 -6 0];
    xyz(4,:) = [-6 9 0];
    xyz(5,:) = [12 10 0];
    xyz(6,:) = [-12 -10 0];
    xyz(7,:) = [15 -13 0];
    
    n = size(xyz,1);
    
    
    r = [];
    %rSource = r;
    for i=1:n
        r = [r ((xyz(i,1)-xyzSource(1))^2+(xyz(i,2)-xyzSource(2))^2+(xyz(i,3)-xyzSource(3))^2)^0.5]; % get real distance from emitter for each and one of the stations
        %r = [r ((xyz(i,1)-xyz0(1))^2+(xyz(i,2)-xyz0(2))^2+(xyz(i,3)-xyz0(3))^2)^0.5];
    end
    %rSource = [((xyz0(1)-xyzSource(1))^2+(xyz0(2)-xyzSource(2))^2+(xyz0(3)-xyzSource(3))^2)^0.5 rSource];
    %rSource = rSource - rSource(1);
    
    r = [((xyz0(1)-xyzSource(1))^2+(xyz0(2)-xyzSource(2))^2+(xyz0(3)-xyzSource(3))^2)^0.5 r]; %add the first station at the begining of the array
    r = r - r(1); % normalize the distance to be related to the first station
    r = r(2:n+1); %save only the 2<=m<=N stations
    
    t = r/v; % get the time of arrival 
    
    % IMPORTANT!!
    % the last step of t=r/v will be the only input we will have @ real
    % system.. the procedures that were taken before is for our toy
    % simulation only
    %
    
    %distance = pdist(xyz);
    

      
      
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

        %saving the equation for possible later use ('solve' function)
        equation = strcat('0=(',num2str(A(i-1)),')*x+(',num2str(B(i-1)),')*y+(',num2str(C(i-1)),')*z+(',num2str(D(i-1)),')');
        eq(i-1) = {equation};
    end
     
    %solving the linear equations
    mat = [A B C];
    D = -1*D; 
    x = mat\D
    norm(mat*x-D)
    
   %%
   %below are some tries solving using the solve functions
%     syms x y z;
%     s=solve('0=(-3.8148)*x+(1.1726)*y+(0)*z+(4.9715)','0=(-3.0141)*x+(-1.5856)*y+(0)*z+(11.8133)','0=(-4.4049)*x+(-0.4714)*y+(0)*z+(10.7236)','0=(-0.53803)*x+(-0.4714)*y+(0)*z+(-0.96134)');
%     
%     [s.x s.y]
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
%     syms x y r1 r2 r3 r0;
%     S = solve('r0 = ((x)^2+(y)^2)^0.5',...
%           'r1 = ((6-x)^2+(1-y)^2)^0.5',...
%           'r2 = ((-3-x)^2+(5-y)^2)^0.5',...
%           'r3 = ((-1-x)^2+(-6-y)^2)^0.5',...
%           strcat(num2str(distance(1)),' = abs(r1 - r2)'),...
%           strcat(num2str(distance(2)),' = abs(r1 - r3)'),...
%           strcat(num2str(distance(3)),' = abs(r2 - r3)'))
%       
%       [S.x S.y S.r1 S.r2 S.r3 S.r0] 
%       
%       %%
%       syms x ;
%       solutions_x = solve('5 = abs(8 - x)')
      
      %%

      