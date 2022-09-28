import socket
import time
import os


def check_port_status(host,port):
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.settimeout(3)
    try:
        sk.connect((host, port))
        return "open"
    except Exception:
        return "close"
    sk.close()


if __name__ == '__main__':

    services = [
            ('192.168.7.11', 9000, 'jumpserver'),
            ]
    msg = []
    connection = False
    while not connection:
        for s in services:
            result = check_port_status(s[0],s[1])
            print("%s : %s " %(s[2],result))
            if result == "open":
                connection = True
            else:
                time.sleep(60)
    os.system('190204084208765161.mp4')
