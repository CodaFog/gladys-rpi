FROM hypriot/rpi-node:argon

# Create src folder
RUN mkdir /src && git clone --depth 1 git://github.com/GladysProject/Gladys /src

WORKDIR /src
#ADD . /src
RUN npm install && npm install -g grunt-cli && npm install -g grunt-cli && grunt buildProd

#RUN npm install -g grunt-cli
#RUN grunt buildProd

# Export listening port
EXPOSE 8080

CMD ["node" ,"app.js"]
