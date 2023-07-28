# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/windows:10.0.17763.4645
WORKDIR C:/
COPY installers installers
WORKDIR C:/installers

# --------------------
# Install Python 3.8.8
# --------------------
RUN python-3.8.8-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0 
RUN pip install --upgrade pip
RUN pip install wheel

# --------------------
# Install Adams 2022.1
# --------------------
RUN adams_2022.1_windows64.exe -s -f1"C:/installers/adams_2022.1_windows64.iss"
ENV ADAMS_LAUNCH_COMMAND="C:/Program Files/MSC.Software/Adams/2022_1_875404/common/mdi.bat"
WORKDIR C:/
RUN rmdir /S /Q installers
RUN mkdir app

# --------------------------
# Install the OpenSSH Server
# --------------------------
ADD https://github.com/PowerShell/Win32-OpenSSH/releases/download/0.0.24.0/OpenSSH-Win64.zip c:/openssh.zip
RUN powershell Expand-Archive c:/openssh.zip c:/ ; Remove-Item c:/openssh.zip
RUN powershell Set-ExecutionPolicy Unrestricted
RUN powershell c:/OpenSSH-Win64/Install-SSHd.ps1

# Configure SSH
COPY sshd_config c:/OpenSSH-Win64/sshd_config
COPY sshd_banner c:/OpenSSH-Win64/sshd_banner
WORKDIR c:/OpenSSH-Win64/

# Don't use powershell as -f paramtere causes problems.
RUN ssh-keygen.exe -t dsa -N "" -f ssh_host_dsa_key 
RUN ssh-keygen.exe -t rsa -N "" -f ssh_host_rsa_key 
RUN ssh-keygen.exe -t ecdsa -N "" -f ssh_host_ecdsa_key 
RUN ssh-keygen.exe -t ed25519 -N "" -f ssh_host_ed25519_key

# Create a user to login, as containeradministrator password is unknown
RUN net USER ssh "Passw0rd" /ADD && net localgroup "Administrators" "ssh" /ADD

# # Set PS6 as default shell
RUN powershell New-Item -Path HKLM:\SOFTWARE -Name OpenSSH -Force
RUN powershell New-ItemProperty -Path HKLM:\SOFTWARE\OpenSSH -Name DefaultShell -Value c:\ps6\pwsh.exe -PropertyType string -Force 
RUN powershell ./Install-sshd.ps1
RUN powershell ./FixHostFilePermissions.ps1 -Confirm:$false;
RUN powershell Set-ItemProperty -Path HKLM:\SOFTWARE\OpenSSH -Name DefaultShell -Value cmd.exe
EXPOSE 22

# For some reason SSH stops after build. So start it again when container runs.
CMD [ "powershell", "-NoExit", "-Command", "Start-Service" ,"sshd" ]

WORKDIR C:/app
