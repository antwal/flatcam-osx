#!/bin/bash

#set -e

if [[ $OS_VERSION == '10.12' ]]; then

  brew install python3

  # Install FlatCAM depencencies Python3, PyQT5, gets and spatialindex
  brew install pyqt geos spatialindex

  # Install Python 3's virtualenv. This is useful not to pollute our global libraries directory
  pip3 install virtualenv

else

  # Install FlatCAM depencencies Python3, PyQT5, gets and spatialindex
  brew install python pyqt geos spatialindex

  # Upgrade PIP
  python -m pip install --upgrade pip

  # Install Python 3's virtualenv. This is useful not to pollute our global libraries directory
  pip3 install virtualenv

  # Install all Python dependencies in the virtual environment
  pip3 install numpy matplotlib rtree scipy shapely simplejson lxml rasterio ezdxf svg.path freetype-py fontTools ortools vispy PyOpenGL PyQT5

fi

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
# Test Python Version
ls -al ./evn/bin
python -V
pip3 -V
# Get out of the virtual environment
deactivate

# Copy a script to execute FlatCAM
echo "Copy Execute Script"
cp ../FlatCam ./

# Copy the AppleScript
echo "Copy Compile Script"
cp ../FlatCAM.scpt ./

# Compile the AppleScript into an application
echo "Build..."
osacompile -o FlatCAM.app FlatCAM.scpt

# End Build
cd ..

mv ./FlatCAM_beta_8.993_sources ./FlatCAM_beta_8.993-${OS_VERSION}

# zip folder
