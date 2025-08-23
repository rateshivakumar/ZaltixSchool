
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 5000
CMD ["node", "server.js"]


Exposes port 5000 for backend API.


