FROM ruby:3.2.2-slim

ENV RAILS_ENV=${RAILS_ENV:-development} \
    RACK_ENV=${RACK_ENV:-development} \
    BUNDLE_WITHOUT="test:development"

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends \
    build-essential libpq-dev curl git \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock* ./
RUN bundle config set path 'vendor/bundle' \
 && bundle install

COPY . .

EXPOSE 3000

CMD ["bash","-lc","bundle exec rails s -b 0.0.0.0 -p 3000"]

