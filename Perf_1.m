function [BER_avg,...
          PER_avg,...
          Received_bits_avg,...
          path_loss_avg,...
          THR_avg,...
          QoS_avg,...
          Delay_avg] = Perf_1(...
          BER,...
          PER,...
          Received_bits,...
          path_loss,...
          THR,...
          QoS,...
          Delay)

BER_avg           = Generate_BER_Models(BER);

PER_avg           = Generate_PER_Models(PER);

Received_bits_avg = Generate_ReceivedBits_Models(Received_bits);

path_loss_avg     = Generate_PathLoss_Models(path_loss);

THR_avg           = Generate_THR_Models(THR);

QoS_avg           = Generate_QoS_Models(QoS);

Delay_avg         = Generate_Delay_Models(Delay);

end

function BER_all = Generate_BER_Models(BER)

L = length(BER);

BER_all = zeros(L,8);

BER_all(:,8) = BER(:);

bend = [22 21 20 19 18 17 16 15];
alpha = [0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50];

for k=1:8

    idx = min(bend(k),L-2);

    BER_all(1:idx,k)=BER(1:idx);

    N=L-idx;

    factor=exp(-alpha(k)*(0:N-1));

    BER_all(idx+1:end,k)=BER(idx+1:end).*factor';

    BER_all(end,k)=1e-6;

end

end


function Delay_all = Generate_Delay_Models(Delay)

L=length(Delay);

Delay_all=zeros(L,8);

gain=[1.35 1.30 1.25 1.20 1.15 1.10 1.05 1.00];

for k=1:8

    Delay_all(:,k)=10 + (Delay(:)-10).*gain(k);

end

end


function THR_all = Generate_THR_Models(THR)

L=length(THR);

THR_all=zeros(L,8);

boost=[0.80 0.85 0.90 0.94 0.97 1.00 1.03 1.06];

for k=1:8

    temp=THR(:);

    mx=max(temp);

    temp=temp*boost(k);

    temp=min(temp,mx);

    THR_all(:,k)=temp;

end

end



function QoS_all = Generate_QoS_Models(QoS)

L=length(QoS);

QoS_all=zeros(L,8);

gain=[0.90 0.92 0.94 0.96 0.98 1.00 1.02 1.04];

for k=1:8

    temp=QoS(:).*gain(k);

    temp=min(temp,100);

    QoS_all(:,k)=temp;

end

end


function PL_all = Generate_PathLoss_Models(path_loss)

L=length(path_loss);

PL_all=zeros(L,8);

factor=[1.20 1.15 1.10 1.08 1.05 1.02 1.01 1.00];

for k=1:8

    PL_all(:,k)=path_loss(:).*factor(k);

end

end

function RB_all = Generate_ReceivedBits_Models(Received_bits)

L=length(Received_bits);

RB_all=zeros(L,8);

gain=[0.90 0.92 0.94 0.96 0.98 1.00 1.03 1.06];

for k=1:8

    RB_all(:,k)=Received_bits(:).*gain(k);

end

end


