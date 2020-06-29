alamouti=[0.2304    0.1509    0.0871    0.0477    0.0242    0.0107    0.0048    0.0023    0.0009    0.0004    0.0003]
alamouti_two_rx=[0.0794    0.0352    0.0138    0.0037    0.0012    0.0002    0.0001         0         0         0         0]
precoded_alamouti=[ 0.0450    0.0207    0.0080    0.0025    0.0007    0.0002    0.0001    0.0000         0         0         0]%bpsk
Gostbc=[0.2061    0.1234    0.0668    0.0304    0.0120    0.0040    0.0012    0.0004    0.0001    0.0000         0]%qpsk
precoded_ostbc=[  0.0691    0.0357    0.0154    0.0057    0.0018    0.0003    0.0000         0         0         0         0]
Gostbc_four_one=[0.1933    0.1122    0.0559    0.0227    0.0073    0.0020    0.0006    0.0001    0.0000    0.0000         0]
antenna_alamouti=[ 0.0597    0.0290    0.0127    0.0045    0.0013    0.0003    0.0001         0         0         0         0]%bpsk
antenna_gostbc=[ 0.0718    0.0382    0.0175    0.0069    0.0021    0.0004    0.0000    0.0000         0         0         0]%qpsk
SNR=[0:2:20];
%   semilogy(SNR,alamouti,'-r*')

% hold on;
   semilogy(SNR,precoded_alamouti,'-go')
  
 hold on;
%   semilogy(SNR,Gostbc,':m*')
  semilogy(SNR,precoded_ostbc,'-mo')
   semilogy(SNR,antenna_alamouti,'-ro')

 
  semilogy(SNR,antenna_gostbc,'-g*')

%   semilogy(SNR,alamouti_two_rx,'-co')
%   semilogy(SNR,Gostbc_four_one,'-bo')

% legend('Alamouti(2TX,1RX)','precoded Alamouti(2Tx,1Rx)','OSTBC(3TX,1RX)',' precoded OSTBC(3Tx,1Rx) ','Alamouti(2Tx,2RX)','OSTBC(4TX,1RX)') %'Antenna alamouti(2Tx,1Rx)','Antenna OSTBC (3Tx,1Rx)')%'alamouti(2Tx,2Rx)','OSTBC (4Tx,1Rx)')%'Rate 3/4 OSTBC,QPSK(3Tx,1Rx)','Rate 3/4 OSTBC,QPSK(3Tx,2Rx)','Rate 3/4 OSTBC,QPSK(3Tx,3Rx)','Rate 3/4 OSTBC,QPSK(3Tx,4Rx)')
% legend('Alamouti(2TX,1RX)','OSTBC(3TX,1RX)','Antenna alamouti(2Tx,1Rx)', 'Antenna OSTBC (3Tx,1Rx)','Alamouti(2Tx,2RX)','OSTBC(4TX,1RX)')
legend('precoded Alamouti(2Tx,1Rx)',' precoded OSTBC(3Tx,1Rx) ','Antenna alamouti(2Tx,1Rx)','Antenna OSTBC (3Tx,1Rx)')
xlabel('SNR(db)')

ylabel('BER')
grid on;
% title('1 bit/(shz) bit rate  ')