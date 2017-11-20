@echo off

goto START

:Usage
echo Usage: convert 
echo    Generates the wm.xml file for the inf files and renames the existing pkg.xml to _pkg.xml
echo    [/?].................... Displays this usage string.
echo    Example:
echo        convert 
endlocal
exit /b 1

:START
setlocal ENABLEDELAYEDEXPANSION
if [%BSP_ARCH%] neq [x86] (
    echo.%CLRRED%Error: Supported only in x86.%CLREND%
    exit /b 1
)

set DST_DIR=%BSPSRC_DIR%\APLx86

echo Fixing the BSPFM.xml file 
powershell -Command "(gc %DST_DIR%\Packages\APLx86FM.XML) -replace 'Intel.APL.OEM', '%%OEM_NAME%%.APL.OEM' -replace 'Intel.APL.Device', '%%OEM_NAME%%.APL.Device' -replace 'FeatureIdentifierPackage=\"true\"', '' | Out-File %DST_DIR%\Packages\APLx86FM.xml -Encoding utf8"
echo Fixing the TestOEMInput.xml file
powershell -Command "(gc %DST_DIR%\OEMInputSamples\TestOEMInput.xml) -replace '%%BSPSRC_DIR%%', '%%BLD_DIR%%' -replace 'APLx86\\Packages','MergedFMs' | Out-File %DST_DIR%\OEMInputSamples\TestOEMInput.xml -Encoding utf8"
echo Fixing the RetailOEMInput.xml file
powershell -Command "(gc %DST_DIR%\OEMInputSamples\RetailOEMInput.xml) -replace '%%BSPSRC_DIR%%', '%%BLD_DIR%%' -replace 'APLx86\\Packages','MergedFMs' | Out-File %DST_DIR%\OEMInputSamples\RetailOEMInput.xml -Encoding utf8"

endlocal

echo Conversions done
exit /b 0