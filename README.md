# Usando a instalação do QGIS para rodar python 3


## Setar as variáveis de ambiente no windows

```cmd
@echo off
rem Root OSGEO4W home dir to the same directory this script exists in
call "%~dp0\bin\o4w_env.bat"

rem List available o4w programs
rem but only if osgeo4w called without parameters

call "%OSGEO4W_ROOT%\apps\grass\grass78\etc\env.bat"
call qt5_env.bat
call py3_env.bat
@echo off
path %OSGEO4W_ROOT%\apps\qgis\bin;%OSGEO4W_ROOT%\apps\grass\grass78\lib;%OSGEO4W_ROOT%\apps\grass\grass78\bin;%PATH%
PATH %OSGEO4W_ROOT%\apps\qgis\python;%PATH%
PATH %OSGEO4W_ROOT%\apps\qgis\bin;%PATH%
PATH %OSGEO4W_ROOT%\apps\Qt5\bin;%PATH%
PATH %OSGEO4W_ROOT%\apps\Python37;%PATH%
PATH %OSGEO4W_ROOT%\apps\Python37\Scripts;%PATH%
PATH %OSGEO4W_ROOT%\apps\qgis\python\plugins;%PATH%
PATH %OSGEO4W_ROOT%\apps\Python37\DLLs;%PATH%
PATH %OSGEO4W_ROOT%\apps\Python37\lib;%PATH%
PATH %OSGEO4W_ROOT%\apps\Python37\lib\site\packages;%PATH%

set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/qgis
set GDAL_FILENAME_IS_UTF8=YES
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\qgis\qtplugins;%OSGEO4W_ROOT%\apps\qt5\plugins
set PYTHONPATH=%OSGEO4W_ROOT%\apps\qgis\python

set PYTHONUSERBASE=%USERPROFILE%\python
IF NOT EXIST %PYTHONUSERBASE% (mkdir %PYTHONUSERBASE% )
set path=%PYTHONUSERBASE%\Python37\Scripts;%path%

@echo on
@if [%1]==[] (echo run o-help for a list of available commands & cmd.exe /k) else (cmd /c "%*")

```

## Instalar a versão mais atual de PIP for windows, preferencialmente no modo usuário
```cmd
start microsoft-edge:https://bootstrap.pypa.io/get-pip.py
python  get-pip.py --user
python -m pip  install --user csvkit
```


## Instalação do Jupyter Notebook
```cmd
python -m pip install --user --upgrade jupyter ipykernel jupyter_client nbconvert`
```

## Instalação do Spyder 4
```cmd
# pyqtwebengine 5.12.1 requires PyQt5>=5.12
python -m pip install --user --upgrade --use-feature=2020-resolver  spyder 
# 
set QT_PLUGIN_PATH=E:\Users\sp-miguel\python\Python37\site-packages\PyQt5\Qt\plugins;C:\PROGRA~1\QGIS\3.10\apps\qgis\qtplugins;C:\PROGRA~1\QGIS\3.10\apps\qt5\plugins
```

