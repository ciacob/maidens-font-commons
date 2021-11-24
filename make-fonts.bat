@echo off

set AIR_SDK_HOME=d:\_DEV_\_BUILD_\AIR_SDK\win\Flex_4.16.1_AIR_28.0
set JAVA=d:\_DEV_\_BUILD_\JAVA\win\openjdk-1.8.0\bin\java.exe

echo Using AIR SDK: %AIR_SDK_HOME%
echo Using JAVA:
%JAVA% -version

set "CURR_DIR=%cd%"
cd fonts

echo package eu.claudius.iacob ^{>..\templates\main-class-header.txt
echo import flash.text.Font;>>..\templates\main-class-header.txt
echo. >>..\templates\main-class-header.txt
echo public final class EmbeddedFontsHelper ^{>>..\templates\main-class-header.txt

echo // Embedding compiled fonts>..\templates\main-class-body.txt

echo /* Explicitly registers all embedded fonts on-demand. */>..\templates\main-class-footer.txt
echo public static function initFonts ^(^) : void ^{>>..\templates\main-class-footer.txt

setlocal enabledelayedexpansion
for /R %%F in (*.ttf) do (

	echo.
    echo DOING %%~nF.ttf

	ECHO.%%~nF| FIND /I "_bold">Nul && ( 
	  Echo.FONT IS BOLD
	  call :removeBold %%~nF

      echo ^[Embed^(source="../../../../fonts-compiled/%%~nF.swf", symbol="!aliasToUse!_embedded"^)^]>>..\templates\main-class-body.txt
      echo public static const %%~nF_font_class : Class;>>..\templates\main-class-body.txt
      echo.>>..\templates\main-class-body.txt
      echo Font.registerFont^(%%~nF_font_class^);>>..\templates\main-class-footer.txt

      @%JAVA% -Dsun.io.useCanonCaches=false -Xms32m -Xmx512m -Dflexlib="%AIR_SDK_HOME%\frameworks" -jar "%AIR_SDK_HOME%\lib\flex-fontkit.jar" -alias !aliasToUse!_embedded -bold -3 -o "..\fonts-compiled\%%~nF.swf" "%%~nF.ttf"
      
	) || (
		ECHO.%%~nF| FIND /I "_italic">Nul && ( 
		  Echo.FONT IS ITALIC
		  call :removeItalic %%~nF

          echo ^[Embed^(source="../../../../fonts-compiled/%%~nF.swf", symbol="!aliasToUse!_embedded"^)^]>>..\templates\main-class-body.txt
          echo public static const %%~nF_font_class : Class;>>..\templates\main-class-body.txt
          echo.>>..\templates\main-class-body.txt
          echo Font.registerFont^(%%~nF_font_class^);>>..\templates\main-class-footer.txt

    	  @%JAVA% -Dsun.io.useCanonCaches=false -Xms32m -Xmx512m -Dflexlib="%AIR_SDK_HOME%\frameworks" -jar "%AIR_SDK_HOME%\lib\flex-fontkit.jar" -alias !aliasToUse!_embedded -italic -3 -o "..\fonts-compiled\%%~nF.swf" "%%~nF.ttf"

		) || (
		  Echo.FONT IS REGULAR

          echo ^[Embed^(source="../../../../fonts-compiled/%%~nF.swf", symbol="%%~nF_embedded"^)^]>>..\templates\main-class-body.txt
          echo public static const %%~nF_font_class : Class;>>..\templates\main-class-body.txt
          echo.>>..\templates\main-class-body.txt

          echo Font.registerFont^(%%~nF_font_class^);>>..\templates\main-class-footer.txt

    	  @%JAVA% -Dsun.io.useCanonCaches=false -Xms32m -Xmx512m -Dflexlib="%AIR_SDK_HOME%\frameworks" -jar "%AIR_SDK_HOME%\lib\flex-fontkit.jar" -alias %%~nF_embedded -3 -o "..\fonts-compiled\%%~nF.swf" "%%~nF.ttf"
		)
	)
)
endlocal

echo ^}>>..\templates\main-class-footer.txt
echo ^}>>..\templates\main-class-footer.txt
echo ^}>>..\templates\main-class-footer.txt

echo.
echo Building EmbeddedFontsHelper.as. Adding...
type ..\templates\main-class-header.txt ..\templates\main-class-body.txt ..\templates\main-class-footer.txt > ..\src\eu\claudius\iacob\EmbeddedFontsHelper.as

cd %CURR_DIR%
exit /b

:removeBold
set aliasToUse=%1
echo __BEFORE__ aliasToUse: %aliasToUse%
set aliasToUse=%aliasToUse:_bold=%
echo __AFTER__ aliasToUse: %aliasToUse%
exit /b

:removeItalic
set aliasToUse=%1
echo __BEFORE__ aliasToUse: %aliasToUse%
set aliasToUse=%aliasToUse:_italic=%
echo __AFTER__ aliasToUse: %aliasToUse%
exit /b