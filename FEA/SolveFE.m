% Solve Partitioned Finite Element Matrix System
%
% Copyright (C) Arif Masud and Tim Truster
% 7/2009
% UIUC

%Move Constrained DOF to RHS

Fdtilda = zeros(neq,1);
rhs= zeros(neq,1);
for i = 1:neq
    
    rhs = zeros(neq,1);
    for j = 1:nieq
       rhs(i) = rhs(i) + Kdf(i,j)*ModelDc(j);
    end
    Fdtilda(i) = Fd(i) - rhs(i);  
    
end

% Solving the Linear System : 

Mstar = Mdd/beta/delt^2+(1+alpha)*Kdd  ;
R = (1+alpha)*(FEXT(:,n+1)-F_bar_int) - alpha*(FEXT(:,n)-IntF_store(:,n))- Mdd * (delt^2/2*(1-2*beta)*an(:,n)+delt*vn(:,n))/delt^2/beta;

ModelDx = mldivide(Mstar,R);

% Updating the displacement iterate (corrector): 

d(:,storej+1)  = d(:,storej) + ModelDx;

% if max(abs(d(:,storej) + ModelDx)) > 0.42
%     d(:,storej+1)  = d(:,storej) + ModelDx;
% else
%     d(:,storej+1)  = d(:,storej) + ModelDx;
% end
% 
% for index1 = 1:length(d(:,storej+1))
%     if d(index1,storej+1) > 0
%         d(index1,storej+1) = min(d(index1,storej+1),0.3);
%     else
%         if d(index1,storej+1) < 0
%             d(index1,storej+1) = max(d(index1,storej+1),-0.42);
%         end
%     end   
% end


% Updating the velocity and acceleration iterate (corrector) :
acc(:,storej+1) = 1/beta/delt^2*(d(:,storej+1)-dn(:,n) - delt * vn(:,n))-(1/(2*beta)-1)*an(:,n);
v(:,storej+1)  = vn(:,n) + delt*((1-gamma)*an(:,n) + gamma*acc(:,storej+1));

% Updating the Residual for the iterate : 
res = norm(abs(R));



