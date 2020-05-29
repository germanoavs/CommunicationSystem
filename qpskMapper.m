%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: QPSK MAPPER
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: 
% --@ ARGUMENT 'bvec': bistream 
% --$ OUTPUT 'Im_vec': real part of IQ symbol
% --$ OUTPUT 'Qm_vec': imaginary part of IQ symbol
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Im_vec, Qm_vec] = qpskMapper(bvec)
    Im_vec = zeros(1, length(bvec)/2);
    Qm_vec = Im_vec;
    
    k = 1:2:length(bvec);
    j = ceil(k/2);
    Im_vec(j) = (~bvec(k+1))*1 + (bvec(k+1))*-1;
    Qm_vec(j) = (bvec(k))*-1 + (~bvec(k))*1;
end



