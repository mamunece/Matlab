clear all; clf
%%%%%% Parameter Setting %%%%%%%%%
N_packet=100;  N_frame=100;  
mod_order=2;  M=2^mod_order;

mod_obj=modem.pskmod('M',M,'SymbolOrder','Gray','InputType','bit');
demod_obj = modem.pskdemod(mod_obj);
% MIMO Parameters
T_TX=4;  NT=3; NR=1; 
 n_bits=T_TX *mod_order*N_frame; 
 N_tbits=n_bits*N_packet;
%  N_tbits=NT*n_bits*N_packet;
fprintf('====================================================\n');
fprintf('  Ant_selection transmission');
fprintf('\n  %d x %d MIMO\n  %d QAM', NT ,NR,M);
fprintf('\n  Simulation bits : %d',N_tbits);
fprintf('\n====================================================\n');
SNRdBs = [0:2:20];  sq2=sqrt(2);
for i_SNR=1:length(SNRdBs)
   SNRdB= SNRdBs(i_SNR);  
   noise_var = (0.5)/(10^(SNRdB/10)); sigma = sqrt(noise_var);
   rand('seed',1); randn('seed',1);  N_ebits = 0;
   %%%%%%%%%%%%% Transmitter %%%%%%%%%%%%%%%%%%
   for i_packet=1:N_packet
      msg_bit = randint(n_bits,1); % Bit generation
      s = modulate(mod_obj,msg_bit);
      Scale = modnorm(s,'avpow',1); % Normalization factor
      S=reshape(Scale*s,T_TX ,1,N_frame); 
       X=S;% Transmit symbol
 a=[X(1,1,:) X(2,1,:) X(3,1,:)];
 b=[-X(2,1,:) X(1,1,:) -X(4,1,:)];
 c=[-X(3,1,:) X(4,1,:) X(1,1,:)];
 d=[ -X(4,1,:) -X(3,1,:) X(2,1,:)];
 Tx_symbol= [a; b; c; d;  conj(a); conj(b);conj(c); conj(d)]  
      %%%%%%%%%%%%% Channel and Noise %%%%%%%%%%%%%
      H = (randn(NR,T_TX)+j*randn(NR,T_TX))/sq2;
      for TX_index=1:T_TX
         ch(TX_index)=norm(H(:,TX_index),'fro'); 
      end
      [val,Index] = sort(ch,'descend');
      Hs = H(:,Index([1 2 3])); 
      norm_H2=norm(Hs,'fro')^2; % H selected and its norm2
      for i=1:N_frame
         Rx(:,:,i) = (Hs*Tx_symbol(:,:,i).')/sqrt(NT) + sigma*(randn(NR,8)+j*randn(NR,8));
      end
      %%%%%%%%%%%%% Receiver %%%%%%%%%%%%%%%%%%
      He=Hs;
      for i=1:N_frame
 y(1,i) = (Rx(:,1,i).*He(:,1)' +Rx(:,2,i) .*He(:,2)' + Rx(:,3,i).*He(:,3)'+Rx(:,5,i)'.*He(:,1) + Rx(:,6,i)'.*He(:,2) + Rx(:,7,i)'.*He(:,3))./norm_H2;
 y(2,i) = (Rx(:,1,i).*He(:,2)' -Rx(:,2,i) .*He(:,1)' + Rx(:,4,i).*He(:,3)'+Rx(:,5,i)'.*He(:,2) - Rx(:,6,i)'.*He(:,1) + Rx(:,8,i)'.*He(:,3))./norm_H2;
 y(3,i) = (Rx(:,1,i).*He(:,3)' -Rx(:,3,i) .*He(:,1)' - Rx(:,4,i).*He(:,2)'+Rx(:,5,i)'.*He(:,3) - Rx(:,7,i)'.*He(:,1) -Rx(:,8,i)'.*He(:,2))./norm_H2;
 y(4,i) = (-Rx(:,2,i).*He(:,3)' +Rx(:,3,i) .*He(:,2)' - Rx(:,4,i).*He(:,1)'-Rx(:,6,i)'.*He(:,3) + Rx(:,7,i)'.*He(:,2) -Rx(:,8,i)'.*He(:,1))./norm_H2;
      end   
      
      S_hat = reshape(y/Scale,4,N_frame);
      msg_hat = demodulate(demod_obj,S_hat);
      msg_hat=reshape(msg_hat,N_frame*T_TX*2,1);
      N_ebits = N_ebits + sum(msg_hat~=msg_bit);
    end
    BER(i_SNR) = N_ebits/(N_tbits);
end
semilogy(SNRdBs,BER,'-k^', 'LineWidth',2); hold on; grid on;
xlabel('SNR[dB]'), ylabel('BER');
legend('Ant-selection transmission')