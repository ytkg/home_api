FROM ruby:3.1.1

ADD . /app
WORKDIR /app

RUN bundle install -j4
