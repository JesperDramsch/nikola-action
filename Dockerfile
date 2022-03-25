FROM python:3.10
RUN apt-get update && apt-get install -y --no-install-recommends \
		tidy optipng jpegoptim yui-compressor closure-compiler \
	&& rm -rf /var/lib/apt/lists/*
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
