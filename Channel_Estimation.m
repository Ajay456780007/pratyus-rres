function [BestChannel, ChannelGain, ChannelSNR] = ...
            Channel_Estimation(NumChannels,EbN0)

ChannelGain = abs(randn(1,NumChannels) + ...
                 1j*randn(1,NumChannels));

ChannelSNR = EbN0 + ...
             20*log10(ChannelGain);

[~,BestChannel] = max(ChannelSNR);

end