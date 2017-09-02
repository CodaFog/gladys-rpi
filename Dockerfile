FROM hypriot/rpi-node:argon
ENV QEMU_EXECVE 1
COPY armv7hf-debian-qemu /usr/bin

RUN [ "cross-build-start" ]
# Create src folder
RUN mkdir /src && git clone --depth 1 git://github.com/GladysProject/Gladys /src

WORKDIR /src
#ADD . /src
RUN npm install
RUN npm install -g grunt-cli
RUN grunt buildProd

# Export listening port
EXPOSE 8080

CMD ["node" ,"app.js"]
RUN [ "cross-build-end" ]
