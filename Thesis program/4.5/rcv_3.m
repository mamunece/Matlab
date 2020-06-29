uncoded=[ 0.0370    0.0257    0.0165    0.0097    0.0049    0.0022    0.0008    0.0003    0.0001    0.0000    0.0000]
alamouti=[  0.0693    0.0463    0.0278    0.0143    0.0061    0.0020    0.0005    0.0001    0.0000         0    0.0000 ]%8 PSK
ostbc_three_TX=[ 0.0899    0.0659    0.0447    0.0263    0.0122    0.0045    0.0011    0.0002    0.0000         0         0 ]%16QAM
ostbc_four_TX=[0.0717    0.0527    0.0356    0.0213    0.0102    0.0037    0.0010    0.0002    0.0000         0         0]
SNR=[0:2:20];
semilogy(SNR,uncoded,'-b*')
hold on

semilogy(SNR,alamouti,'--mo')

semilogy(SNR,ostbc_three_TX,':r*')

semilogy(SNR,ostbc_four_TX,'--go')

legend('Uncoded,8PSK(1Tx,3Rx)','alamouti OSTBC,8PSK(2Tx,3Rx)','Rate 3/4 OSTBC,16QAM(3Tx,3Rx)','Rate 3/4 OSTBC,16QAM(4Tx,3Rx)')
xlabel('SNR(db)')
ylabel('BER')
grid on;
title('3bit/(sHZ),3 receive antennas')