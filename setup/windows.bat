@echo off
color 0a
cd ..
@echo on
echo Installing dependencies...
echo This might take a few moments depending on your internet speed.
haxelib install hxpkg
haxelib run hxpkg uninstall
haxelib run hxpkg install
echo Finished!
pause
