FROM ruby:2.7.4

ADD . /app
WORKDIR /app

RUN bundle install -j4
