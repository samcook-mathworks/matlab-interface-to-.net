# MATLAB Interface to .NET
The Microsoft® interface to .NET provides a large body of precoded solutions to common program requirements. You can create instances of .NET classes and interact with .NET applications from MATLAB.

MATLAB supports loading these .NET assemblies:
* .NET, including .NET Core (Microsoft Windows®, macOS, and Linux®)
* .NET Framework (Windows only)

---
## System Requirements
The MATLAB® interface supports:
* .NET Framework 4.0 Runtime and higher (Microsoft® Windows®)
* .NET Desktop Runtime 6.0 and higher (Microsoft Windows)
* .NET Runtime 6.0 and higher (macOS and Linux®)

 By default, MATLAB uses the latest version of .NET found on your system.

---
## Change .NET Core Settings
The [dotnetenv](https://www.mathworks.com/help/matlab/ref/dotnetenv.html) function lets you change settings for the .NET Runtime environment. For example, you can select a specific numerical version using the [Version](https://www.mathworks.com/help/matlab/ref/dotnetenv.html#mw_c66e6881-68b3-4766-9169-b38c401ba32f) name-value argument. To choose a target framework, use the [Frameworks](https://www.mathworks.com/help/matlab/ref/dotnetenv.html#mw_e838d56f-12d8-447d-be3e-5095ac3fd21c) name-value argument. For example:
```matlab
ne = dotnetenv("core", Version="8", Frameworks="Microsoft.WindowsDesktop.App");
```
These settings are persistent across MATLAB sessions.

---
## Access a .NET Class
This example shows how to access functionality already loaded on your system.
```matlab
% Create object for current date and time
netDate = System.DateTime.Now;

% Display properties
netDate.DayOfWeek
netDate.Hour

% Call methods
ToShortTimeString(netDate)
AddDays(netDate,7);

% Call static method
System.DateTime.DaysInMonth(netDate.Year,netDate.Month)
```
