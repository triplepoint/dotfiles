#!/usr/bin/env bash
set -e

# see: https://www.cyberpowersystems.com/product/software/power-panel-personal/powerpanel-for-linux/, click download
install_deb              https://dl4jz3rbrsfum.cloudfront.net/software/PPL_64bit_v1.4.1.deb pwrstat
sudo pwrstat -alarm off
sudo pwrstat -hibernate off
sudo pwrstat -pwrfail -active on -delay 60 -cmd /etc/pwrstatd-powerfail.sh -duration 0 -shutdown off
sudo pwrstat -lowbatt -active on -runtime 300 -capacity 35 -cmd /etc/pwrstatd-lowbatt.sh -duration 0 -shutdown on
