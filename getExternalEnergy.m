function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)
% N = 200;
% alpha = 0.4;
% beta = 0.2;
% gamma = 0.5;
% kappa = 0.15;
% Wline = 0.5;
% Wedge = 1.0;
% Wterm = 0.5;
% sigma = 0.5;
% I = imread('images/star.png');
% if (ndims(I) == 3)
%    I = rgb2gray(I);
% end
% I = double(imgaussfilt(I, sigma));
% Eline
Eline = I*Wline

% Eedge
[Gm,Gd] = imgradient(I,'sobel')

Eedge = Wedge*Gm

% Eterm
gx = [0 0 0; 0 -1 1; 0 0 0]
gxx = [0 0 0; 1,-2,1; 0 0 0]
gy = [0 0 0; 0 -1 0; 0 1 0]
gyy = [0 1 0; 0 -2 0; 0 1 0]
gxy = [0 0 0; 0 -2 1; 0 1 0]
Cx = conv2(I,gx,'same')
Cxx = conv2(I,gxx,'same')
Cy = conv2(I,gy,'same')
Cyy = conv2(I,gyy,'same')
Cxy = conv2(I,gxy, 'same')

%Eterm1 = Cyy.*(Cx.*Cx)
%Eterm2 = 2*Cxx.*(Cy.*Cy)
%Eterm3 = Cxx.*(Cy.*Cy)
%Eterm4 = (1+Cx.*Cx+Cy.*Cy).^(3/2)

Eterm = (Cyy.*(Cx.*Cx) - 2 * Cxy.*Cx.*Cy + Cxx.*(Cy.*Cy))./(1 + Cx.*Cx +Cy.*Cy).^(3/2)

% Eext
Eext = Eline + Eedge + Eterm
end


