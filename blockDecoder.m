%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: Block Decoder 
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: Channel decoder using block coder. sTable pre definied.
% --@ ARGUMENT y: bit string multiple of 5
% --$ OUTPUT out: bit string decoded 
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function out = blockDecoder(y)
    H = [1 1 1 0 0;...
         1 0 0 1 0;...
         0 1 0 0 1];
    % 'sTable' modified to rows in crescent order
    sTable = [0 0 0 0 0;... %000     
              0 0 0 0 1;... %001
              0 0 0 1 0;... %010
              1 1 0 0 0;... %011
              0 0 1 0 0;... %100
              0 1 0 0 0;... %101
              1 0 0 0 0;... %110
              1 0 0 0 1];   %111
    b = 5;

    y_gf = gf(y, 2);
  
    y_gf = reshape(y_gf, b, []).';    % wich 5 bit word in one row
    H_gf = gf(H', 2);
    
    s_gf = y_gf * H_gf;         % calculate syndrome
    
    indice = bi2de(double(s_gf.x), 'left-msb');
    e = sTable(indice + 1, :);      % standard error for wich syndrome 
    e_gf = gf(e, 2);
    
    r_gf = y_gf + e_gf;
    
    out_gf = r_gf(:, 1:2);
    out_gf = reshape(out_gf.', 1, []);
    out = double(out_gf.x)
end
