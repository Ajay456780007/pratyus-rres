function rxBits = NOMA_Transmission(bits,EbN0_dB)

alpha1 = 0.8;
alpha2 = 0.2;

s1 = 2*bits-1;

s2 = 2*randi([0 1],length(bits),1)-1;

tx = sqrt(alpha1)*s1 + sqrt(alpha2)*s2;

rx = awgn(tx,EbN0_dB,'measured');

rxBits = real(rx)>0;

end