clear;close;clc;

Fc = 32e3;                                                      % carrier frequency 
Fs = 256e3;                                                     % sample frequency
symbolRate = 16e3;
mod = 'QPSK';                                                   % modulation, 'QPSK' or '16QAM'


SNR = -10:1:20;                                                 % SNR(dB)
BERcc = zeros(1, length(SNR));                                  % BER coded channel
BER = BERcc;

b = randi([0 1], 1, 50e3);                                      % random bits

b_coded = blockCoder(b);                                        % channel coding

uRxCoded = mod416(b_coded, mod, Fc, Fs, symbolRate);            % modulation
uRx = mod416(b, mod, Fc, Fs, symbolRate);

for k = 1:length(SNR)
    uTxCoded = awgn(uRxCoded, SNR(k), 'measured');              % add noise
    uTx = awgn(uRx, SNR(k), 'measured');

    bRxCoded = demod(uTxCoded, mod, Fc, Fs, symbolRate);        % demodulation
    bRx = demod(uTx, mod, Fc, Fs, symbolRate);
    
    bRx_decoded = blockDecoder(bRxCoded);                       % channel decoding
    
    [~, BERcc(k)] = biterr(b, bRx_decoded);                     % get BERcc
    [errors, BER(k)] = biterr(b, bRx);                          % get BERcc
end

%% Plot BER x SNR
p1 = semilogy(SNR, BER, '-o');
p1.LineWidth = 1;
p1.Color = 'r';

hold on 
grid on

p2 = semilogy(SNR, BERcc, '-o');
p2.LineWidth = 1;
p2.Color = 'g';

xlabel('SNR');
ylabel('BER')
legend('BER', 'BER coded channel')
title('BER x SNR QPSK/16-QAM')




