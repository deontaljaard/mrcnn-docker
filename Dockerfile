FROM waleedka/modern-deep-learning:latest

ENV TEMP_MRCNN_DIR /tmp/mrcnn

# ENV variables for python3 - see http://click.pocoo.org/5/python3/
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Silence Tensorflow warnings - look into compiling for CPU supported instruction sets
ENV TF_CPP_MIN_LOG_LEVEL 2

RUN pip install --upgrade pip

# NOTE: cloning master (might be an unstable HEAD)
RUN git clone https://github.com/matterport/Mask_RCNN.git $TEMP_MRCNN_DIR

RUN cd $TEMP_MRCNN_DIR && \
 python3 setup.py install

WORKDIR "/root"
CMD ["/bin/bash"]