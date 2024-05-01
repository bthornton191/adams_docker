# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/windows:10.0.17763.4645
ARG ADAMS_INSTALLER
ARG ADAMS_SCRIPT
RUN mkdir installers
COPY "${ADAMS_INSTALLER}" "installers/adams_installer.exe"
COPY "${ADAMS_SCRIPT}" "install_scripts/adams_install_script.iss"
WORKDIR C:/installers

# -------------
# Install Adams
# -------------
RUN adams_installer.exe -s -f1"C:/install_scripts/adams_install_script.iss"
ENV PATH="${PATH}:C:\Adams\common"
WORKDIR C:/
RUN rmdir /S /Q installers
RUN rmdir /S /Q install_scripts
RUN mkdir workdir

WORKDIR C:/workdir
