# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/windows:10.0.17763.4645
WORKDIR C:/
COPY installers installers
WORKDIR C:/installers

# --------------------
# Install Adams 2022.1
# --------------------
RUN adams_2022.1_windows64.exe -s -f1"C:/installers/adams_2022.1_windows64.iss"
ENV ADAMS_LAUNCH_COMMAND="C:/Adams/2022_1_875404/common/mdi.bat"
WORKDIR C:/
RUN rmdir /S /Q installers
RUN mkdir workdir

ENTRYPOINT [ "C:/Adams/2022_1_875404/common/mdi.bat" ]

WORKDIR C:/workdir
