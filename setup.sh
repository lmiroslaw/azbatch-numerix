#!/bin/bash

python --version

cd $AZ_BATCH_NODE_SHARED_DIR
LICFILE=Numerix.license.nxcfg
if [ -f "$LICFILE" ]; then
    echo "$LICFILE exist. Skipping download."
else 
    echo "$LICFILE does not exist. Downloading ..."
	wget https://numerixstch.blob.core.windows.net/numerix/Numerix.license.nxcfg
fi

NUMFILE=Numerix_SDK.tar.gz
if [ -f "$NUMFILE" ]; then
    echo "$NUMFILE exist. Skipping download."
else 
    echo "$NUMFILE does not exist. Downloading ..."
	wget https://numerixstch.blob.core.windows.net/numerix/Numerix_SDK.tar.gz
	tar xzvf Numerix_SDK.tar.gz
fi

sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y python36u python36u-libs python36u-devel python36u-pip

#Test conda
#/anaconda/envs/py35/bin/conda update -n base conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $AZ_BATCH_NODE_SHARED_DIR/miniconda
which conda

/anaconda/envs/py35/bin/conda create --prefix $AZ_BATCH_NODE_SHARED_DIR/t1 python=3.6 -y
source /anaconda/envs/py35/bin/activate $AZ_BATCH_NODE_SHARED_DIR/t1

path_to_license=$(pwd)
license_file=${path_to_license}/Numerix.license.nxcfg

export PYTHONPATH=${PYTHONPATH}:${path_to_license}/NumeriX_Python36_15_6_1
echo 'NX_LICENSE_DIR='$NX_LICENSE_DIR
echo 'USER='$USER

#Set licensing 
export NX_LICENSE_DIR=${path_to_license}
path_to_nxlm=${path_to_license}/NumeriX_Python36_15_6_1/bin

#Otherwise the user does not have enough privilliges
sudo chown _azbatch NumeriX_Python36_15_6_1
sudo chown _azbatch ${path_to_license}/Numerix.license.nxcfg

#Otherwise the nxlm is not executable
sudo chmod +x ${path_to_nxlm}/nxlm

#install for all the users
#sudo pip3.6 install NumeriX_Python36_15_6_1/dist/nxpy-15.6.1-cp36-cp36m-linux_x86_64.whl 
sudo pip3.6 install NumeriX_Python36_15_6_1/dist/nxpy-15.6.1-cp36-cp36m-linux_x86_64.whl 

#Installing in the job
#sudo ${path_to_nxlm}/nxlm --install ${license_file}

#Conda was not visible for _azbatch user 
#Problem with virtual environment due to lacking access to venv directory by _azbatch user 



#conda activate nxenv

echo 'PATH:' $PATH
echo 'PYTHONPATH:' $PYTHONPATH

python3 -c 'import sys,pprint; pprint.pprint(sys.path)'
#python3 -c 'from nxpy import nxpropy as nx'

 

