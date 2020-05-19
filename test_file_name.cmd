@ECHO OFF

SET YYYYMMDD=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
SET YYMMDD=%DATE:~8,2%%DATE:~3,2%%DATE:~0,2%
REM inverse la variable %DATE% pour obtenir une date en Année mois jour bien plus facile à trier

for /F "tokens=1,2,3,4,5,6 delims==:.-/, " %%A in ("%TIME%") do SET MYTIME=%%A%%B%%C%%D%%E%%F
REM cette boucle permet de filtrer la variable %TIME% afin d'en éliminer tout caractère indésirable
REM dans un nom de fichier. On suppose que %TIME% se divise en 6 parties délimitées par [:.-/, ].
REM le nombre de parties et les délimiteurs n'ont pas à être exactes, il suffit qu'ils couvrent  
REM le problème.
     

SET FILEUID=NOMFICHIER_%YYYYMMDD%_%MYTIME%_%RANDOM%
REM enfin on rajoute un nombre aléatoire au nom du fichier afin de le rendre unique

echo %FILEUID%
echo %YYMMDD%

pause