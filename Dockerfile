FROM daocloud.io/python:3.6-alpine

MAINTAINER guoweikuang2015@gmail.com

LABEL maintainer="weikuang.guo" \
      io.daocloud.dce.plugin.name="Flaskweb" \
      io.daocloud.dce.plugin.description="Flaskweb 是 kubernetes 包管理器，为 DCE 提供生成应用模板的功能" \
      io.daocloud.dce.plugin.categories="container-tool" \
      io.daocloud.dce.plugin.vendor="DaoCloud" \
      io.daocloud.dce.plugin.required-dce-version=">=2.10.0" \
      io.daocloud.dce.plugin.nano-cpus-limit="500000000" \
      io.daocloud.dce.plugin.memory-bytes-limit="524288000" \
      io.daocloud.dce.plugin.rules="[{'apiGroups': [''], 'resources': ['secrets', 'apps'], 'verbs': ['get','watch', 'list']}, {'apiGroups': [''], 'resources': ['staticip', 'nodes', 'persistentvolumes'], 'verbs': ['get', 'list', 'update', 'patch', 'create', 'delete']}]"

ADD sources.list /etc/apt/sources.list

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --update nginx python-dev build-base ca-certificates openssl libffi-dev openssl-dev curl gcc \
    linux-headers musl-dev \
  && rm -rf /var/cache/apk/* \
  && ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

ADD plugin.json /usr/share/nginx/html/
ADD requirements.txt requirements.txt


RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

RUN mkdir -p /var/www
COPY app.py /var/www/app.py

WORKDIR /var/www

EXPOSE 5000

CMD ["python", "app.py"]
