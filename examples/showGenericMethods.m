function showGenericMethods(input)
% Display all generic methods of a .NET type using reflection.
% Input can be a .NET object or a string scalar.
% Copyright The MathWorks 2025

% Locate the type based on the input
if isa(input, "System.Object")
    % Input is an instance of a .NET object
    type = input.GetType();
elseif ischar(input) || isStringScalar(input)
    % Input is the name of a .NET class
    type = getType(input);
    if isempty(type)
        % Couldn't locate the type
        disp(strcat(input, " not found"));
        return;
    end
end
% Display all the generic methods
fprintf("Generic methods of %s\n", string(type.ToString()));
methods = type.GetMethods();
for i=1:methods.Length
    if methods(i).IsGenericMethod
        fprintf("\t%s\n", string(methods(i).ToString()));
    end
end
end

function type = getType(input)
    % Use basic search function
    type = System.Type.GetType(input);
    if ~isempty(type)
        return;
    end

    % Couldn't locate the type. Manually search all assemblies
    assemblies = System.AppDomain.CurrentDomain.GetAssemblies();
    for i = 1:assemblies.Length
        type = assemblies(i).GetType(input);
        if ~isempty(type)
            % Found the type
            return;
        end
    end
end
