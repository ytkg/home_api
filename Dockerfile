FROM ruby:2.7.2

ADD . /app
WORKDIR /app

RUN bundle install -j4
