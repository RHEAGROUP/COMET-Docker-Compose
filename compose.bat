@echo off

set DB_POSTGRESPASSWORD=pass
set DB_HOSTPORT=5432
set DB_TESTHOSTPORT=5432
set WEBSERVICES_HOSTPORT=5000

IF %1.==. GOTO Up
IF %1==up GOTO Up
IF %1==update GOTO Update
IF %1==rcupdate GOTO RcUpdate
IF %1==down GOTO Down
IF %1==strt GOTO Strt
IF %1==stp GOTO Stp
IF %1==reboot GOTO Reboot

IF %1==rc GOTO Rc
IF %1==rcdown GOTO Down

IF %1==testrc GOTO TestRc
IF %1==testrcdown GOTO TestRcDown

IF %1==test GOTO Test
IF %1==testdown GOTO TestDown

GOTO End

:Strt
CALL docker compose start
GOTO End

:Stp
CALL docker compose stop
GOTO End

:Up
CALL docker compose down --remove-orphans
CALL docker compose up -d
GOTO End

:Update
CALL docker compose down --remove-orphans
CALL docker compose pull
GOTO End

:Down
CALL docker compose down --remove-orphans
GOTO End

:Reboot
CALL docker compose down
CALL docker compose up -d
GOTO End

:Rc
CALL docker compose -f docker-compose-rc.yml down --remove-orphans
CALL docker compose -f docker-compose-rc.yml up -d
GOTO End

:RcUpdate
CALL docker compose -f docker-compose-rc.yml down --remove-orphans
CALL docker compose -f docker-compose-rc.yml pull
GOTO End

:RcDown
CALL docker compose -f docker-compose-rc.yml down --remove-orphans
GOTO End

:TestRc
CALL docker compose -f docker-compose-rc-test.yml down --remove-orphans
CALL docker compose -f docker-compose-rc-test.yml up -d
GOTO End

:TestRcDown
CALL docker compose -f docker-compose-rc-test.yml down --remove-orphans
GOTO End

:Test
CALL docker compose -f docker-compose-test.yml down --remove-orphans
CALL docker compose -f docker-compose-test.yml up -d
GOTO End

:TestDown
CALL docker compose -f docker-compose-test.yml down --remove-orphans
GOTO End

:End
