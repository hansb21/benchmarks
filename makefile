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

#===============================================================================
# Directories
#===============================================================================

# Directories.
export BINDIR  = $(CURDIR)/bin
export INCDIR  = $(CURDIR)/include
export LIBDIR  = $(CURDIR)/lib
export MAKEDIR = $(CURDIR)/build
export SRCDIR  = $(CURDIR)/src
export TOOLSDIR = $(CURDIR)/scripts

#===============================================================================

# Builds everything.
all: image

# Builds image.
image: hello-world
	bash $(TOOLSDIR)/build-image.sh $(BINDIR)

# Builds binaries.
hello-world:
ifeq ($(TARGET),mppa256)
	cd $(SRCDIR) && $(MAKE) all ARCH=k1bdp
	cd $(SRCDIR) && $(MAKE) all ARCH=k1bio
endif

# Cleans everything.
clean:
	rm -rf *.img
ifeq ($(TARGET),mppa256)
	cd $(SRCDIR) && $(MAKE) clean ARCH=k1bdp
	cd $(SRCDIR) && $(MAKE) clean ARCH=k1bio
endif

