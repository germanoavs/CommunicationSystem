%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: UP SAMPLER
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: 
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function vec_upsampled = upsampler(vec, k)
    vec_upsampled = zeros(1, length(vec)*k);
    ind = 1:k:length(vec)*k;
    vec_upsampled(ind) = vec;
end





