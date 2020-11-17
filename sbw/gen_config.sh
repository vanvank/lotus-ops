#!/usr/bin/env python3
#remote_ip="113.125.194.17"
#remote_port=["59062","59060"]
remote_ip=input("请输入远程ip：")
remote_port=["a","b"]
remote_port[0]=input("请输入第一个port：")
remote_port[1]=input("请输入第二个port：")


def gen_config(ip,port,filename):
    with open(filename,'w') as f:
        f.writelines("""---
servers:
    - url: "http://%s:%s/"  # Server url
    #cert: "/home/xl/sbw1023/cert.pem"
      token: ""  # Keep empty""" %(ip,port))

if __name__=="__main__":
    gen_config(remote_ip, remote_port[0],"/etc/filecoin-ffi.yaml")
    gen_config(remote_ip, remote_port[1],"/etc/filecoin-ffi2.yaml")
    print("config生成成功")
