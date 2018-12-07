#! /bin/sh

# Copyright (c) 2018 Slawomir Wojciech Wojtczak (vermaden)
# All rights reserved.
#
# THIS SOFTWARE USES FREEBSD LICENSE (ALSO KNOWN AS 2-CLAUSE BSD LICENSE)
# https://www.freebsd.org/copyright/freebsd-license.html
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS 'AS IS' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ------------------------------
# concat several PDF files with pdftk
# ------------------------------
# vermaden [AT] interia [DOT] pl
# https://vermaden.wordpress.com

if [ ${#} -eq 0 ]
then
  echo "usage: ${0##*/} FILE"
  exit 1
fi

if [ ! -f "${1}" ]
then
  echo "ERROR: No such file or directory '${1}'."
  exit 1
fi

NAME="ALL.pdf"
if [ -f "${NAME}" ]
then
  RANDOM=` expr $( ( ps aux ; time date +"%S" ; w ; last ) 2>&1 | cksum | awk '{print $1}' ) % 32768 `
  echo "WARNING: File 'ALL.pdf' already exists."
  echo "WARNING: Using 'ALL.${RANDOM}.pdf' instead."
  NAME="ALL.${RANDOM}.pdf"
fi

pdftk "${@}" cat output "${NAME}"

if [ ${?} -eq 0 ]
then
  echo "INFO: File '${NAME}' generated."
fi

echo '1' >> ~/scripts/stats/${0##*/}