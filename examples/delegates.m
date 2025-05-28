%[text] # Use .NET Delegates
%[text] This example shows how to create .NET delegates from MATLAB.
%[text] Copyright The MathWorks 2025
%[text] This example requires the following assembly be added to MATLAB:
NET.addAssembly(fullfile(pwd, "..", "MyAssembly", "bin", "MyAssembly.dll"));
%%
%[text] ## Bind Delegates to .NET Methods
%[text] Consider a C\# delegate defined as:
%[text] ```
%[text] namespace System
%[text] {
%[text]     public delegate void Action();
%[text] }
%[text] ```
%[text] MATLAB creates a constructor signature that accepts two arguments:
%[text] - `target` - A .NET object (for instance methods) or a fully-qualified .NET type name (for static methods)
%[text] - `methodName` - The name of the .NET method to bind to. \
%[text] If we have the following C\# class:
%[text] ```
%[text] namespace MyAssembly
%[text] {
%[text]     public class DelegateExample
%[text]     {
%[text]         public static void StaticMethod() =>
%[text]             Console.WriteLine("StaticMethod");
%[text] 
%[text]         public void MyMethod() =>
%[text]             Console.WriteLine("MyMethod");
%[text] 
%[text]         public void StringMethod(string value) =>
%[text]             Console.WriteLine("value: {0}", value);
%[text]     }
%[text] }
%[text] ```
%[text] We can create instances of `System.Action` bound to its methods.
% Create and invoke a delegate bound to a .NET object instance method
target = MyAssembly.DelegateExample();
delegate = System.Action(target, "MyMethod");
delegate();

% Create and invoke a delegate bound to a static .NET method
delegate = System.Action('MyAssembly.DelegateExample', "StaticMethod");
delegate();
%[text] ### Delegates With Generic Arguments
%[text] Consider another definition for `System.Action`:
%[text] ```
%[text] namespace System
%[text] {
%[text]     public delegate void Action<T>(T arg);
%[text] }
%[text] ```
%[text] Use `NET.createGeneric` to instantiate .NET delegates with generic arguments.
% Create and invoke a generic delegate
target = MyAssembly.DelegateExample();
delegate = NET.createGeneric(...
    "System.Action", {"System.String"},...
    target, "StringMethod");
delegate("MATLAB");
%%
%[text] ## Bind Delegates to MATLAB Functions
%[text] MATLAB supports creating .NET delegates that call back into MATLAB functions.
% Create and invoke a delegate bound to a MATLAB function handle
fh = @()disp("Hello, .NET!");
delegate = System.Action(fh);
delegate();
%[text] ### Delegates With `out` and `ref` Arguments
%[text] The rules for mapping `out` and `ref` arguments in delegates are the same as for methods. For example, consider the following C\# delegates:
%[text] ```
%[text] namespace MyAssembly
%[text] {
%[text]     public delegate void RefStringDelegate(ref string refArg);
%[text]     public delegate void OutDoubleDelegate(out double outArg);
%[text] }
%[text] ```
%[text] MATLAB maps `refArg` as both RHS and LHS arguments:
function refArg = myRefFunc(refArg)
    fprintf("Ref arg is %s", string(refArg));
    refArg = "MATLAB";
end
%[text] Whereas MATLAB maps `outArg` as an LHS argument:
function outArg = myOutFunc()
    outArg = 3.14;
end
%[text] The following code demonstrates how to bind to these functions.
% Create and invoke a delegate with a ref argument
del = MyAssembly.RefStringDelegate(@myRefFunc);
refArg = ".NET";
refArg = del(refArg)

% Create and invoke a delegate with an out argument
del = MyAssembly.OutDoubleDelegate(@myOutFunc);
outArg = del()
%%
%[text] ## Combine and Remove .NET Delegates
%[text] MATLAB provides the instance method `Combine`, that lets you combine a series of delegates into a single delegate. The `Remove` and `RemoveAll` methods delete individual delegates. For more information, refer to the documentation for a .NET class library, as described in [To Learn More About .NET](https://www.mathworks.com/help/matlab/matlab_external/using-net-from-matlab-an-overview.html#brpcaxs-1).
%[text] Consider two MATLAB functions to use with `System.Action<T>:`
function action1(n)
    fprintf("Add %i cups flour\n", n);
end
function action2(n)
    fprintf("Add %i eggs\n", n);
end
%[text] The following code demonstrates how to use `Combine` and `Remove` with these delegates:
% Create a delegate bound to action1
step1 = NET.createGeneric("System.Action", {"System.Int32"}, @action1);

% Combine action1 with action2 and invoke it
% MATLAB implicitly converts @action2 to an instance of System.Action<T>
mixItems = step1.Combine(@action2);
mixItems(2);

% Remove step1 from mixItems and invoke it
oneItem = mixItems.Remove(step1);
oneItem(3);
%%
%[text] ## Pass Function Handle Arguments
%[text] MATLAB automatically converts function handle arguments to .NET delegates.
%[text] Consider the following C\# code:
%[text] ```
%[text] namespace MyAssembly
%[text] {
%[text]     public class DelegateExample
%[text]     {
%[text]         public void InvokeAction(Action action) => action();
%[text]     }
%[text] }
%[text] ```
%[text] The `InvokeAction` method can be called directly with a MATLAB function handle:
obj = MyAssembly.DelegateExample;
obj.InvokeAction( @()disp("Hello, .NET!") );

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":32.9}
%---
