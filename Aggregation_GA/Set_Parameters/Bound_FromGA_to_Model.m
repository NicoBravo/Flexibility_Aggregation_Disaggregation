function [Bound_Umin,Bound_Umax,Bound_Xmin,Bound_Xmax]=Bound_FromGA_to_Model ...
                (x0, x)
% from GA model result, generate VB bounds
    [b1,b2,b3,b4]=Extract_from_vector(x);
    a=x(1);
    h=length(b1);
    Bound_Umin = -b1;  % b1=-Umin
    Bound_Umax = b2;   % b2=Umax
    F=matrixF(a,h); 
    Bound_Xmin = -b3 + F*x0;
    Bound_Xmax =  b4 - F*x0;

end

