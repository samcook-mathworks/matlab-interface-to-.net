%[text] # Create .NET Generic Objects
%[text] This script uses NET.createGeneric to create .NET objects of a generic type.
%[text] Copyright The MathWorks 2025

%[text] ## Create a List of System.Double
% Call the default constructor for List
list = NET.createGeneric(...
    "System.Collections.Generic.List",...
    {"System.Double"})
% Add some items to the list
for i=0:10
    list.Add(i);
end
list
% Convert the list to a MATLAB array and display its elements
list = double(list.ToArray())

%[text] ## Create a Dictionary mapping System.String to System.Int32
% Call the default constructor for Dictionary
dict = NET.createGeneric(...
    "System.Collections.Generic.Dictionary",...
    {"System.String", "System.Int32"})
% Add entries to the dictionary
for i=0:10
    dict.Add(num2str(i), i);
end
dict
% Convert to a MATLAB dictionary and display its elements
dict = dictionary(dict)

%[text] ## Create a List of KeyValuePair, mapping System.String to System.Int32
% Create the generic type definition for KeyValuePair<System.String,System.Int32>
kvpType = NET.GenericClass(...
    "System.Collections.Generic.KeyValuePair",...
    "System.String", "System.Int32");
% Create a List of `kvpType` with initial storage capacity for 10 elements
% This invokes the .NET constructor for List with a single System.Int32 argument documented here:
% https://learn.microsoft.com/en-us/dotnet/api/system.collections.generic.list-1.-ctor#system-collections-generic-list-1-ctor(system-int32)
kvpList = NET.createGeneric(...
    "System.Collections.Generic.List",...
    {kvpType},...
    10)
% Create an item and add it to the list
kvpItem = NET.createGeneric(...
    "System.Collections.Generic.KeyValuePair",...
    {"System.String", "System.Int32"},...
    "myString", 42)
kvpList.Add(kvpItem);
kvpList
