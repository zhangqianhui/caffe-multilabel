#!/usr/bin/env sh
# Create the fine_gender lmdb inputs
# N.B. set the path to the imagenet train + val data dirs
set -e

EXAMPLE=examples/gender_glasses
DATA=data/new_data_gender
TOOLS=build/tools
LABEL_NUM='2'

TRAIN_DATA_ROOT=/home/jaychou/code/new_caffe/caffe-master/data/gender_glasses/data/train/
VAL_DATA_ROOT=/home/jaychou/code/new_caffe/caffe-master/data/gender_glasses/data/test/

# Set RESIZE=true to resize the images to 256x256. Leave as false if images have
# already been resized using another tool.
RESIZE=true
if $RESIZE; then
  RESIZE_HEIGHT=80
  RESIZE_WIDTH=80
else
  RESIZE_HEIGHT=0
  RESIZE_WIDTH=0
fi

if [ ! -d "$TRAIN_DATA_ROOT" ]; then
  echo "Error: TRAIN_DATA_ROOT is not a path to a directory: $TRAIN_DATA_ROOT"
  echo "Set the TRAIN_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the ImageNet training data is stored."
  exit 1
fi

if [ ! -d "$VAL_DATA_ROOT" ]; then
  echo "Error: VAL_DATA_ROOT is not a path to a directory: $VAL_DATA_ROOT"
  echo "Set the VAL_DATA_ROOT variable in create_imagenet.sh to the path" \
       "where the ImageNet validation data is stored."
  exit 1
fi

echo "Creating train lmdb..."



GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    --shuffle=true \
    $TRAIN_DATA_ROOT \
    $TRAIN_DATA_ROOT/train.txt \
    $EXAMPLE/gender_glasses_train_lmdb \
    $EXAMPLE/gender_glasses_train_label_lmdb \
    $LABEL_NUM
    

echo "Creating val lmdb..."

GLOG_logtostderr=1 $TOOLS/convert_imageset \
    --resize_height=$RESIZE_HEIGHT \
    --resize_width=$RESIZE_WIDTH \
    --shuffle=true \
    $VAL_DATA_ROOT \
    $VAL_DATA_ROOT/test.txt \
    $EXAMPLE/gender_glasses_val_lmdb \
    $EXAMPLE/gender_glasses_val_label_lmdb \
    $LABEL_NUM
echo "Done."
