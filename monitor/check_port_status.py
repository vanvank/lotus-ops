#!/usr/bin/env python3
import socket


def check_port_status(host,port):
    sk = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sk.settimeout(3)
    try:
        sk.connect((host, port))
        return "open"
    except Exception:
        return "close"
    sk.close()
