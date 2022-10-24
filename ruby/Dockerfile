FROM ruby:3
ENV LANG C.UTF-8

RUN mkdir -p /app && chown $USER:$USER /app

RUN echo  export PATH='"'/app/bin:/app/bin/$(uname -s)-$(uname -m):/app/node_modules/.bin:/app:'${PATH}''"' >> $HOME/.bashrc

WORKDIR /app
EXPOSE 8000

ENTRYPOINT ["/bin/bash","-i","-c","\"$@\"","--"]
