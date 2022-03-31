FROM ruby:2.7.5-alpine
WORKDIR /app
COPY . .
RUN apk add --no-cache build-base tzdata nodejs npm yarn sqlite-dev postgresql-dev mysql-dev
RUN gem install bundler
RUN bundle install
RUN bundle update --all
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
