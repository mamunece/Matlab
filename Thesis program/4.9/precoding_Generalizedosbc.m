
clear all; clf
%%%%%% Parameter Setting %%%%%%%%%
N_frame=100; N_packet=100; %Number of frames/packet and Number of packets
mod_order=2;
b=mod_order;
M=2^b; % Number of bits per symbol and Modulation order
mod_obj=modem.qammod('M',M,'SymbolOrder','Gray','InputType','bit');
demod_obj = modem.qamdemod(mod_obj);
% MIMO Parameters
T_TX=4; code_length=64;
NT=3; NR=1; % Numbers of transmit/receive antennas
N_pbits=T_TX*b*N_frame; N_tbits=N_pbits*N_packet;
code_book = codebook_generatorone;
fprintf('’====================================================\n’');
fprintf(' Precoding transmission');
fprintf('\n %d x %d MIMO\n %d QAM', NT,NR,M);
fprintf('\n Simulation bits : %d', N_tbits);
fprintf('\n====================================================\n');
SNRdBs = [0:2:20]; sq2=sqrt(2);
for i_SNR=1:length(SNRdBs)
SNRdB = SNRdBs(i_SNR);
sigma = sqrt((0.5)/(10^(SNRdB/10)))
rand('seed',1); randn('seed',1); N_ebits=0;
for i_packet=1:N_packet
msg_bit = randint(N_pbits,1); % Bit generation
%%%%%%%%%%%%% Transmitter %%%%%%%%%%%%%%%%%%
s = modulate(mod_obj, msg_bit );
Scale = modnorm(s,'avpow',1); % Normalization
S = reshape(Scale*s,4,1,N_frame); 
X=S;% Transmit symbol
a=[X(1,1,:) X(2,1,:) X(3,1,:)];
b=[-X(2,1,:) X(1,1,:) -X(4,1,:)];
 c=[-X(3,1,:) X(4,1,:) X(1,1,:)];
 d=[ -X(4,1,:) -X(3,1,:) X(2,1,:)];
Tx_symbol= [a; b; c; d;  conj(a); conj(b);conj(c); conj(d)]
%[X(1,1,:) X(2,1,:) X(3,1,:)./sqrt(2);-conj(X(2,1,:)) conj(X(1,1,:)) X(3,1,:)./sqrt(2);conj(X(3,1,:))./sqrt(2) conj(X(3,1,:))./sqrt(2)  (-X(1,1,:)-conj(X(1,1,:))+X(2,1,:)-conj(X(2,1,:)))./2; conj(X(3,1,:))./sqrt(2) -conj(X(3,1,:))./sqrt(2) (X(2,1,:)+conj(X(2,1,:))+X(1,1,:)-conj(X(1,1,:)))./2 ]

%[S(1,1,:) -(S(2,1,:)) -(S(3,1,:)) -(S(4,1,:)) ;S(2,1,:) (S(1,1,:)) (S(4,1,:)) -(S(3,1,:)) ;S(3,1,:) -(S(4,1,:)) (S(1,1,:)) (S(2,1,:)) ;S(4,1,:) (S(3,1,:)) -(S(2,1,:)) (S(1,1,:))  ];
%%%%%%%%%%%%% Channel and Noise %%%%%%%%%%%%%
H=(randn(NR,T_TX)+j*randn(NR,T_TX))/sq2;
for TX_index=1:T_TX% start of antenna selection
         ch(TX_index)=norm(H(:,TX_index),'fro'); 
      end
      [val,Index] = sort(ch,'descend');
      Index
      Hs = H(:,Index([1 2 3 4]))% end of antenna selection 
for i=1:code_length
cal(i) = norm(Hs*code_book(:,:,i),'fro');
end
[val,Index] = max(cal);
He = Hs*code_book(:,:,Index);
norm_H2 = norm(He)^2; % H selected and its norm2
for i=1:N_frame
Rx(:,:,i)=(He*Tx_symbol(:,:,i).')./sqrt(NT)+sigma*(randn(NR,8)+j*randn(NR,8));
end
%%%%%%%%%%%%% Receiver %%%%%%%%%%%%%%%%%%

for i=1:N_frame
    % y(1,i) = (He(1)'*Rx(:,1,i)+He(2)*Rx(:,2,i)')/norm_H2;
% y(2,i) = (He(2)'*Rx(:,1,i)-He(1)*Rx(:,2,i)')/norm_H2;

 y(1,i) = (Rx(:,1,i).*He(:,1)' +Rx(:,2,i) .*He(:,2)' + Rx(:,3,i).*He(:,3)'+Rx(:,5,i)'.*He(:,1) + Rx(:,6,i)'.*He(:,2) + Rx(:,7,i)'.*He(:,3))./norm_H2;
 y(2,i) = (Rx(:,1,i).*He(:,2)' -Rx(:,2,i) .*He(:,1)' + Rx(:,4,i).*He(:,3)'+Rx(:,5,i)'.*He(:,2) - Rx(:,6,i)'.*He(:,1) + Rx(:,8,i)'.*He(:,3))./norm_H2;
 y(3,i) = (Rx(:,1,i).*He(:,3)' -Rx(:,3,i) .*He(:,1)' - Rx(:,4,i).*He(:,2)'+Rx(:,5,i)'.*He(:,3) - Rx(:,7,i)'.*He(:,1) -Rx(:,8,i)'.*He(:,2))./norm_H2;
 y(4,i) = (-Rx(:,2,i).*He(:,3)' +Rx(:,3,i) .*He(:,2)' - Rx(:,4,i).*He(:,1)'-Rx(:,6,i)'.*He(:,3) + Rx(:,7,i)'.*He(:,2) -Rx(:,8,i)'.*He(:,1))./norm_H2;
end
b=4;
S_hat = reshape(y,b,N_frame);
msg_hat = demodulate(demod_obj,S_hat);
msg_hat=reshape(msg_hat,N_frame*4*2,1);
N_ebits = N_ebits + sum(msg_hat~=msg_bit);
end

BER(i_SNR) = N_ebits/(N_tbits);
end
semilogy(SNRdBs,BER), axis([SNRdBs([1 end]) 1e-6 1e0]); hold on; grid on;
xlabel('SNR[dB]'), ylabel('BER'); legend('Precoded Generalized OSTBC');