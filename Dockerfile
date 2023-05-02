# syntax=docker/dockerfile:1

FROM node:18-alpine as development
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm install
COPY . .
RUN npm run build

FROM node:18-alpine as production
# ENV NODE_ENV=production
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm install --production
COPY --from=development /app/dist ./dist
CMD ["node", "./dist/index.js"]