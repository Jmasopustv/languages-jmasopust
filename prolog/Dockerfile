FROM swipl:stable

RUN mkdir -p /app && chown $USER:$USER /app
WORKDIR /app
EXPOSE 8000

ENTRYPOINT ["/bin/bash","-i","-c","\"$@\"","--"]
