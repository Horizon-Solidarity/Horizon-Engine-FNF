@echo off
color 0a
cd ..
@echo on
echo Installing dependencies...
echo This might take a few moments depending on your internet speed.

haxelib install flixel
haxelib install flixel-addons

haxelib git haxeui-core https://github.com/haxeui/haxeui-core 99d5d035e7120ce027256b117a25625c53b488dc
haxelib git haxeui-flixel https://github.com/haxeui/haxeui-flixel b899a4c7d7318c5ff2b1bb645fbc73728fad1ac9

haxelib git flixel-animate https://github.com/MaybeMaru/flixel-animate c5e3393c70b71a191f20fa902114cea92042e486

haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib git lscript https://github.com/SrtHero278/lscript 778712861e0ffb27712c154eb180d20931701a68

haxelib git hscript-insanity https://github.com/inky03/hscript-insanity

haxelib git json2object https://github.com/FunkinCrew/json2object

haxelib install tjson
haxelib install hxjsonast
haxelib install json5hx
haxelib install hxdiscord_rpc
haxelib install hxvlc --skip-dependencies
haxelib install thx.core
haxelib install thx.semver
haxelib install tink_core
echo Finished!
pause