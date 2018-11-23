# -*- coding: utf-8 -*-
import time
from flask import Flask
import random

app = Flask(__name__)


from kubernetes import client, config
import kubernetes


def main():
    # Configs can be set in Configuration class directly or using helper
    # utility. If no argument provided, the config will be loaded from
    # default location.
    #config.load_kube_config()
    config = kubernetes.client.Configuration()
    config.host = 'https://10.6.125.6:16443'
    config.verify_ssl = False
    
    v1 = client.CoreV1Api(configuration=config)
    print("Listing pods with their IPs:")
    ret = v1.list_pod_for_all_namespaces(watch=False)
    for i in ret.items:
        print("%s\t%s\t%s" %
              (i.status.pod_ip, i.metadata.namespace, i.metadata.name))

@app.route('/')
def index():
    time.sleep(random.randint(0, 4))
    # main()
    return 'Hello, world, docker flask'


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
