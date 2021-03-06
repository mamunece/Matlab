uncoded=[ 0.0573    0.0334    0.0175    0.0079    0.0035    0.0018    0.0007    0.0003    0.0001    0.0000    0.0000]
alamouti=[ 0.0794    0.0352    0.0138    0.0037    0.0012    0.0002    0.0001         0         0         0         0]
Gostbc_three_tx=[ 0.0814    0.0371    0.0132    0.0042    0.0010    0.0002    0.0001         0         0         0         0]
Gostbc_four_tx=[ 0.0648    0.0227    0.0060    0.0011    0.0001    0.0000         0         0         0         0         0]
SNR=[0:2:20];
% semilogy(SNR,uncoded,'-b*')
% hold on

semilogy(SNR,alamouti,'-mo','LineWidth',2)
hold on

semilogy(SNR,Gostbc_three_tx,'-r^','LineWidth',2)

semilogy(SNR,Gostbc_four_tx,'-gx','LineWidth',2)

axis([SNR([1 end]) 1e-6 1e0]);
legend('R=1,OSTBC,BPSK(2Tx,2Rx)','R=1/2,OSTBC,QPSK(3Tx,2Rx)','R=1/2 OSTBC,QPSK(4Tx,2Rx)')
xlabel('SNR(db)')
ylabel('BER')
grid on; 
% title('1bit/(sHZ),2 receive antennas')