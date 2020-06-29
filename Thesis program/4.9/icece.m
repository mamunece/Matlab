p_antenna_alamouti=[ 0.0457    0.0216    0.0087    0.0029    0.0008  0.0003         0         0         0         0 0 ]
p_antenna_ostbc=[ 0.0689    0.0356    0.0155    0.0055    0.0017  0.0003    0.0001         0         0         0   0]
alamouti=[0.2304    0.1509    0.0871    0.0477    0.0242    0.0107    0.0048    0.0023    0.0009    0.0004    0.0003]
alamouti_two_rx=[0.0794    0.0352    0.0138    0.0037    0.0012    0.0002    0.0001         0         0         0         0]
Gostbc=[0.2061    0.1234    0.0668    0.0304    0.0120    0.0040    0.0012    0.0004    0.0001    0.0000         0]
Gostbc_four_one=[0.1933    0.1122    0.0559    0.0227    0.0073    0.0020    0.0006    0.0001    0.0000    0.0000         0]
SNR=[0:2:20];

%    semilogy(SNR,p_antenna_alamouti,'-g*','LineWidth',2)
%   
%  hold on;
% 
%   semilogy(SNR,alamouti,'-b+','LineWidth',2)
%   semilogy(SNR,alamouti_two_rx,'-ro','LineWidth',2)
semilogy(SNR,p_antenna_ostbc,'-g*','LineWidth',2)
hold on;
 
 semilogy(SNR,Gostbc,'-b+','LineWidth',2)
 
 semilogy(SNR,Gostbc_four_one,'-r^','LineWidth',2)
legend('precoded-Antenna selection ,R=1/2 ,OSTBC(3Tx,1Rx)','R=1/2,OSTBC(3Tx,1RX)','R=1/2,OSTBC(4Tx,1RX)')%' precoded OSTBC(3Tx,1Rx) ','Antenna alamouti(2Tx,1Rx)','Antenna OSTBC (3Tx,1Rx)')
xlabel('SNR(db)')
ylabel('BER')
grid on;
