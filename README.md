# SuReLI docker images repository

**Ongoing work, needs testing**

This is a fork from [Andrei Maksimov's python_data_science repository](https://github.com/andreivmaksimov/python_data_science). It also contains as sub-modules: [OpenAI Gym's repository](https://github.com/openai/gym) ; and Emmanuel Rachelson's [RL Jupyter notebooks](https://github.com/erachelson/RLclass) and [ML Jupyter notebooks](https://github.com/erachelson/MLclass).

## Requirements 

You need to install `sshpass` (e.g. with `apt install sshpass`). This requirement isn't a strong one. If you prefer you can look into the script `sureli-docker.sh` and remove sshpass by for example adding your public key to the `authorized_keys` file in the docker image and commiting it.

If you don't understand what I am talking about, install `sshpass`.

## Cloning

As this repository has sub-modules please clone with 

```
git clone --recurse-submodules repository-address
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

To run the docker just execute `./sureli-docker.sh`, which:
 - Runs the docker container
 - Exports port 8888 (Jupyter) and 6006 (Tensorflow Dashboard) 
 - Mounts the `notebook` directory inside the container
 - Logs in the container via SSH
 - Stops the container when exiting the SSH connection

If you get an SSH warning about a man-in-the-middle attack execute the line which starts with `ssh-keygen -f...`. Note that doing so isn't safe for non-loopback connections so don't get used to it ;).


## Using

Once inside the container you can work inside `notebooks` to ensure your data is kept across sessions. No program is run by default, if you want to run jupyter you have to launch it (e.g. with `jupyter notebook`).

