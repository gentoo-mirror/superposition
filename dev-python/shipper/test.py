#!/usr/bin/env python 
# 
# shipper -- a tool for shipping software 
# 
# SPDX-License-Identifier: BSD-2-Clause 
# 
# Runs under both Python 2 and Python 3. Preserve this property! 
# from __future__ import print_function 

import sys, os, re, subprocess, time, glob, optparse, stat, email.utils, cgi, copy


