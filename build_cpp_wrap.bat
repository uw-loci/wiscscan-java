@echo off

rem The batch file takes in the root path of the WiscScan directory, as the location to copy all of the headers & lib files
rem Requires maven and cmake to be installed and added to the PATH, otherwise will fail
set wiscScanPath=%~f1
set cppwrapRootPath=%CD%\target\cppwrap
set OLDDIR=%CD%

call mvn clean
call mvn package cppwrap:wrap
cd .\target\cppwrap
rmdir /S /Q .\build
mkdir .\build
rem "Visual Studio 10" corresponds to the compiler used in Visual Studio 2010
cmake.exe -G"Visual Studio 10" -H"." -B".\build"
cd .\build
devenv.exe /build debug /project ALL_BUILD .\jace.sln

rem Copy the headers and jar files
xcopy /s /y "%cppwrapRootPath%\jace-runtime.jar" %wiscScanPath%\jar
xcopy /s /y "%cppwrapRootPath%\..\wiscscan-java-1.0-SNAPSHOT.jar" %wiscScanPath%\jar\
xcopy /s /y "%cppwrapRootPath%\jace\include\jace\"* %wiscScanPath%\jace\
xcopy /s /y "%cppwrapRootPath%\proxies\include\jace\"* %wiscScanPath%\jace\
xcopy /s /y "%cppwrapRootPath%\include\"* %wiscScanPath%\bfcpp

rem copy the jace lib files
xcopy /s /y "%cppwrapRootPath%\build\jace\debug\jace.dll" %wiscScanPath%\dlls\
xcopy /s /y "%cppwrapRootPath%\build\jace\debug\jace.dll" %wiscScanPath%\Debug\
xcopy /s /y "%cppwrapRootPath%\build\jace\debug\jace.lib" %wiscScanPath%\Lib\
xcopy /s /y "%cppwrapRootPath%\build\jace\debug\jace.lib" %wiscScanPath%\Debug\

rem copy the wiscscan-java lib files
xcopy /s /y "%cppwrapRootPath%\build\debug\wiscscan-java.dll" %wiscScanPath%\dlls\
xcopy /s /y "%cppwrapRootPath%\build\debug\wiscscan-java.dll" %wiscScanPath%\Debug\
xcopy /s /y "%cppwrapRootPath%\build\debug\wiscscan-java.lib" %wiscScanPath%\Lib\
xcopy /s /y "%cppwrapRootPath%\build\debug\wiscscan-java.lib" %wiscScanPath%\Debug\

chdir /d %OLDDIR%