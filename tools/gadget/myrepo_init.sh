#!bin/sh

#[branch]
#alps-trunk-m0.basic
#alps-trunk-m0.bsp
#alps-trunk-m0.tk

#[platform:latest code/upload]
repomtk init -u http://gerrit.mediatek.inc:8080/alps/platform/manifest -b alps-trunk-m0.tk -m manifest-hq.xml


#[build:specific reversion/]
repomtk init -u http://gerrit.mediatek.inc:8080/alps/build/manifest -b alps-trunk-m0.tk -m 2015_09_23_12_00-hq.xml

#[Hook before sync and after init]
ln -s /mtkoss/git/hooks/wsd/prepare-commit-msg .repo/repo/hooks/


#[Sync]
repomtk sync -q -j8 
repomtk sync -q -j8 kernel-3.18
#repomtk sync -d -q -j8 kernel-3.18   #danger!!


#[submit process]
#0.modify code at build/manifest
#1.commit at build/manifest
#2.repo re-init to platform/manifest
#3.repo sync -q --j8 rebase to latest code
#4.repo upload

#[daily build tag]
git clone http://gerrit.mediatek.inc:8080/alps/build/manifest manifest_build

#[30mins download]
#/mtkoss/git/mtk_sc list
#/mtkoss/git/mtk_sc init –v alps-trunk-m0.tk-of.p32
#export OUT_DIR=out_k80hd_eng
#source build/envsetup.sh
#lunch full_k80hd_eng
#mosesq make -j24 -k 2>&1 | tee log.txt
