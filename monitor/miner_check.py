import re
import time
import socket
import urllib.request
from send_mail import send_email


def check_faults(miner_id):

    hosturl = baseurl + miner_id
    has_faults = 'no'
    try:
        response = urllib.request.urlopen(hosturl, timeout=10)
        html = response.read().decode('utf-8')
        pattern = re.compile(r'<span class=" text-red-700"> (.*?) 错误, </span>', re.S)
        data = re.findall(pattern, html)
        data = data[0].replace(',', '')  # 去掉数字中的逗号
        faults = int(data)
        if faults > 0:
            has_faults = 'yes'
            msg = "%s 掉算力了,错误扇区数为: %s" % (miner_id, faults)
        elif faults == 0:
            msg = '%s 没掉算力' % miner_id
    except socket.timeout as e:
        time.sleep(300)
    return has_faults, msg


def write_file(file_name):
    with open(file_name, 'w') as f:
        f.write('no')


def read_file(file_name):
    with open(file_name, 'r') as f:
        return f.read()


def make_content(list):
    content = ''
    for i in list:
        content = content + i + '</br>'
    print(content)
    return content



def main():

    for miner_id in miner_id_list:
        result = check_faults(miner_id)
        if result[0] == 'yes':
            is_send_msg = 'yes'
        msg_list.append(result[1])
        if miner_id == miner_id_list[-1]:
            print('所有miner检查完毕!')
            if is_send_msg == 'yes':
                send_email(make_content(msg_list), ['165584943@qq.com'], '掉算力了')
                print('send message')
                write_file(file_name)
            else:
                print('no need to send message')
            break
        else:
            time.sleep(30)  # 为了防止filfox封ip，不要频繁访问


def is_send_mail(file_name):
    content = read_file(file_name)
    if content == 'no':
        print("不发邮件")
        return False
    elif content == 'yes':
        return True


if __name__ == '__main__':
    #make_content(["a","b","c"])
    baseurl = 'https://filfox.info/zh/address/'
    miner_id_list = ['f0726270', 'f03364', 'f0145503', 'f0870189']
    msg_list = []
    is_send_msg = 'no'
    file_name = './need_check.txt'
    if not is_send_mail(file_name):
        exit(0)
    else:
        main()
    #send_email(make_content(msg_list), ['165584943@qq.com'], '掉算力了')



