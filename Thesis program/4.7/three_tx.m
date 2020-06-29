half_one_rx=[0.2076    0.1250    0.0673    0.0307    0.0125    0.0040    0.0014    0.0004    0.0001    0.0001         0]% all qpsk
half_two_rx =[0.0686    0.0266    0.0083    0.0017    0.0004    0.0000    0.0000         0         0         0         0]
half_three_rx=[0.0246    0.0065    0.0012    0.0001    0.0000         0         0         0         0         0         0]
half_four_rx=[  0.0092    0.0014    0.0001    0.0000         0         0         0         0         0         0         0]
three_four_one_rx=[   0.2675    0.1900    0.1239    0.0691    0.0345    0.0144    0.0055    0.0017    0.0006    0.0001    0.0000]
three_four_two_rx=[  0.1365    0.0742    0.0327    0.0117    0.0032    0.0005    0.0001         0    0.0000         0         0]
three_four_three_rx=[ 0.0738    0.0316    0.0102    0.0021    0.0002    0.0000         0         0         0         0         0]
three_four_four_rx=[0.0422    0.0143    0.0030    0.0005    0.0000         0         0         0         0         0         0]
SNR=[0:2:20];
p=semilogy(SNR,half_one_rx,'-y*')
hold on
semilogy(SNR,half_two_rx,'--mo')
semilogy(SNR,half_three_rx,':r*')
semilogy(SNR,half_four_rx,'--go')
semilogy(SNR,three_four_one_rx,'-ro')
semilogy(SNR,three_four_two_rx,':g*')
semilogy(SNR,three_four_three_rx,'-co')
semilogy(SNR,three_four_four_rx,'-bo')
grid on
legend('Rate 1/2OSTBC(3Tx,1Rx)','Rate1/2 OSTBC(3Tx,2Rx)','Rate1/2 OSTBC(3Tx,3Rx)','Rate1/2 OSTBC(3Tx,4Rx)','Rate3/4 OSTBC(3Tx,1Rx)',...
    'Rate3/4 OSTBC(3Tx,2Rx)','Rate3/4 OSTBC(3Tx,3Rx)','Rate3/4 OSTBC(3Tx,4Rx)')%,'Location','NorthEastOutside')
xlabel('SNR(db)')
ylabel('BER')
title('BER performance for Three transmit antennas of Generalized OSTBC ','fontsize',8)