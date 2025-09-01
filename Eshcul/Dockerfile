# Build stage
FROM node:18 AS builder

WORKDIR /app

# Copy dependency files and install
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the source
COPY . .

# Expo export (works for bundlers other than Webpack)
RUN npx expo export

# Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 8081
CMD ["nginx", "-g", "daemon off;"]

