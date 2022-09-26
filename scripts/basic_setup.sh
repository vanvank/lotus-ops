## 基础环境准备(加跳板机)：
apt update  && \ 
apt install python vim curl wget ca-certificates -y  && \
echo "export EDITOR=vim" >> /etc/profile && \
curl https://gitee.com/vanvank/lotus-ops/raw/master/scripts/add_to_jump.sh  | bash  && \
echo "done!"


## curl https://raw.githubusercontent.com/vanvank/lotus-ops/master/scripts/add_to_jump.sh | bash 
## curl https://gitee.com/vanvank/lotus-ops/raw/master/scripts/add_to_jump.sh  | bash 


## java环境搭建
mkdir /usr/lib/jvm
cd /usr/lib/jvm/
wget http://cdn.wanzhicheng.cn/jdk-8u221-linux-x64.tar.gz
tar -zxvf jdk-8u221-linux-x64.tar.gz
rm jdk-8u221-linux-x64.tar.gz
echo "export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_221" >>  /etc/profile
echo "export JRE_HOME=\${JAVA_HOME}/jre" >>  /etc/profile
echo "export CLASSPATH=\${JAVA_HOME}/lib:\${JRE_HOME}/lib" >>  /etc/profile
echo "export PATH=\${JAVA_HOME}/bin:\$PATH" >>  /etc/profile
source /etc/profile
java -version

## jumpserver上配置root管理，推送houduan等用户
## jenkins 公钥添加到hoduuan等用户的文件中


## docker环境搭建 ubuntu 20.04
sudo apt-get remove docker docker-engine docker.io containerd runc 
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
