#!/bin/bash

set -e

# Install FlatCAM depencencies Python3, PyQT5, gets and spatialindex
brew install python pyqt geos spatialindex

# Install Python 3's virtualenv. This is useful not to pollute our global libraries directory
pip3 install virtualenv

# Download Source Code
git clone https://antwal@bitbucket.org/jpcgt/flatcam.git

cd flatcam

# Create a Python virtual environment
virtualenv env
# Activate the virtual environment
source env/bin/activate
# Install all Python dependencies in the virtual environment
pip3 install numpy matplotlib rtree scipy shapely simplejson lxml rasterio ezdxf svg.path freetype-py fontTools ortools vispy PyOpenGL PyQT5
# Get out of the virtual environment
deactivate

# Create a script to execute FlatCAM
cat <<'EOF' > FlatCAM
#!/bin/bash

# Make sure the Homebrew executable paths are in the PATH env variable
export PATH='/usr/local/bin:/usr/local/sbin:'"$PATH"

# Find the script's real path
script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if real_script_path="$( readlink "$script_directory/$( basename "$0" )" )"
then
    real_script_directory="$( dirname "$real_script_path" )"
else
    # shellcheck disable=SC2034
    real_script_directory="$script_directory"
fi

exit_code=0

# Enable FlatCAM's virtual env
source "$script_directory"'/env/bin/activate'
# Execute FlatCAM, log the output to FlatCAM.log
python3 "$script_directory"'/FlatCAM.py' &> "$script_directory"'/FlatCAM.log'
# Capture the exit code
exit_code="$?"
# Disable the virtual env
deactivate
# Exit the script with the exit code returned by FlatCAM
exit "$exit_code"

EOF

# Create an AppleScript to execute the script we just created
cat <<'EOF' > FlatCAM.scpt
    set script_path to POSIX path of ((path to me as text) & "::") & "FlatCAM"
    do shell script script_path
EOF

# Compile the AppleScript into an application
osacompile -o FlatCAM-${OS_NAME}-${OS_VERSION}.app FlatCAM.scpt



