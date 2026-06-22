function rxBits = OFDM_Transmission(bits,EbN0_dB,Nfft,CP)

%% BPSK Mapping
modData = 2*bits - 1;

%% Store Original Length
L = length(modData);

%% Zero Padding
numSym = ceil(L/Nfft);
padLength = numSym*Nfft - L;

modData = [modData; zeros(padLength,1)];

%% Serial-to-Parallel
txMatrix = reshape(modData,Nfft,[]);

%% OFDM Modulation
txOFDM = ifft(txMatrix,Nfft);

%% Add Cyclic Prefix
txCP = [txOFDM(end-CP+1:end,:); txOFDM];

%% Parallel-to-Serial
txSerial = txCP(:);

%% AWGN Channel
rxSerial = awgn(txSerial,EbN0_dB,'measured');

%% Serial-to-Parallel
rxParallel = reshape(rxSerial,Nfft+CP,[]);

%% Remove CP
rxParallel = rxParallel(CP+1:end,:);

%% FFT
rxFFT = fft(rxParallel,Nfft);

%% BPSK Demodulation
rxBits = real(rxFFT(:)) > 0;

%% Remove Padding
rxBits = rxBits(1:L);

end