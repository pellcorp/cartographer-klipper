#!/bin/sh

# Based upon the fantastic Beacon eddy current scanner support
# Copyright (C) 2020-2023 Matt Baker <baker.matt.j@gmail.com>
# Copyright (C) 2020-2023 Lasse Dalegaard <dalegaard@gmail.com>
# Copyright (C) 2023 Beacon <beacon3d.com>
# This file may be distributed under the terms of the GNU GPLv3 license.

PYTHON_EXEC="$KENV/bin/python"

BKDIR=/usr/data/cartographer-klipper

if [ -d "/usr/share/klipper" ] && [ -d "/usr/share/klippy-env" ]; then
  KDIR="/usr/share/klipper"
  KENV="/usr/share/klippy-env"
elif [ -d "/usr/data/klipper" ] && [ -d "/usr/data/klippy-venv" ]; then
  KDIR="/usr/data/klipper"
  KENV="/usr/data/klippy-venv"
else
  echo "Cartographer: klipper or klippy env doesn't exist"
  exit 1
fi

# update link to cartographer.py & idm.py
echo "Cartographer: linking modules into klipper"
for file in cartographer.py; do
    if [ -e "${KDIR}/klippy/extras/${file}" ]; then
        rm "${KDIR}/klippy/extras/${file}"
    fi
    ln -s "${BKDIR}/${file}" "${KDIR}/klippy/extras/${file}"
    if ! grep -q "klippy/extras/${file}" "${KDIR}/.git/info/exclude"; then
        echo "klippy/extras/${file}" >> "${KDIR}/.git/info/exclude"
    fi
done

echo "Cartographer Probe: installation successful."
