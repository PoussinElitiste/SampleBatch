@ECHO OFF

DATE /T

FOR /F "usebackq tokens=1,2,3,4 delims=/ " %%A in (`DATE /T`) DO (
  rem ECHO Jour de la semaine: %%A
  ECHO Jour du mois: %%A
  ECHO Mois: %%B
  ECHO Année: %%C
)

pause