#!/usr/bin/env sh
# Compute the mean image from the imagenet training lmdb
# N.B. this is available in data/ilsvrc12

EXAMPLE=examples/gender_glasses
DATA=data/gender_glasses
TOOLS=build/tools

$TOOLS/compute_image_mean $EXAMPLE/gender_glasses_train_lmdb \
  $DATA/gg_mean.binaryproto

echo "Done."
