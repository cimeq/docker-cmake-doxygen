# Docker CMake Doxygen

This Docker image provides an environment with:
- Ubuntu latest base
- CMake
- Doxygen
- Graphviz
- Python 3 requests library

## Usage

Build the image:
```
docker build -t cmake-doxygen .
```

Run container:
```
docker run -it cmake-doxygen
```
