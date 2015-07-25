#!/bin/bash

find $AND -path "$AND/kernel-*/*" -prune -o -path "$AND/out/*" -prune -o \
          -path "$AND/prebuilts/*" -prune -o -path "$AND/tools/*" -prune -o \
          -path "$AND/development/*" -prune -o -path "$AND/ndk/*" -prune -o \
          -path "$AND/sdk/*" -prune -o -path "$AND/docs/*" -prune -o -path "$AND/native-toolchain/*" -prune -o  \
          -path "./HTML*" -prune -o \
          -path "$AND/external/*" -prune -o -path "$AND/cts/*" -prune -o -path "$AND/developers/*" -prune -o \
          -iname "*.aidl" -print -o \
          -iname "*.cc"   -print -o -iname "*.h"  -print -o -iname "*.c" -print -o -iname "*.cpp" -print -o \
          -iname "*.java" -print -o -iname "*.mk" -print -o \
          -iname "*.cxx"  -print -o -iname "*.hpp" -print >> cscope.files
