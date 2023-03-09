FROM amkisko/debian-rbenv-nodenv:latest

RUN apt-get -q update && apt-get -q -y install \
  poppler-utils imagemagick libpq-dev \
  libvips-dev tzdata wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get -q update && apt-get -q -y install \
  google-chrome-unstable fonts-ipafont-gothic \
  fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst \
  fonts-freefont-ttf

RUN rbenv install 3.2.0 -s

RUN nodenv install 17.3.1 -s
RUN nodenv local 17.3.1 && npm install -g yarn && nodenv rehash

CMD /bin/bash

