# Docker image for Python development

## Main Objective

To provide execution environment during Python development


## Why do I want this?

When I prepare test environment for multiple Python projects, it was a bit troublesome
to prepare / update each environment.

## Solution

By using Docker, provide consistent way to prepare test environment.

## Usage
1. Copy `build_pydev.bat` and `Dockerfile` to your module's directory
    - see ["Requirements"](#Requirements) for details
2. Build image (whennever you update code, do this step again)
    - run `build_pydev.bat ${module_name}`
3. Example usage 
    1. Run test
        - `docker run pydev_${module_name}:0.0 pytest`
    2. Jupyter (note notebooks are just created in the container and will not be saved by default)
        - `docker run -p ${port}:8888 pydev_${module_name}:0.0`
    3. General interactive shell
        - `docker run -i -t pydev_${module_name}:0.0 /bin/bash`
        - e.g. upload built wheel to pypi `python3 -m twine upload --repository pypi dist/*`

## How it works?

- Copy everything in current directory in container
- Install dependent packages by your `requirements.txt`
    - **We split dependent module installation and your module installation to save building time**
- Install your package by your `setup.py`
    - Tips: You can use `pkg_resources.parse_requirements` to specify dependent packages from requirements.txt

## Requirements

When you build image, current directory must have
- `Dockerfile` and `build_pydev.bat` in this repository
- Following files for your Python package
    - `./requirements.txt` which describes all the dependent Python libraries
    - `./setup.py` and `./README.md` to install your module
