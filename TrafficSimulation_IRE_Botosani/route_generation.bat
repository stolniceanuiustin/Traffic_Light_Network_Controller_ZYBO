@echo off
REM --- SET WORKING DIRECTORY ---
cd /d "%~dp0"

echo.
echo --- Running randomTrips.py to generate car trip definitions (HIGH VOLUME) ---
echo.

python "C:/Program Files (x86)/Eclipse/Sumo/tools/randomTrips.py" ^
    -n IntersectieIRE.net.xml ^
    -o car_trips.xml ^
    --route-file car_routes.rou.xml ^
    -b 0 -e 3600 ^
    -p 1.5 ^
    --seed 42 ^
    --min-distance 50 ^
    --fringe-factor 50 ^
    --vclass passenger ^
    --vtype car ^
    --prefix car_

echo.
echo --- Trip generation process finished. ---
pause