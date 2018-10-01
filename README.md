# SuReLI docker images repository

**Ongoing work, needs testing**

This is a fork from [Andrei Maksimov's python_data_science repository](https://github.com/andreivmaksimov/python_data_science). It also contains as sub-modules: [OpenAI Gym's repository](https://github.com/openai/gym) ; and Emmanuel Rachelson's [RL Jupyter notebooks](https://github.com/erachelson/RLclass) and [ML Jupyter notebooks](https://github.com/erachelson/MLclass).

## Cloning

As this repository has sub-modules please clone with 

```
git clone --recurse-submodules repository-address
```

## Building

To build the Docker images run 

```
./build.sh
```

If you get a build error, please rerun the build script before filling an issue.

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

The second, `sureli-docker`, has also Open AI Gym and adds a few utilities such as ipython3, git, vim, tmux, screen.

**Warning:**  The docker container is not aware of any proxies, please connect to a network with direct access to the Internet to ensure the image is able to download the required software packages. If you are at ISAE SUPAERO you have this with "Eduroam".

## Running

To run the docker just execute `./sureli-docker.sh [no-gym]`, which:
 - Runs the appropriate docker container
 - Exports port 8888 (Jupyter) and 6006 (Tensorflow Dashboard) 
 - Mounts the `notebook` directory inside the container
 - Logs in the container via SSH
 - Stops the container when exiting the SSH connection

## Using

Once inside the container you can work inside `notebooks` to ensure your data is kept across sessions. No program is run by default, if you want to run jupyter you have to launch it (e.g. with `jupyter notebook`).

