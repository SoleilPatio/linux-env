#!/bin/bash

#export LNX=./kernel-3.10 #default
export LNX=./kernel-3.18

vs_genfiles_mtkandroid.sh
vs_filter_mtkplatform.sh mt6735 mt6735m mt6753
vs_rebuild.sh

