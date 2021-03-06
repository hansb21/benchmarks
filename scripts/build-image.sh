#
# MIT License
#
# Copyright (c) 2011-2018 Pedro Henrique Penna <pedrohenriquepenna@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED
# "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

BINDIR=$1

source "scripts/arch/mppa256.sh"

#
# Missing arguments.
#
if [ -z $BINDIR ] ;
then
	echo "missing argument: binary directory"
	exit 1
fi

build2 $BINDIR $BINDIR/mppa256-async-master "$BINDIR/mppa256-async-slave" benchmark-mppa256-async.img
build2 $BINDIR $BINDIR/mppa256-rqueue-master "$BINDIR/mppa256-rqueue-slave" benchmark-mppa256-rqueue.img
build2 $BINDIR $BINDIR/mppa256-portal-master "$BINDIR/mppa256-portal-slave" benchmark-mppa256-portal.img
build2 $BINDIR $BINDIR/mailbox-master "$BINDIR/mailbox-slave" benchmark-mailbox.img
build2 $BINDIR $BINDIR/rmem-master "$BINDIR/rmem-slave" benchmark-rmem.img
build2 $BINDIR $BINDIR/portal-master "$BINDIR/portal-slave" benchmark-portal.img
build2 $BINDIR $BINDIR/sync-master "$BINDIR/sync-slave" benchmark-sync.img
build2 $BINDIR $BINDIR/name-master "$BINDIR/name-slave" benchmark-name.img

