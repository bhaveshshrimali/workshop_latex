% Assemble Quantities from Model Routine
%
% Copyright (C) Arif Masud and Tim Truster
%
% 7/2009
% UIUC

Kdd = zeros(neq,neq);
Kdf = zeros(neq,nieq);
Kfd = zeros(nieq,neq);
Kff = zeros(nieq,nieq);
Fd = zeros(neq,1);
F_bar_int=zeros(neq,1);

for elem = 1:numel
    
    %Determine element size parameters
    if nen == 3
        nel = 3;
    elseif nen == 4
        if ix(elem,nen) == 0
            nel = 3;
        else
            nel = 4;
        end
    elseif nen == 6
        nel = 6;
    else
        if ix(elem,nen) == 0
            nel = 6;
        else
            nel = 9;
        end
    end
    
    nst = nel*ndf;
    
    %Extract patch nodal coordinates
    xl = zeros(ndm, nel);
    ElemFlag = zeros(nel, 1);
    
    for k = 1:nel
        node = ix(elem,k);
        ElemFlag(k) = node;
        for l = 1:ndm
            xl(l,k) = NodeTable(node,l);
        end
    end
    
    %Extract element nodal displacements
    EDOFT = LocToGlobDOF(ElemFlag, NDOFT, nel, ndf);
    
    ul = zeros(ndm,nel);
    for i = 1:nel*ndf
        ndof_index = EDOFT(i);
        if(ndof_index<=neq)
            ul(i) = d(ndof_index,storej);        
        else
            ul(i) = ModelDc(ndof_index-neq);
        end
    end
    
    %Compute stress and strain at the integration points
    [strain,stress,F,J,E] = CompStrainStress_Elem(mu1,mu2,kappa,xl,ul,nel,ndf);
    
    switch iel
        case 1 %Small-Deformation Non-linear Elastic Element
            if ndm == 3
                L_Elem1_3d
            else %ndm == 2
          %Modified to calculate the interal force vector of the element
                [ElemK,ElemF,fint,Dmat,GP,sigma] = Elast2d_Elem(mu1,mu2,kappa,xl,ul,nel,ndf,strain,stress,n);
            end
        case 2
            if ndm == 3

            else %ndm == 2
                L_Elem2_2d
            end
        case 3 %Stabilized Mixed Pressure-Displacement Element
            if ndm == 2
                L_Elem3_2d
            else %ndm == 3

            end
        case 4 %Implicit Error Element
            if ndm == 2
                L_Elem4_2d
            else %ndm == 3

            end
        case 5 %Stabilized Mixed Pressure-Displacement Element, Error
            if ndm == 2
                L_Elem5_2d
            else %ndm == 3

            end
    end

    %Assemble Element contribution to Model Quantity

    AssemStifForc
    
end