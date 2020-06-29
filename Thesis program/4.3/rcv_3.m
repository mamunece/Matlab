uncoded=[0.0570    0.0370    0.0217    0.0122    0.0058    0.0027    0.0013    0.0005    0.0003    0.0001    0.0000 ]
alamouti=[ 0.0539    0.0260    0.0088    0.0025    0.0005    0.0001    0.0000         0         0         0         0 ]
Gostbc_three_Tx=[  0.0737    0.0463    0.0252    0.0105    0.0034    0.0007    0.0001    0.0000         0         0         0]
Gostbc_four_Tx=[0.0717    0.0454    0.0241    0.0096    0.0028    0.0004    0.0001         0         0         0         0]
SNR=[0:2:20];
semilogy(SNR,uncoded,'-b*')
hold on

semilogy(SNR,alamouti,'--mo')

semilogy(SNR,Gostbc_three_Tx,':r*')

semilogy(SNR,Gostbc_four_Tx,'-go')

legend('Uncoded,QPSK(1Tx,3Rx)','alamouti OSTBC,QPSK(2Tx,3Rx)','Rate 1/2 OSTBC,16QAM(3Tx,3Rx)','Rate 1/2 OSTBC,16QAM(4Tx,3Rx)')

xlabel('SNR(db)')
ylabel('BER')
grid on;
title('2bit/(sHZ),3 receive antennas')