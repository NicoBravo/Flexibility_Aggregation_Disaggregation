function [Bound_b1,Bound_b2,Bound_b3,Bound_b4]=Bound_FromModel_to_GA ...
                (x0, amin, amax, Bound_Umin,Bound_Umax,Bound_Xmin,Bound_Xmax)
% from VB model parameter, generate bounds used by algorithm
            
    h=length(Bound_Umin);
    Bound_b1 = -fliplr(Bound_Umin);  % b1=-Umin
    % fliplr just reverse the row
    Bound_b2 = Bound_Umax; % b2=Umax
    F3=matrixF(amax,h); % a=amax, bound of b3 is maximal
    Bound_b3 = -fliplr(Bound_Xmin) + F3*x0;
    Bound_b3 = [max(Bound_b3(:,1),0) Bound_b3(:,2)]; % origin must be contained
    F4=matrixF(amin,h); % a=amin, bound of b4 is maximal
    Bound_b4 = Bound_Xmax - F4*x0;
    Bound_b4 = [max(Bound_b4(:,1),0) Bound_b4(:,2)];
    

end

