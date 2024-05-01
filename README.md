# Adams Docker
## Usage
The following runs a mymodel.acf in the current working directory using adams 2022.2.
```bat
docker run -v .:c:/workdir -e MSC_LICENSE_FILE=27500@%COMPUTERNAME% bthornton191/adams:adams_2022.2_windows64 mdi.bat ru-s mymodel.acf
```

## Development

### Building on Windows

#### Step 1: Download the Adams installers

Download all the installers for all versions to be dockerized. Place them in a directory
and set the environment variable `ADAMS_WINDOWS_INSTALLERS_DIR` to the path of the directory.

#### Step 2: Build the image(s)

To build the image(s), run the following command from the root of the repository:
```bat
python build.py windows\Dockerfile windows\install_scripts %ADAMS_WINDOWS_INSTALLERS_DIR% 
```

### Building on Linux
> [!NOTE]
> The linux build process is completely different from the windows build process.
> 

I have not been able to automate the installation of adams on linux. 
One should be able to provide a config.rec file to the installer, but I have 
not  been able to get it to work. It always asks for a new file in order to 
acnowledge the license agreement.
Thus, the process is as follows:
1. Build a preliminary image
2. Run the preliminary image interactively and manually install adams
3. Commit the container to a new image
4. Build the final image

#### Pre-requisites
- Download the linux installer(s) for the version of adams you want to install and place them in the
  **linux_build/installers** directory.

> [!IMPORTANT]
> Adams version **2022.1** is hardcoded in **linux_build/Dockerfile** and 
> **linux_final/Dockerfile**. If you want to install a different version, you will need to modify
> the files.

#### Step 1: Build a preliminary image

```bash
cd linux_build
docker build -t bthornton191/adams_build0:2022_1-rl8.4 .
```

#### Step 2: Manually install adams in a preliminary image

```bash
docker run -it --name adams_build1 bthornton191/adams_build0:2022_1-rl8.4 /bin/bash

# In the container
./adams_2022.1_linux64_rh8.4.bin --prefix /Adams/2022_1 --mode console

# Respond to prompts
# 1. Accept the license
# 2. Install to /Adams/2022_1
# 3. Set the license location to 27500@hostname (or whatever your license server is)

exit
```

#### Step 3: Commit the container to a new image

```bash
docker commit adams_build1 bthornton191/adams_build1:2022_1-rl8.4
```

#### Step 4: Build the final image

```bash 
cd ../linux_final
docker build -t bthornton191/adams:2022_1-rl8.4 .
```

### To Do
- [ ] Setup compiliers inside the container
  - This would allow users to easily compile subroutines for any platform
- [ ] Remove hardcoded version numbers in linux build process
  

