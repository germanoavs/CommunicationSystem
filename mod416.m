%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: QPsk/16-QAM MODULATOR
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: 
% --@ ARGUMENT 'b': bistream 
% --@ ARGUMENT 'Fc': carrier frequency
% --@ ARGUMENT 'Fs': sample rate
% --@ ARGUMENT 'symbolRate': sym Rate   
% --$ OUTPUT 'modulation': string 'QPSK' or '16QAM'
% --$ OUTPUT 'u': modulated signal u in time domain
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function u = mod416(b, modulation, Fc, Fs, symbolRate)
    
    k = Fs / symbolRate;

    if strcmp('QPSK', modulation)
        [im, qm] = qpskMapper(b);
    elseif strcmp('16QAM', modulation)
        [im, qm] = qam16Mapper(b);
    else
        fprintf('error');
    end

    ik = upsampler(im, k);          % increase samples
    qk = upsampler(qm, k);

    % Gausian sequency used on the filter
    c = [0.003 0.0118 0.039 0.1051 0.2367 0.4445 0.6972 0.9138...
        1 0.9138 0.6972 0.4445 0.2367 0.1051 0.039 0.0118];

    ikFiltered = filter(c,1,ik);
    qkFiltered = filter(c,1,qk);

    n = 0:length(ik)-1;
    ui = ikFiltered .* cos(2*pi*(Fc*n/Fs));
    uq = qkFiltered .* sin(2*pi*(Fc*n/Fs));

    u = ui - uq;        % modulated signal
end




