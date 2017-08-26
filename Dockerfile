FROM ruby:2.4.1
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir /myapp
ADD Gemfile Gemfile.lock /myapp/
WORKDIR /myapp
RUN bundle install -j4
ADD . /myapp
