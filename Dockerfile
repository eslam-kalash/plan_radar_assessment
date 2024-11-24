FROM ruby:3.2.3

ARG BUNDLER_VERSION

RUN apt-get update -qq \
&& apt-get install -y postgresql-client nodejs

ADD . /plan_radar

WORKDIR /plan_radar
RUN gem install bundler -v ${BUNDLER_VERSION}

COPY Gemfile* ./

WORKDIR /plan_radar
RUN bundle install
COPY . ./

# Use this to keep the app container running to allow for bootstrapping
CMD ["tail", "-f", "/dev/null"]