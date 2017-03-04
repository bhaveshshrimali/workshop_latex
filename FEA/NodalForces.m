%CEE 570
%Subroutine to calculate nodal forces

syms r s y real

% Defining shape functions in local coordinates
N1 = 1/4*(1-r)*(1-s);
N2 = 1/4*(1+r)*(1-s);
N3 = 1/4*(1+r)*(1+s);
N4 = 1/4*(1-r)*(1+s);

N=[N1 0;0 N1;N2 0;0 N2;N3 0;0 N3;N4 0;0 N4];

%% Calculate force vector at the right-hand boundary
for i=1:sinc
    
    y_coord(i,:)=[-C+(i-1)*2*C/sinc -C+(i-1)*2*C/sinc -C+i*2*C/sinc -C+i*2*C/sinc];  % coordinates at the boundrary
    y(i)=y_coord(i,1)*N1+y_coord(i,2)*N2+y_coord(i,3)*N3+y_coord(i,4)*N4;

    % Set the value for kesi at the right-hand boundrary
    Nr=subs(N,r,1);
    y(i)=subs(y(i),r,1);
    
    % Calculate Jacobian
    Jr(i)=diff(y(i),s);
    
    % Traction
    sigmaxx_r=0;
    sigmaxy=3*P*(C^2-y(i)^2)/(4*C^3);
    h=[sigmaxx_r;sigmaxy];
    
    % Calculate the element forces
    fhr(:,i)=int(Nr*h*Jr(i),s,-1,1);
end

% Combine the forces into global force matrix
Pr1y(1)=0;   
Pr2y(sinc+1)=0;
for i=1:sinc
     Pr1y(i+1)=fhr(6,i);
     Pr2y(i)=fhr(4,i);
end
Pry=(Pr1y+Pr2y)';
Pry=vpa(Pry);

%% Calculate force vector at the left-hand boundary
Ply=-Pry; 
for i=1:sinc
    
    y_coord(i,:)=[-C+(i-1)*2*C/sinc -C+(i-1)*2*C/sinc -C+i*2*C/sinc -C+i*2*C/sinc];  % coordinates at the boundrary
    y(i)=y_coord(i,1)*N1+y_coord(i,2)*N2+y_coord(i,3)*N3+y_coord(i,4)*N4;

    % Set the value for kesi at the right-hand boundrary
    Nl=subs(N,r,-1);
    y(i)=subs(y(i),r,-1);
    
    % Calculate Jacobian
    Jr(i)=diff(y(i),s);
    
    % Traction
    sigmaxx_l=3*P*(-L*y(i))/(2*C^3);
    sigmaxy=0;
    h=[sigmaxx_l;sigmaxy];
    
    % Calculate the element forces
    fhr(:,i)=int(Nl*h*Jr(i),s,-1,1);
end

% Combine the forces into global force matrix
Pl1x(1)=0;   
Pl2x(sinc+1)=0;
for i=1:sinc
     Pl1x(i+1)=fhr(1,sinc-i+1);
     Pl2x(i)=fhr(7,sinc-i+1);
end
Plx=(Pl1x+Pl2x)';
Plx=vpa(Plx);