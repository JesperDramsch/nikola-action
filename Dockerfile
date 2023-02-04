FROM python:3.10

# Add filter processing tools
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
    jpegoptim \
    optipng \
    tidy \
    yui-compressor \
    closure-compiler \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
