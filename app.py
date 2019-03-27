# -*- coding: utf-8 -*-
import time
from flask import Flask
from flask import request
import random
import psutil

app = Flask(__name__)


@app.route('/')
def index():
    print("hello, world")
    return 'Hello, world, docker guoweikuang'

@app.route('/disk/<path:int>')
def disk_usage(path):
    usage = psutil.disk_usage(path)
    print(usage)


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
