FROM ubuntu:latest
RUN sudo apt-get update \
USER root
ENV WORKPATH="/workspace"
ENV DEVICE="cuda:0"
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' > /etc/timezone

# 创建工作目录    
RUN sudo mkdir -p ${WORKPATH}

# 将当前路径的文件复制到容器内对应的目录下
COPY ./ ${WORKPATH}

# 切换到工作目录
WORKDIR ${WORKPATH}

# 进入服务代码所在的路径    
WORKDIR ${WORKPATH}/service
# 通过gunicorn启动服务
CMD gunicorn -c gunicorn.conf.py --log-config log.conf app:app
