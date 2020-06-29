% alamouti_two_six=[   0.0114    0.0026    0.0003    0.0000         0         0         0         0         0         0         0]%qpsk
ostbc_half_three_four=[ 0.0093    0.0017    0.0001    0.0000         0         0         0         0         0         0         0]
ostbc_half_four_three=[ 0.0214    0.0048    0.0008    0.0000    0.0000         0         0         0         0         0         0]
ostbc_8psk_three_four=[ 0.0466    0.0225    0.0080    0.0017    0.0003  0.0000         0         0         0         0 0 ]
ostbc_8psk_four_three=[ 0.0670    0.0361    0.0155    0.0048    0.0009 0.0001    0.0000         0         0         0  0 ]
% ostbc_three_four=[0.0427    0.0140    0.0031    0.0004    0.0000         0         0         0         0         0         0]
% ostbc_four_three=[  0.0599    0.0260    0.0076    0.0016    0.0002    0.0000    0.0000         0         0         0         0]
SNR=[0:2:20];
% semilogy(SNR,alamouti_two_six,'-b*')
% hold on

semilogy(SNR,ostbc_half_three_four,'-m*','LineWidth',2)
hold on;

semilogy(SNR,ostbc_half_four_three,'-r+','LineWidth',2)

 semilogy(SNR,ostbc_8psk_three_four,'-g^','LineWidth',2)
 semilogy(SNR,ostbc_8psk_four_three,'-bo','LineWidth',2)

legend('R=1/2 OSTBC,QPSK(3Tx,4Rx)','R=1/2 OSTBC,QPSK(4Tx,3Rx)','R=1/2 OSTBC,8-PSK(3Tx,4Rx)','R=1/2 OSTBC,8-PSK(4Tx,3Rx)' )

xlabel('SNR(db)')
ylabel('BER')
grid on;
% title('Spatial Diversity 12')