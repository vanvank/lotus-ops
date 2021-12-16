#!/usr/bin/env python3
import socket
from dingding import ding_msg
import logging


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

    LOG_FORMAT = "%(asctime)s - %(levelname)s - %(message)s"
    DATE_FORMAT = "%m/%d/%Y %H:%M:%S %p"
    logging.basicConfig(filename='nft_port_status.log', level=logging.DEBUG, format=LOG_FORMAT, datefmt=DATE_FORMAT)

    services = [
            ('172.28.XX.XX', 11100, 'back_end'),
            ('172.28.XX.XX',8777, 'web3_java'),
            ('172.28.XX.XX',8768,'web3_admin_java')
            ]
    msg = []
    is_send = False
    for s in services:
        result = check_port_status(s[0],s[1])
        #print("%s : %s " %(s[2],result))
        data = "%s port : %s " %(s[2],result)
        msg.append(data )
        if result == 'close':
            logging.critical(data)
            is_send = True
        if result == 'open':
            logging.info(data)

    if is_send:
        ding_msg("xmall" + "\n".join(msg))
        logging.critcal("dingding message is sent !!!")
