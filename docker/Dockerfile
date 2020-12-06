From ubuntu:20.04
env RUST_LOG=info
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
env WORKER_PATH=/root/lotusworker
env LOTUS_MINER_PATH=/root/lotusstorage
env FIL_PROOFS_PARAMETER_CACHE=/root/filecoin-proof-parameters
COPY sources.list /etc/apt/sources.list
RUN apt update && \
apt install -y net-tools mesa-opencl-icd ocl-icd-opencl-dev ubuntu-drivers-common libhwloc-dev hwloc openssl
COPY filecoin-ffi.yaml /etc/
WORKDIR /root
COPY lotus-worker /root/
COPY start.fg.sh /root/

ENTRYPOINT ["bash","/root/start.fg.sh"]
CMD ["ip","port"]
