% run fitsdisp('gal_line_dr7_v5_2.fit'); to get header names
% NII6584 - 175
% Halpha - 163
% OIII5007 - 115
% OII3726 - 19
% SII6720 - 187
% Use data2{1, 7} for z

% Index 1 - counter
% Index 2 - 

data = fitsread("gal_line_dr7_v5_2.fit", 'binarytable');
data2 = fitsread("gal_fiboh_dr7_v5_2.fits", 'binarytable');

nii6584 = [];
halpha = [];
oiii5007 = [];
oii3726 = [];
sii6720 = [];
z = [];

for i = 1:927552
    disp(i);
    nii6584 = [nii6584; data{1, 175}(i)];
    halpha = [halpha; data{1, 163}(i)];
    oiii5007 = [oiii5007; data{1, 115}(i)];
    oii3726 = [oii3726; data{1, 19}(i)];
    sii6720 = [sii6720; data{1, 187}(i)];
    z = [z; data2{1, 7}(i)];
end

table = table(nii6584, halpha, oiii5007, oii3726, sii6720, z);