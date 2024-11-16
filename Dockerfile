FROM --platform=linux/arm64 ruby:3.2

WORKDIR /srv/jekyll

# Install dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev

# Update RubyGems and install the latest versions of bundler and Jekyll
RUN gem update --system && \
    gem install bundler && \
    gem install jekyll webrick

# Copy project files
ADD . /srv/jekyll

# Install project dependencies
RUN bundle install

# Set the command to run Jekyll
CMD ["jekyll", "serve", "--host", "0.0.0.0"]

# Expose Jekyll default port
EXPOSE 4000
