# https://docs.docker.com/compose/rails/

FROM ruby:2.6.5

RUN apt-get clean all && apt-get update -qq && apt-get install -y build-essential libpq-dev \
    curl gnupg2 apt-utils default-libmysqlclient-dev git libcurl3-dev cmake \
    libssl-dev pkg-config openssl imagemagick file nodejs yarn

RUN mkdir /just-cars-api
WORKDIR /just-cars-api
COPY Gemfile /just-cars-api/Gemfile
COPY Gemfile.lock /just-cars-api/Gemfile.lock
RUN bundle install
COPY . /just-cars-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
