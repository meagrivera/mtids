function pixelValue = sizeChar2Pixel(hObject, widthOrHeight, input)
%SIZECHAR2PIXEL conversion of char symbols to pixel size
%
% Converts char into pixel size.
%
% INPUT:    hObject         -- Parent figure handle
%           widthOrHeight   -- Char with 'w' or 'h' to detect if horizontal 
%                               or vertical pixel size is needed
%           inputString     -- An input string, which length should be 
%                               computed in pixel values
%
% OUTPUT:   pixelValue      -- The length of the string "inputString" in pixels
%
% Author: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

if nargin < 3
    error('Insufficient number of input arguments');
end

size_pixels=get(hObject,'Position');
set(hObject,'Units','characters');
size_characters=get(hObject,'Position');
set(hObject,'Units','Pixels');
convFactor = size_pixels(3:4)./size_characters(3:4);

if isa(input,'char')
    if strcmp(widthOrHeight,'w')
        pixelValue = convFactor(1)*size(input,2);
    elseif strcmp(widthOrHeight,'h')
        pixelValue = convFactor(2)*size(input,1);
    end
elseif isa(input,'double') || isa(input,'int')
    if strcmp(widthOrHeight,'w')
        pixelValue = convFactor(1)*input;
    elseif strcmp(widthOrHeight,'h')
        pixelValue = convFactor(2)*input;
    end
end