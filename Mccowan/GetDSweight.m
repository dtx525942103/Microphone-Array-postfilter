function [H] = GetDSweight(M,N_FFT,fs,r,angle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frequency-domain delay-sum beamformer using circular array
%   
%      input :
%          x : input signal ,samples * channel
%          fs: sample rate
%          N : fft length,frequency bin number
%frameLength : frame length,usually same as N
%        inc : step increment
%          r : array element radius
%      angle : incident angle
%
%     output :
%         DS : delay-sum output
%         x1 : presteered signal,same size as x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = 340;
Nele = M;
frameLength = N_FFT;
omega = zeros(frameLength,1);
H = ones(N_FFT/2+1,Nele);

theta = angle(2);%0*pi/180; %�̶�һ��������
gamma = [0 90 180 270]*pi/180;%��˷�λ��
%gamma = [30 90 150 210 270 330]*pi/180;%��˷�λ��
tao = -1*r*cos(theta)*cos(angle(1)-gamma)/c;     %��λ�� 0 < angle <360

% frequency bin weights
for k = 1:1:N_FFT/2+1
    omega(k) = 2*pi*(k-1)*fs/N_FFT;   
    % steering vector
    H(k,:) = exp(-1j*omega(k)*tao);
end
end

