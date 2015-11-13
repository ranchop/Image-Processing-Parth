function [ output_args ] = Function_NameValue_Pair_Input( Required_Input_1, Required_Input_2, varargin )
    
    % Setup all the optional parameters here
    Optional_Input_1 = 'Title - Hmm..';
    Optional_Input_2 = [11,34,-90];
    Optional_Input_3 = 87;
    
    % Override the provided values
    if mod(length(varargin),2) > 0, error('Wrong Inputs, Must be name-value pairs!'); end
    for i = 1:2:length(varargin)
        switch lower(varargin{i})
            case 'Optional_Input_1'
                Optional_Input_1 = varargin{i+1};
            case 'Optional_Input_2'
                Optional_Input_2 = varargin{i+1};
            case 'Optional_Input_3'
                Optional_Input_3 = varargin{i+1};
            otherwise
                disp('Illegal Name Provided in Function ____. Ignore and Continue!');
        end
    end
    
    % Now all the cariables are properly initialized. Continue with rest of
    % the program.

end
