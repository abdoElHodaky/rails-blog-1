FROM ruby:2-alpine3.15
WORKDIR /app
COPY . .
RUN apk add --no-cache build-base tzdata nodejs npm yarn sqlite-dev postgresql-dev mysql-dev
RUN gem install bundler
RUN bundle install
RUN bundle update --all
ENV RAILS_ENV=development
ENV SECRET_KEY_BASE=40ffa74d9a25fe77a64a11328a24f6e28510132cd9a1605efe5d54f27eacce3c529679ace0bfedac36caf38d4f403a4a831b3b548bc2b3b7cc6a92026ee4c551
RUN rake db:load_config && rake db:migrate
RUN rake db:seed
RUN bundle exec rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
