 BER_uncoded=[ 0.1462    0.1077    0.0770    0.0527    0.0345    0.0237    0.0156    0.0098    0.0055    0.0037    0.0024 ]  %1*1 bpsk 
alamouti=[ 0.2260    0.1425    0.0771    0.0412    0.0271    0.0109    0.0061    0.0018    0.0009    0.0003    0.0002] %2*1 bpsk
Gostbc_three_tx=[ 0.2061    0.1234    0.0668    0.0304    0.0120    0.0040    0.0012    0.0004    0.0001    0.0000         0] %3*1
Gostbc_four_tx=[  0.1933    0.1122    0.0559    0.0227    0.0073    0.0020    0.0006    0.0001    0.0000    0.0000         0  ]%4*1
SNR=[0:2:20];
% semilogy(SNR,BER_uncoded,'-b*')


semilogy(SNR,alamouti,'-mo','LineWidth',2)
hold on
semilogy(SNR,Gostbc_three_tx,'-r*','LineWidth',2)

semilogy(SNR,Gostbc_four_tx,'-gx','LineWidth',2)

legend('R=1 OSTBC,BPSK(2Tx,1Rx)','R=1/2 OSTBC,QPSK(3Tx,1Rx)','R=1/2 OSTBC,QPSK(4Tx,1Rx)')

xlabel('SNR(db)')
ylabel('BER')
grid on;
% title('1bit/(sHZ),1 receive antenna')