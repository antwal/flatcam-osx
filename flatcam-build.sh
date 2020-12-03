#!/bin/bash

#set -e

# Install FlatCAM depencencies Python3, PyQT5, gets and spatialindex
brew install python pyqt geos spatialindex

# Install Python 3's virtualenv. This is useful not to pollute our global libraries directory
pip3 install virtualenv

# Download Source Code
wget https://bitbucket.org/jpcgt/flatcam/downloads/FlatCAM_beta_8.993_sources.zip
# Unarchive the files
unzip FlatCAM_beta_8.993_sources.zip
# Change to the FlatCAM directory
cd FlatCAM_beta_8.993_sources

# Create a Python virtual environment
virtualenv env
# Activate the virtual environment
source env/bin/activate
# Install all Python dependencies in the virtual environment
pip3 install numpy matplotlib rtree scipy shapely simplejson lxml rasterio ezdxf svg.path freetype-py fontTools ortools vispy PyOpenGL PyQT5
# Get out of the virtual environment
deactivate

cd ..

# Copy a script to execute FlatCAM
cp ./FlatCam ./FlatCAM_beta_8.993_sources/

# Copy the AppleScript
cp ./FlatCAM.scpt ./FlatCAM_beta_8.993_sources/

# Compile the AppleScript into an application
osacompile -o ./FlatCAM-${OS_NAME}-${OS_VERSION}.app ./FlatCAM_beta_8.993_sources/FlatCAM.scpt



