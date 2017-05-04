#!/bin/sh

if [ -r /etc/default/locale ]; then
  . /etc/default/locale
  export LANG LANGUAGE
fi

xfce4-session
. /etc/X11/Xsession
