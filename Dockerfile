# Specify platform if needed
FROM --platform=linux/arm64 jekyll/jekyll:latest AS build

WORKDIR /srv/jekyll

# Copy all files to the container
ADD . /srv/jekyll

# Install Bundler and gems, including webrick
RUN gem install bundler && \
    chmod -R 777 ${PWD} && \
    bundle install

# Optional argument to pass custom build commands
ARG build_command="jekyll serve --host 0.0.0.0 --livereload --drafts --trace"
ENV BUILD_COMMAND=${build_command}

# Default to serve command if none provided
CMD ${BUILD_COMMAND}

# Expose Jekyll default port
EXPOSE 4000

