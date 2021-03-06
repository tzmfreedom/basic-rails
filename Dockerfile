FROM ruby:2.5.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential nodejs vim mysql-client
RUN mkdir /myapp
WORKDIR /myapp
RUN mkdir /root/docker-scripts
ADD .docker-scripts /root/docker-scripts
RUN chmod -R 755 /root/docker-scripts
CMD ["/root/docker-scripts/server.sh"]
