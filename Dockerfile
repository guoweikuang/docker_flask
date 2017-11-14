FROM ubuntu

MAINTAINER guoweikuang2015@gmail.com


RUN apt-get update -y \
    && apt-get install -y python-pip python-dev build-essential
ADD requirements.txt requirements.txt 


RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip 
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt 


RUN mkdir -p /var/www 
COPY app.py /var/www/app.py 

WORKDIR /var/www 

EXPOSE 1

CMD ["python", "app.py"]
