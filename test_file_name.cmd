@ECHO OFF

SET YYYYMMDD=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
SET YYMMDD=%DATE:~8,2%%DATE:~3,2%%DATE:~0,2%
REM inverse la variable %DATE% pour obtenir une date en Ann�e mois jour bien plus facile � trier

for /F "tokens=1,2,3,4,5,6 delims==:.-/, " %%A in ("%TIME%") do SET MYTIME=%%A%%B%%C%%D%%E%%F
REM cette boucle permet de filtrer la variable %TIME% afin d'en �liminer tout caract�re ind�sirable
REM dans un nom de fichier. On suppose que %TIME% se divise en 6 parties d�limit�es par [:.-/, ].
REM le nombre de parties et les d�limiteurs n'ont pas � �tre exactes, il suffit qu'ils couvrent  
REM le probl�me.
     

SET FILEUID=NOMFICHIER_%YYYYMMDD%_%MYTIME%_%RANDOM%
REM enfin on rajoute un nombre al�atoire au nom du fichier afin de le rendre unique

echo %FILEUID%
echo %YYMMDD%

pause