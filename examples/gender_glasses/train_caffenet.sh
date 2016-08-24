#!/usr/bin/env sh
set -e
GLOG_logtostderr=0 GLOG_log_dir=log/gender_glasses/ \
./build/tools/caffe train \
    --solver=models/gender_glasses/solver.prototxt $@
