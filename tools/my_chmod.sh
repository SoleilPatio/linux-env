#!/bin/bash
 
sudo find . -type d -exec chmod o-w {} \;
sudo find . -type f -exec chmod 664 {} \;

