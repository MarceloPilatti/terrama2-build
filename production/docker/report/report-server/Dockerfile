FROM node:12

WORKDIR /app

RUN git clone -b b1.0.0 -o upstream https://github.com/TerraMA2/terrama2-report-server.git . && \
    npm install --production

ENV NODE_ENV=production

EXPOSE 3200

ENTRYPOINT ["npm", "run", "prod"]
