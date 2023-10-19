# Adams Docker

## Building on Windows

```bat
cd windows
docker build -t bthornton191/adams:all_versions-win10 .
```

## Building on Linux

> **NOTE**: I have not been able to automate the installation of adams on linux. 
> One should be able to provide a config.rec file to the installer, but I have 
> not  been able to get it to work. It always asks for a new file in order to 
> acnowledge the license agreement.
>
> Thus, the process is as follows:
> 1. Build a preliminary image
> 2. Run the preliminary image interactively and manually install adams
> 3. Commit the container to a new image
> 4. Build the final image

### Step 1: Build a preliminary image

```bash
cd linux_build
docker build -t bthornton191/adams_build0:2022_1-rl8.4 .
```

### Step 2: Manually install adams in a preliminary image

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

### Step 3: Commit the container to a new image

```bash
docker commit adams_build1 bthornton191/adams_build1:2022_1-rl8.4
```

### Step 4: Build the final image

```bash 
cd ../linux_final
docker build -t bthornton191/adams:2022_1-rl8.4 .
```

# To Do
- Setup compiliers inside the container
  - This would allow users to compile subroutines for any platform

