#===============================================================================
#
# File Name    : p03_renametempdirs.py
# Description  : Strip trailing random characters from humann temp dirs
# Usage        : python p03_renametempdirs.py parent/dir
# Author       : Aura Ferreiro, alferreiro@wustl.edu
# Version      : 1.0
# Created On   : 2022-10-27
# Last Modified: 2022-10-27
#===============================================================================

import os
import sys

parentdir = sys.argv[1]


tempdirs = next(os.walk(parentdir))[1]

for dir in tempdirs:
    oldir = parentdir+'/'+dir
    trimdir = dir.strip().split('temp')[0]
    newdir = parentdir+'/'+trimdir+'temp'
    os.rename(oldir, newdir)




