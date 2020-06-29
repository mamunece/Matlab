% Alamouti_scheme_2x1.m
clear; clf;
L_frame=100; NPacket=1000; % Number of frames/packet and Number of packets 
NT=2; NR=2; b=1;
EbN0dBs=[0:2:20];  sq_NT=sqrt(NT); sq2=sqrt(2);  
for i_EbN0=1:length(EbN0dBs)
   EbN0dB=EbN0dBs(i_EbN0);  sigma=sqrt(0.5/(10^(EbN0dB/10)));
   sigma=sqrt(b/2/(10^(EbN0dB/10)));  nobe = 0;
   for i_packet=1:NPacket
      msg_symbol=randint(L_frame*b,NT);
      tx_bits=msg_symbol.';  tmp=[];   tmp1=[];
      for i=1:NT
        [tmp1,sym_tab,P] = modulator(tx_bits(i,:),b); tmp=[tmp; tmp1];
      end
      X=tmp.'; X1=X; X2=[-conj(X(:,2)) conj(X(:,1))];
      for n=1:NR
        Hr(n,:,:)=(randn(L_frame,NT)+j*randn(L_frame,NT))/sq2;
      
      H=reshape(Hr(n,:,:),L_frame,NT);  Habs(:,n)=sum(abs(H).^2,2);
      R1 = sum(H.*X1,2)/sq_NT + sigma*(randn(L_frame,1)+j*randn(L_frame,1));
      R2 = sum(H.*X2,2)/sq_NT + sigma*(randn(L_frame,1)+j*randn(L_frame,1));
      Z(:,n,1) = R1.*conj(H(:,1)) + conj(R2).*H(:,2);
      Z(:,n,2) = R1.*conj(H(:,2)) - conj(R2).*H(:,1);
      end
      for m=1:P
        tmp = (-1+sum(Habs,2))*abs(sym_tab(m))^2;
      for i=1:2
        d1(:,m,i) = abs(sum(Z(:,:,i),2)-sym_tab(m)).^2 + tmp;
        
      end
      end
      Xd = [];
for n=1:2
    [yn,in]=min(d1(:,:,n),[],2); 
    Xd=[Xd sym_tab(in).']; 
end
      temp1=X>0;  temp2=Xd>0;
     noeb_p(i_packet) = sum(sum(temp1~=temp2));
% End of FOR loop for i_packet

BER(i_EbN0) = sum(noeb_p)/(NPacket*L_frame*b);
end % End of FOR loop for i_SNR
end
semilogy(EbN0dBs,BER,'--mo'), axis([EbN0dBs([1 end]) 1e-6 1e0])
legend('alamouti Ostbc ,2Tx, 2Rx')

grid on;