FROM ruby:2-alpine3.15
WORKDIR /app
COPY . .
RUN apk add --no-cache build-base tzdata nodejs npm yarn sqlite-dev postgresql-dev mysql-dev python2 python3 clang
RUN rm package-lock.json && yarn upgrade && yarn add global node-gyp
RUN gem install bundler
RUN bundle update --all
ENV RAILS_ENV=development
ENV SECRET_KEY_BASE=16f8953ec6c4c1190dd3f498a8b8df6c148e6f21301a52c3e02ea20784a47f86b3d2e451b5446ad7337196ae2a7d37656bc144e6a1442bfb510c5d3d1d00977f
RUN rake db:load_config && rake db:migrate
RUN rake db:seed
RUN bundle exec rails assets:precompile
EXPOSE 3000
CMD ["rails", "s"]
