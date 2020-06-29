uncoded=[0.0285    0.0187    0.0110    0.0053    0.0021    0.0008    0.0002    0.0000    0.0000         0         0]
alamouti=[  0.0520    0.0328    0.0179    0.0078    0.0026    0.0006    0.0001         0    0.0000         0         0]
Ostbc_four_Tx=[ 0.0587    0.0408    0.0255    0.0130    0.0051    0.0014    0.0002    0.0000         0         0         0 ]
Ostbc_three_Tx=[0.0732    0.0505    0.0323    0.0159    0.0064    0.0017    0.0003    0.0000    0.0000         0         0]
SNR=[0:2:20];
semilogy(SNR,uncoded,'-b*')
hold on

semilogy(SNR,alamouti,'--mo')

semilogy(SNR,ostbc_three_TX,':r*')

semilogy(SNR,ostbc_four_TX,'--go')

legend('Uncoded,8PSK(1Tx,4Rx)','alamouti OSTBC,8PSK(2Tx,4Rx)','Rate 3/4 OSTBC,16QAM(4Tx,4Rx)','Rate 3/4 OSTBC,16QAM(3Tx,4Rx)')

xlabel('SNR(db)')
ylabel('BER')
grid on;
title('3bit/(sHZ),4 receive antennas')