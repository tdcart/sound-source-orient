function [ x,y,z ] = positionQuery( stationPositions , stationDistance )
    
    if(isempty(stationPositions) | isempty(stationDistance))
        x = [];
        y = [];
        z = [];
        return;
    end
    
    syms x y z;
    [solutions_x, solutions_y, solutions_z] =...
    solve('a*u^2 + v^2', 'u - v = 1', 'a^2 - 5*a + 6')

end

