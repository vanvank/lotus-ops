import urllib.request
import json


def pachong():
    data = urllib.parse.urlencode({'spam': 1})
    data = data.encode('ascii')
    response = urllib.request.urlopen("https://fgas.io/getFil", data)
    html = response.read().decode('utf-8')
    html_list = eval(html)
    html_dict = html_list[0]
    js = json.dumps(html_dict)
    return js


if __name__ == "__main__":
    print(pachong())
