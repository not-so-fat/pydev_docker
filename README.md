# Docker image for Python development

## Main Objective

To provide execution environment during Python development

## How it works?

- Copy everything in current directory in container
- Install dependent packages by your `requirements.txt`
- Install your package by your `setup.py`

## Requirements

When you build image, current directory must have
- `Dockerfile` and `build_pydev.bat` in this repository
- Following files for your Python package
    - `./requirements.txt` which describes all the dependent Python libraries
    - `./setup.py` and `./README.md` to install your module

## Usage
1. Build image
    - run `build_pydev.bat ${module_name}`
2. Example usage 
    1. Test
        - `docker run pydev_${module_name}:0.0 pytest`
    2. Jupyter
        - `docker run pydev_${module_name}:0.0 -d jupyter notebook --allow-root`
    3. General interactive shell
        - `docker run -i -t pydev_${module_name}:0.0 /bin/bash`
