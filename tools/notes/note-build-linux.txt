#!bin/sh
source build/envsetup.sh
source ./mbldenv.sh
lunch full_evb6735m_64-userdebug
lunch full_k35mv1_64-userdebug

export PATH=$PWD/../prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PWD/../prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin:$PATH


mosesq ARCH=arm64 make evb6735_64_debug_defconfig O=out #D1
mosesq ARCH=arm64 make k35v1_64_debug_defconfig O=out #D1

mosesq ARCH=arm64 make evb6735m_64_debug_defconfig  O=out #D2
mosesq ARCH=arm64 make k35mv1_64_defconfig O=out #D2

mosesq ARCH=arm64 make evb6753_64_debug_defconfig O=out #D3 



mosesq ARCH=arm64 make -k  O=out 2>&1 |tee build.log
