@echo off

set "scriptPath=%~dp0"

powershell.exe -ExecutionPolicy Bypass -File "%scriptPath%ChangeWallpaper.ps1"
