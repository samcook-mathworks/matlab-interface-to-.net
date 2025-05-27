%[text] # Invoke Generic .NET Methods
%[text] This example shows how to use `NET.invokeGenericMethod` on .NET objects and types.
%[text] Copyright The MathWorks 2025
%[text] ## Invoke a static generic method
% Display all the generic methods of System.Linq.Enumerable
showGenericMethods("System.Linq.Enumerable");
% Create an array of 10 numbers
arr = NET.createArray("System.Int32", 10);
for i=1:10
    arr(i) = i;
end
% Find and display the maximum of those numbers
max = NET.invokeGenericMethod(...
    "System.Linq.Enumerable",...
    "Max",...
    {"System.Int32"},...
    arr)

%[text] ## Invoke generic instance methods
% Add our custom assembly to MATLAB
file = fullfile(pwd, "..", "MyAssembly", "bin", "MyAssembly.dll");
NET.addAssembly(file);
% Create an instance of our custom class and display its methods
obj = MyAssembly.GenericMethods(42);
showGenericMethods(obj);
% Call a generic method
converted = NET.invokeGenericMethod(...
    obj,...
    "ConvertTo",...
    {"System.Int32"})
% Call another generic method
oldValue = NET.invokeGenericMethod(...
    obj,...
    "Swap",...
    {"System.Single"},...
    single(3.14))
newValue = obj.Value

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
