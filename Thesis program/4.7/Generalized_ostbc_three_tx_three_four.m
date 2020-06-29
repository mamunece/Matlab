clear; clf
Lfr=100; N_packet=1000; NT=3; NR=3; b=4; M=2^b;
SNRdBs=[0:2:20]; sq_NT=sqrt(NT); sq2=sqrt(2);
for i_SNR=1:length(SNRdBs)
SNRdB=SNRdBs(i_SNR); sigma=sqrt(0.5/(10^(SNRdB/10)));
for i_packet=1:N_packet
msg_symbol = randint(Lfr*b,M);
tx_bits = msg_symbol.'; temp=[]; temp1=[];
for i=1:4
[temp1,sym_tab,P]=modulator(tx_bits(i,:),b); temp=[temp; temp1];
end
X=temp.';
c=(randint(Lfr,1)).*0;
% Block signals in the l-th time slot % Block coding for G3 STBC
 X1=[X(:,1) X(:,2) X(:,3)./sqrt(2) ];             
X2=[-conj(X(:,2)) conj(X(:,1)) X(:,3)./sqrt(2)]; 
X3=[conj(X(:,3))./sqrt(2) conj(X(:,3))./sqrt(2)  (-X(:,1)-conj(X(:,1))+X(:,2)-conj(X(:,2)))./2]; 
X4=[conj(X(:,3))./sqrt(2) -conj(X(:,3))./sqrt(2) (X(:,2)+conj(X(:,2))+X(:,1)-conj(X(:,1)))./2 ]; 
for n=1:NR
Hr(n,:,:)=(randn(Lfr,NT)+j*randn(Lfr,NT))/sq2;
end
for n=1:NR
H = reshape(Hr(n,:,:),Lfr,NT); 
Hc=conj(H);
Habs(:,n) = sum(abs(H).^2,2);
R1n = sum(H.*X1,2)/sq_NT +sigma*(randn(Lfr,1)+j*randn(Lfr,1));
R2n = sum(H.*X2,2)/sq_NT +sigma*(randn(Lfr,1)+j*randn(Lfr,1));
R3n = sum(H.*X3,2)/sq_NT +sigma*(randn(Lfr,1)+j*randn(Lfr,1));
R4n = sum(H.*X4,2)/sq_NT +sigma*(randn(Lfr,1)+j*randn(Lfr,1));


Z(:,n,1) = Hc(:,1).*R1n+conj(R2n).*H(:,2)+(((R4n-R3n).*Hc(:,3))./2)-(((conj(R4n+R3n)).*H(:,3))./2);

Z(:,n,2) =  Hc(:,2).*R1n-conj(R2n).*H(:,1)+(((R4n+R3n).*Hc(:,3))./2)+(((conj(R4n-R3n)).*H(:,3))./2);

Z(:,n,3) =  ((R1n+R2n).*Hc(:,3))./sqrt(2)+(conj(R3n).*(H(:,1)+H(:,2)))./sqrt(2)+(conj(R4n).*(H(:,1)-H(:,2)))./sqrt(2);


for m=1:P
tmp = (-1+sum(Habs,2))*abs(sym_tab(m))^2;
for i=1:3
d(:,m,i) = abs(sum(Z(:,:,i),2)-sym_tab(m)).^2 + tmp;
end
end
end
Xd = [];
for n=1:3, [yn,in]=min(d(:,:,n),[],2); Xd=[Xd sym_tab(in).']; end
X(:,4)=[];
temp1=X>0; temp2=Xd>0;
noeb_p(i_packet) = sum(sum(temp1~=temp2));
end % End of FOR loop for i_packet
BER(i_SNR) = sum(noeb_p)/(N_packet*Lfr*b);
end % End of FOR loop for i_SNR
semilogy(SNRdBs,BER), axis([SNRdBs([1 end]) 1e-6 1e0])