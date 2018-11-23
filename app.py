# -*- coding: utf-8 -*-
import time
from flask import Flask
from flask import request
import random

app = Flask(__name__)


@app.route('/')
def index():
    print(request.remote_addr)
    print(request.headers)
    return 'Hello, world, docker flask'


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
