function output = validate_string( inpSTRING )
% This function checks a string if it is a correct set expression, which
% can be casted into numerical values. It also extracts symbolic variables
% and checks for correct bracketing.

% OUTPUT:
%           -- List of symbolic variables

inpSTRING

% Check for brackets: there must be the same amount of opening and closing