#[git] get reversion
repomtk rebase; repomtk forall -c "git checkout -B cls_met -f t-alps-trunk-m0.bsp-db.2015_07_10_13_30"


#!/bin/bash
source build/envsetup.sh
source ./mbldenv.sh

#K2
lunch full_k2v1_64_op01-userdebug #for k2

#D1
lunch full_evb6735_64-userdebug

#D2
#lunch full_evb6735m_64-userdebug 
lunch full_k35mv1_64-userdebug
#D2 M0 3.18
lunch full_k35mv1_bsp-userdebug


#D3
lunch full_evb6753_64-userdebug
lunch full_k53v1_64_op02-userdebug

#l318
lunch full_k35v1_64_op02_ks-userdebug 
lunch full_k35v1_64_l318-userdebug

#Jade
lunch full_evb6755_64-eng
lunch full_evb6755_64-userdebug
lunch full_k55v1_64_op01_teldev-userdebug 

mosesq make -j24 2>&1 | tee build.log

