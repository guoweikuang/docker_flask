FROM ubuntu

MAINTAINER guoweikuang2015@gmail.com

ADD sources.list /etc/apt/sources.list

RUN apt-get update -y \
    && apt-get install -y python-pip python-dev build-essential nginx curl net-tools vim wget
ADD requirements.txt requirements.txt 


RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip 
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt 


RUN mkdir -p /var/www 
COPY app.py /var/www/app.py 

WORKDIR /var/www 

EXPOSE 8080

CMD ["python", "app.py"]
