% Alamouti_scheme_2x1.m
clear; clf;
L_frame=100; N_Packets=1000; % Number of frames/packet and Number of packets 
NT=2; NR=1; b=1;
EbN0dBs=[0:2:20];  sq_NT=sqrt(NT); sq2=sqrt(2);  
for i_EbN0=1:length(EbN0dBs)
   EbN0dB=EbN0dBs(i_EbN0);  sigma=sqrt(0.5/(10^(EbN0dB/10)));
   nobe=0;
   for i_packet=1:N_Packets
      msg_symbol=randint(L_frame*b,NT);
      tx_bits=msg_symbol.';  tmp=[];   tmp1=[];
      for i=1:NT
        [tmp1,sym_tab,P] = modulator(tx_bits(i,:),b); tmp=[tmp; tmp1];
      end
      X=tmp.'; X1=X; X2=[-conj(X(:,2)) conj(X(:,1))];
      for n=1:NT
        Hr(n,:,:)=(randn(L_frame,NT)+j*randn(L_frame,NT))/sq2;
      end
      H=reshape(Hr(n,:,:),L_frame,NT);  Habs(:,n)=sum(abs(H).^2,2);
      R1 = sum(H.*X1,2)/sq_NT + sigma*(randn(L_frame,1)+j*randn(L_frame,1));
      R2 = sum(H.*X2,2)/sq_NT + sigma*(randn(L_frame,1)+j*randn(L_frame,1));
      Z1 = R1.*conj(H(:,1)) + conj(R2).*H(:,2);
      Z2 = R1.*conj(H(:,2)) - conj(R2).*H(:,1);
      for m=1:P
        tmp = (-1+sum(Habs,2))*abs(sym_tab(m))^2;
        d1(:,m) = abs(sum(Z1,2)-sym_tab(m)).^2 + tmp;
        d2(:,m) = abs(sum(Z2,2)-sym_tab(m)).^2 + tmp;
      end
      [y1,i1]=min(d1,[],2);   S1d=sym_tab(i1).';   % clear d1
      [y2,i2]=min(d2,[],2);   S2d=sym_tab(i2).';   % clear d2
      Xd = [S1d S2d];   tmp1=X>0;  tmp2=Xd>0;
      nobe = nobe + sum(sum(tmp1~=tmp2));% for coded
      if nobe>100,  break;  end
   end % End of FOR loop for i_packet
   BER(i_EbN0) = nobe/(i_packet*L_frame*b);
end    % End of FOR loop for i_EbN0
semilogy(EbN0dBs,BER), axis([EbN0dBs([1 end]) 1e-6 1e0]); 
grid on;  xlabel('EbN0[dB]'); ylabel('BER');  hold on