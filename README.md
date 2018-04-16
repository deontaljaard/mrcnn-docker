mrcnn-docker
============

This project only houses a Dockerfile which encapsulates all (or, most of) the dependencies to get started with the Matterport object detection and instance level segmentation library called [Mask_RCNN](https://github.com/matterport/Mask_RCNN).

The Dockerfile extends from a deep-learning image and installs the Mask_RCNN library.

It shares a MIT license, like the Mask_RCNN project.

## Usage
For a more detailed usage, see [this](https://hub.docker.com/r/waleedka/modern-deep-learning/) Docker Hub repo.

In summary, you can quickly get started with the following

Build the docker image
```bash
docker build -t deontaljaard/mrcnn .
```

Run it
```bash
docker run -it -p 8888:8888 -p 6006:6006 -v ~/:/host deontaljaard/mrcnn
```

To import the relevant namespaces from mrcnn in your Python file, you can do the following for example
```bash
import mrcnn.model
``` 

Happy detecting and segmenting!
