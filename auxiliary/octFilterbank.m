function [filters, f_center, f_edges] = octFilterbank(octDiv, f_lims, fs, orderFilt, f_ref)
% Octave Filterbank filter design

if ~(mod(octDiv,1)==0 && (octDiv>0))
    error('Octave division should be a positive integer.')
end

if nargin<4
    orderFilt = 100;
    f_ref = 1000;
elseif nargin<5
    f_ref = 1000;
end
    
% find band center frequencies and edges
fc_down = [];
fc = f_ref;
fl = f_ref*2^(-1/octDiv/2);
fl_down = fl;
while fl>f_lims(1)*2^(1/octDiv/2)
    fc = fc*2^(-1/octDiv);
    fl = fc*2^(-1/octDiv/2);
    fc_down = [fc; fc_down];
    fl_down = [fl; fl_down];
end

fc_up = [];
fc = f_ref;
fh = f_ref*2^(1/octDiv/2);
fh_up = fh;
while fh<f_lims(2)*2^(-1/octDiv)
    fc = fc*2^(1/octDiv);
    fh = fc*2^(1/octDiv/2);
    fc_up = [fc_up; fc];
    fh_up = [fh_up; fh];
end
f_center = [fc_down; f_ref; fc_up];
f_edges = [fl_down; fh_up];

nBands = length(f_edges)+1;

% create first and last lowpass and highpass in the filterbank
filters = zeros(orderFilt+1, nBands);
filters(:,1) = fir1(orderFilt, f_edges(1)/(fs/2), 'low');
filters(:,nBands) = fir1(orderFilt, f_edges(nBands-1)/(fs/2), 'high');
% create intermediate bandpasses
for i = 2:(nBands-1)
    filters(:,i) = fir1(orderFilt, [f_edges(i-1) f_edges(i)]/(fs/2), 'bandpass');
end

end
