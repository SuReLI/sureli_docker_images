# SuReLI docker images repository

**Ongoing work, needs testing**

This is a fork from [Andrei Maksimov's python_data_science repository](https://github.com/andreivmaksimov/python_data_science). It also contains as sub-modules: [OpenAI Gym's repository](https://github.com/openai/gym) ; and Emmanuel Rachelson's [RL Jupyter notebooks](https://github.com/erachelson/RLclass) and [ML Jupyter notebooks](https://github.com/erachelson/MLclass).

## Cloning

As this repository has sub-modules please clone with 

```
git clone --recurse-submodules repository-address
```

## Quick setup

Pre-requisites (Ubuntu)

```
# Install Docker from docker.com or in recent Ubuntu distribs with 
sudo apt install docker.io
# On older distribs docker-ce should be installed instead of docker.io
# Add yourself to the docker group
sudo usermod -aG docker ${USER} && su - ${USER}
# Install sshpass for the startup script
sudo apt install sshpass
```

Pre-requisites (Fedora 25)
```
# Install Docker 
sudo dnf install docker
sudo systemctl start docker
sudo systemctl enable docker
# Add yourself to the docker group
sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
newgrp docker
# Install sshpass for the startup script
sudo dnf install sshpass
```
On Fedora 26+ check the instructions at docker.com


Pulling, launching and testing.

```
# Get the sureli-docker image from dockerhub (or build it following instructions in the README)
docker pull carlosaguilar/sureli-docker
# Tag it to have a shorter name
docker tag docker.io/carlosaguilar/sureli-docker sureli-docker
# Run the docker image and log in with ssh to it with a tmux session
./sureli-docker.sh
# Launch Jupyter
jupyter notebook
# Open a web navigator and go to http://localhost:38888
# Go to "RL Class -> RL0 - Introduction to Reinforcement Learning.ipynb"
# Execute the first python cell (bottom of the document)
# This should open up a window with Breakout
# Note that the second python cell does not work as it should be env1.close()
# Go back to your terminal and press Ctrl+b and then c to create a new tab in tmux
# Start iPython
ipython
# Test some code 
import gym
env0 = gym.make('FrozenLake-v0')
env0.render()
env1 = gym.make('Breakout-v0')
env1.render()
# This should also open a Breakout window
# Close it now
env1.close()
# To pass from a tab to another you can use Ctrl+b and then n (next) or p (previous)
# Quick-setup finished !
```


## Building

If you want to skip building you can go to the next section to directly pull a ready-to-use docker image.

To build the Docker images run 

```
./build.sh
```

Two images are built. The first, `sureli-docker-no-gym`, has:
 - NumPy
 - Pandas
 - Sklearn
 - Matplotlib
 - Seaborn
 - pyyaml
 - h5py
 - Jupyter
 - Tensorflow
 - Keras
 - OpenCV 3

The second, `sureli-docker`, has also Open AI Gym and adds a few utilities such as ipython3, git, vim, tmux, screen. Only this image is supported, the intermediate image is functional but very limited (e.g. no graphics are exported).

To limit the space requirements, the intermediate image, `sureli-docker-no-gym`, is erased at the end of the `build.sh` script.

**Warning:**  If you need a proxy to connect to the Internet you will most probably run into trouble when trying to build docker images. If you have connectivity issues with this script you can pull a ready-to-use image as explained in the next section. 

## Pulling

**Preliminary note:** Even if you do not build your image you should clone this repository as it will give you access to the `sureli-docker.sh` script and to the `notebooks` directory.

To pull an image instead of building it just run `docker pull carlosaguilar/sureli-docker` (note this will download around 5Gbytes of data which may take some time).

## Running

### Requirements 

You need to install `sshpass` (e.g. with `apt install sshpass`). This requirement isn't a strong one. If you prefer you can look into the script `sureli-docker.sh` and remove sshpass by for example adding your public key to the `authorized_keys` file in the docker image and commiting it.

If you don't understand what I am talking about, install `sshpass`.

### Launching script

To run the docker just execute `./sureli-docker.sh`, which:
 - Runs the docker container
 - Exports port 8888 (Jupyter) and 6006 (Tensorflow Dashboard) to 38888 and 36006
 - Mounts the `notebook` directory inside the container
 - Logs in the container via SSH
 - Starts a tmux session
 - Stops the container when exiting the SSH connection

If you get an SSH warning about a man-in-the-middle attack execute the line which starts with `ssh-keygen -f...` (you may need to add quotes to the last argument of this command). Note that doing so isn't safe for non-loopback connections so don't get used to it ;).


## Container usage

Once inside the container you can work inside `notebooks` to ensure your data is kept across sessions. No program is run by default, if you want to run jupyter you have to launch it (e.g. with `jupyter notebook`).

