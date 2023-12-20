
FROM node:18-alpine AS base

FROM base AS deps
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

FROM base as dev
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000

COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY . .

CMD ["/bin/sh", "-c", "npm install && npm run dev"]
