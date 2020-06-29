% Alamouti_2x1_precoding.m
clear all; clf
%%%%%% Parameter Setting %%%%%%%%%
N_frame=100; N_packet=100; %Number of frames/packet and Number of packets
b=1; M=2^b; % Number of bits per symbol and Modulation order
mod_obj=modem.pskmod('M',M,'SymbolOrder','gray','InputType','bit');
demod_obj = modem.pskdemod(mod_obj);
% MIMO Parameters
T_TX=4; code_length=64;
NT=2; NR=1; % Numbers of transmit/receive antennas
N_pbits=NT*b*N_frame; N_tbits=N_pbits*N_packet;
code_book = codebook_generator;
fprintf('’====================================================\n’');
fprintf(' Precoding transmission');
fprintf('\n %d x %d MIMO\n %d QAM', NT,NR,M);
fprintf('\n Simulation bits : %d', N_tbits);
fprintf('\n====================================================\n');
SNRdBs = [0:2:20]; sq2=sqrt(2);
for i_SNR=1:length(SNRdBs)
SNRdB = SNRdBs(i_SNR);
noise_var =( 0.5)/10^(SNRdB/10); sigma = sqrt(noise_var);
rand('seed',1); randn('seed',1); N_ebits=0;
for i_packet=1:N_packet
msg_bit = randint(N_pbits,1); % Bit generation
%%%%%%%%%%%%% Transmitter %%%%%%%%%%%%%%%%%%
s = modulate(mod_obj, msg_bit );
Scale = modnorm(s,'avpow',1); % Normalization
S = reshape(Scale*s,NT,1,N_frame); % Transmit symbol
Tx_symbol = [S(1,1,:) -conj(S(2,1,:)); S(2,1,:) conj(S(1,1,:))];
%%%%%%%%%%%%% Channel and Noise %%%%%%%%%%%%%
H = (randn(NR,T_TX)+j*randn(NR,T_TX))/sq2;
for i=1:code_length
cal(i) = norm(H*code_book(:,:,i),'fro');
end
[val,Index] = max(cal);

He = H*code_book(:,:,Index);
norm_H2 = norm(He)^2; % H selected and its norm2
for i=1:N_frame
Rx(:,:,i)=(He*Tx_symbol(:,:,i))/sqrt(NT)+sigma*(randn(NR,2)+j*randn(NR,2));
end
%%%%%%%%%%%%% Receiver %%%%%%%%%%%%%%%%%%
for i=1:N_frame
y(1,i) = (He(1)'*Rx(:,1,i)+He(2)*Rx(:,2,i)')/norm_H2;
y(2,i) = (He(2)'*Rx(:,1,i)-He(1)*Rx(:,2,i)')/norm_H2;
end

S_hat = reshape(y/Scale,NT*N_frame,1);
msg_hat = demodulate(demod_obj,S_hat);
N_ebits = N_ebits + sum(msg_hat~=msg_bit);
end
BER(i_SNR) = N_ebits/N_tbits;
end
semilogy(SNRdBs,BER,'-k^', 'LineWidth',2); hold on; grid on;
xlabel('SNR[dB]'), ylabel('BER'); legend('Precoded Alamouti');