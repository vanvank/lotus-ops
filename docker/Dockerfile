From ubuntu:20.04
env RUST_LOG=info
env WORKER_PATH=/root/lotusworker
env LOTUS_MINER_PATH=/root/lotusstorage
env FIL_PROOFS_PARAMETER_CACHE=/root/filecoin-proof-parameters
RUN apt update && \
apt install -y net-tools mesa-opencl-icd ocl-icd-opencl-dev ntpdate ubuntu-drivers-common libhwloc-dev hwloc
RUN apt install -y openssl
COPY filecoin-ffi.yaml /etc/
WORKDIR /root
COPY lotus-worker /root/
COPY start.fg.sh /root/

ENTRYPOINT ["/root/start.fg.sh"]
CMD ["ip","port"]
