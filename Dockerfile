FROM ruby:alpine

WORKDIR /app

COPY . .

RUN apk add --no-cache build-base ruby-dev libcurl && \
  gem install bundler && \
  bundle install && \
  ln -s bin/ua-tester.rb ua-tester && \
  ln -s bin/uactl.rb uactl

ENTRYPOINT ["ruby"]
CMD ["ua-tester"]
