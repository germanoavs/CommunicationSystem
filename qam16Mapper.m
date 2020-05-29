%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: 16-QAM MAPPER
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: 
% --@ ARGUMENT 'bvec': bistream 
% --$ OUTPUT 'Im_vec': real part of IQ symbol
% --$ OUTPUT 'Qm_vec': imaginary part of IQ symbol
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Im_vec, Qm_vec] = qam16Mapper(b)
    Im_vec = zeros(1, length(b)/4);
    Qm_vec = Im_vec;
    b = logical(b);
    
    k = 1:4:length(b);
    j = ceil(k/4);
    Im_vec(j) = (~b(k) & ~b(k+1))*-3 +...
                (~b(k) & b(k+1))*-1 +...
                (b(k) & ~b(k+1))*3 +...;
                (b(k) & b(k+1))*1;
    
    
    Qm_vec(j) = (~b(k+2) & ~b(k+3))*3 +...
                (~b(k+2) & b(k+3))*1 +...
                (b(k+2) & ~b(k+3))*-3 +...
                (b(k+2) & b(k+3))*-1;
end


