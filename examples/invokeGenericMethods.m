%[text] # Invoke Generic .NET Methods
%[text] This example shows how to use `NET.invokeGenericMethod` on .NET objects and types.
%[text] Copyright The MathWorks 2025
NET.addAssembly(fullfile(pwd, "..", "MyAssembly", "bin", "MyAssembly.dll"));
%%
%[text] ## Invoke a Generic Instance Method
%[text] Consider the following C\# class with generic methods:
%[text] ```
%[text] namespace MyAssembly
%[text] {
%[text]     public class GenericMethods
%[text]     {
%[text]         public T DisplayAndReturn<T>(T value)
%[text]         {
%[text]             Console.WriteLine(value);
%[text]             return value;
%[text]         }
%[text]     }
%[text] }
%[text] ```
%[text] To convert `42` to `System.Int32`, call `NET.invokeGenericMethod` like this:
% Create an instance of our custom class
obj = MyAssembly.GenericMethods();

% Invoke the instance method
value = NET.invokeGenericMethod(obj, ...
    "DisplayAndReturn", ...
    {"System.Int32"}, ...
    42);
%%
%[text] ## Invoke a Static Generic Method
%[text] Consider the following C\# class with a static generic method:
%[text] ```
%[text] namespace MyAssembly
%[text] {
%[text]     public class GenericMethods
%[text]     {
%[text]         public static T StaticDisplayAndReturn<T>(T value)
%[text]         {
%[text]             Console.WriteLine(value);
%[text]             return value;
%[text]         }
%[text]     }
%[text] }
%[text] ```
%[text] To invoke `StaticDisplayAndReturn`, call `NET.invokeGenericMethod` with the fully qualified type name:
% Invoke the static method
value = NET.invokeGenericMethod("MyAssembly.GenericMethods", ...
    "StaticDisplayAndReturn", ...
    {"System.String"},...
    "I love generics!");
%[text] ### Invoke a Static Generic Methods in a Generic Type
%[text] If a static method is a member of a generic class like this:
%[text] ```
%[text] namespace MyAssembly
%[text] {
%[text]     public class GenericClass<TOut>
%[text]     {
%[text]         public static TOut StaticDisplayAndReturn<TIn>(TIn value)
%[text]         {
%[text]             Console.WriteLine(value);
%[text]             return (TOut)Convert.ChangeType(value, typeof(TOut));
%[text]         }
%[text]     }
%[text] }
%[text] ```
%[text] Create a class definition using the `NET.GenericClass` constructor:
cls = NET.GenericClass("MyAssembly.GenericClass", ...
    "System.Double");
%[text] Then call `NET.invokeGenericMethod` using the class definition:
value = NET.invokeGenericMethod(cls, ...
    "StaticDisplayAndReturn", ...
    {"System.Int32"}, ...
    42);

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright"}
%---
