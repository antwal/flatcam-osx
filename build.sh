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
# Upgrade PIP
python -m pip install --upgrade pip
# Install all Python dependencies in the virtual environment
pip3 install numpy matplotlib rtree scipy shapely simplejson lxml rasterio ezdxf svg.path freetype-py fontTools ortools vispy PyOpenGL PyQT5
# Test
ls -al ./env/bin
# Get out of the virtual environment
deactivate

# cd ..

# Copy a script to execute FlatCAM
echo "Copy Execute Script"
cp ../FlatCam ./FlatCAM_beta_8.993_sources/

# Copy the AppleScript
echo "Copy Compile Script"
cp ../FlatCAM.scpt ./FlatCAM_beta_8.993_sources/

# Compile the AppleScript into an application
echo "Build..."
osacompile -o ../FlatCAM-${OS_NAME}-${OS_VERSION}.app ./FlatCAM.scpt

# Test End
echo "Test end"
ls -al

ls -al ../
