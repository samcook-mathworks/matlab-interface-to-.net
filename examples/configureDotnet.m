%[text] # Configure MATLAB Interface to .NET
%[text] This script uses the `dotnetenv` function to inspect and configure the .NET environment.
%[text] Copyright The MathWorks 2025
%[text] ## Default .NET Configuration
%[text] On Microsoft® Windows®, MATLAB defaults to loading .NET Framework 4.8.1. Otherwise, MATLAB will use the latest version of .NET installed on your machine.
% Display the current platform
if ispc
    disp("Running on Windows");
elseif ismac
    disp("Running on macOS");
elseif isunix
    disp("Running on Linux");
end

% Display the default runtime configuration
switch dotnetenv().Runtime
    case "core"
        disp("MATLAB configured to use the latest version of .NET");
    case "framework"
        disp("MATLAB configured to use .NET Framwork 4.8.1");
end
%[text] ## Select .NET Framework or .NET
%[text] If .NET is already loaded, the runtime environment cannot be changed.
if dotnetenv().Status=="loaded"
    disp("To change the environment, restart MATLAB then call dotnetenv.");
    return;
end
%[text] To change the runtime environment, call `dotnetenv`. The setting is persistent across MATLAB sessions.
% .NET is supported on all platforms
dotnetenv core;

% .NET Framework is only supported on Windows
if ispc
    dotnetenv framework;
end
%[text] MATLAB will search the default install location for .NET. This can be overridden with the `DOTNET_ROOT` environment variable. `DOTNET_ROOT` is ignored for the `framework` configuration.
if isunix
    !dotnet --info
    if isfolder("/users/runner/.dotnet")
        % GitHub hosted runners install .NET in this location
        setenv DOTNET_ROOT /Users/runner/.dotnet
    end
end
%[text] ## Select a Specific Version of .NET
%[text] `dotnetenv` supports configuring the roll-forward behavior using the `Version` name-value pair.
% Roll forward to the latest minor and patch version of .NET 8
dotnetenv("core", Version="8");

% ..or the latest patch version of .NET 8.0
dotnetenv("core", Version="8.0");

% ..or the exact version of .NET 8.0.3
dotnetenv("core", Version="8.0.3");
%[text] You can also specify which base-class-libraries to load using the `Frameworks` name-value pair.
% Make .NET Core and ASP.NET Core libraries accessible from MATLAB
% "Version" was excluded, so this selects the latest version of .NET
dotnetenv("core", Frameworks=["Microsoft.NETCore.App", "Microsoft.AspNetCore.App"]);
%[text] To verify the configuration, call `NET.isNETSupported.`
if NET.isNETSupported
    disp("ASP.NET successfully loaded");
else
    disp("Could not load ASP.NET");

    % Revert to default config if .NET couldn't be loaded
    if ispc
        dotnetenv framework;
    else
        dotnetenv core;
    end
    assert(NET.isNETSupported);
end

% Display the current configuration
dotnetenv()

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":31.8}
%---
