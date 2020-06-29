uncoded=[0.0199    0.0089    0.0033    0.0012    0.0002    0.0001    0.0000         0         0         0         0]
alamouti=[   0.0315    0.0113    0.0029    0.0006    0.0001         0         0         0         0         0         0 ]
ostbc_three_tx=[0.0550    0.0311    0.0141    0.0047    0.0009    0.0001    0.0000         0         0         0         0]
ostbc_four_tx=[ 0.0534    0.0304    0.0133    0.0044    0.0008    0.0001    0.0000         0         0         0         0]
SNR=[0:2:20];
semilogy(SNR,uncoded,'-b*')
hold on

semilogy(SNR,alamouti,'--mo')

semilogy(SNR,ostbc_three_tx,':r*')

semilogy(SNR,ostbc_four_tx,'-go')

legend('Uncoded,QPSK(1Tx,4Rx)','alamouti OSTBC,QPSK(2Tx,4Rx)','Rate 1/2 OSTBC,16QAM(3Tx,4Rx)','Rate 1/2 OSTBC,16QAM(4Tx,4Rx)')

xlabel('SNR(db)')
ylabel('BER')
grid on;
title('2bit/(sHZ),4 receive antennas')