# install deps
sudo apt update && \
sudo apt install mesa-opencl-icd ocl-icd-opencl-dev clang -y && \
##  sudo add-apt-repository ppa:longsleep/golang-backports -y && \
sudo apt update && \
##  sudo apt install curl golang-go gcc git bzr jq pkg-config  -y && \
sudo apt install curl  gcc make git bzr jq pkg-config libhwloc-dev hwloc -y && \
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
source $HOME/.cargo/env
source /etc/profile
