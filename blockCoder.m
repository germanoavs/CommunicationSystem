%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: Block Coder 
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: 
% --@ ARGUMENT 'in': bit string multiple of 2 
% --$ OUTPUT 'output': coded bit string multiple of 5 
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = blockCoder(in)
    table = [0 0 0 0 0;...      % reference table 
             0 1 1 0 1;...
             1 0 1 1 0;...
             1 1 0 1 1];
    b = 2;                      % bit per word 
    
    in = reshape(in, b, []).';
    indice = bi2de(in, 'left-msb');     %indice to index 'table'
    
    output = table(indice+1, :);
    output = reshape(output.', 1, []);
end












