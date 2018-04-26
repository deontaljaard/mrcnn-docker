FROM waleedka/modern-deep-learning:latest

ENV TEMP_MRCNN_DIR /tmp/mrcnn
ENV TEMP_COCO_DIR /tmp/coco
ENV MRCNN_DIR /mrcnn

# ENV variables for python3 - see http://click.pocoo.org/5/python3/
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Silence Tensorflow warnings - look into compiling for CPU supported instruction sets
ENV TF_CPP_MIN_LOG_LEVEL 2

RUN pip install --upgrade pip
RUN pip install --upgrade imgaug
RUN pip install --upgrade pillow

# NOTE: cloning master (might be an unstable HEAD)
RUN git clone https://github.com/matterport/Mask_RCNN.git $TEMP_MRCNN_DIR
COPY visualize.py $TEMP_MRCNN_DIR/mrcnn

RUN git clone https://github.com/waleedka/coco.git $TEMP_COCO_DIR

RUN cd $TEMP_MRCNN_DIR && \
 python3 setup.py install

RUN cd $TEMP_COCO_DIR/PythonAPI && \
    sed -i "s/\bpython\b/python3/g" Makefile && \
    make

RUN mkdir -p $MRCNN_DIR/coco

RUN wget -O $MRCNN_DIR/coco/mask_rcnn_coco.h5 https://github.com/matterport/Mask_RCNN/releases/download/v2.0/mask_rcnn_coco.h5

RUN wget -O $MRCNN_DIR/instances_minival2014.json.zip https://dl.dropboxusercontent.com/s/o43o90bna78omob/instances_minival2014.json.zip?dl=0 && \
    unzip $MRCNN_DIR/instances_minival2014.json.zip -d $MRCNN_DIR/coco/annotations && \
    rm -rf $MRCNN_DIR/instances_minival2014.json.zip
    
RUN wget -O $MRCNN_DIR/instances_valminusminival2014.json.zip https://dl.dropboxusercontent.com/s/s3tw5zcg7395368/instances_valminusminival2014.json.zip?dl=0 && \
    unzip $MRCNN_DIR/instances_valminusminival2014.json.zip -d $MRCNN_DIR/coco/annotations && \
    rm -rf $MRCNN_DIR/instances_valminusminival2014.json.zip

WORKDIR "/root"
CMD ["/bin/bash"]
