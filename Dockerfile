# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/windows:10.0.17763.4645
WORKDIR C:/
COPY installers installers
COPY install_scripts install_scripts
WORKDIR C:/installers

# -------------
# Install Adams
# -------------
RUN adams_2022.1_windows64.exe -s -f1"C:/install_scripts/adams_2022.1_windows64.iss"
RUN adams_2022.2_windows64.exe -s -f1"C:/install_scripts/adams_2022.2_windows64.iss"
WORKDIR C:/
RUN rmdir /S /Q installers
RUN rmdir /S /Q install_scripts
RUN mkdir workdir

WORKDIR C:/workdir
