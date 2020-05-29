%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION: demod
% AUTHOR:   GERMANO SOBROZA
% DESCRIPTION: This channel demodulate a signal on time domain 
% and returns the bitstream
% --@ ARGUMENT 'u': signal modulated on time domain
% --$ OUTPUT out: bit string demodulated 
% Data: 12/04/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bitsRx = demod(u, mod, Fc, Fs, symbolRate)
    k = Fs / symbolRate;

    % heterodinação 
    n = 0:length(u)-1;
    ik = u .* cos(2*pi*(Fc*n/Fs));
    qk = -1*u .* sin(2*pi*(Fc*n/Fs));

    % Gaus sequence used on modulation
    c = [0.003 0.0118 0.039 0.1051 0.2367 0.4445 0.6972 0.9138...
        1 0.9138 0.6972 0.4445 0.2367 0.1051 0.039 0.0118];

    ikf = conv(ik, c,'same');
    qkf = conv(qk, c,'same');

    im = downsampler(ikf, c, k);
    qm = downsampler(qkf, c, k);

    % automatic gain control
            % V = max(abs(im)) on first round
    Vimax = strcmp(mod, 'QPSK')*2.1559 + strcmp(mod, '16QAM')*6.4676;
    Vqmax = strcmp(mod, 'QPSK')*2.0190 + strcmp(mod, '16QAM')*6.0570;

    aux = strcmp(mod, '16QAM')*3 + strcmp(mod,'QPSK')*1;
    im = im*aux/Vimax;
    qm = qm*aux/Vqmax;

    % demapper
    if strcmp('QPSK', mod)
        bitsRx = demapperQPSK(im, qm);
    else
        bitsRx = demapper16QAM(im, qm);
    end
end



