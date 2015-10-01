#!/bin/bash
sudo find . -exec chgrp sudo {} \;
sudo find . -exec chmod g+w {} \;

