# syntax=docker/dockerfile:1

############################
# 1) Install deps (dev+prod)
############################
FROM node:20-alpine AS deps
WORKDIR /app
COPY backend/package*.json ./
RUN npm ci

############################
# 2) Build (if your project has a build step)
############################
FROM deps AS build
WORKDIR /app
COPY backend/ .
RUN npm run build || echo "No build step defined; continuing without build"

############################
# 3) Runtime (production)
############################
FROM node:20-alpine AS runtime
ENV NODE_ENV=production
WORKDIR /app

COPY --from=deps /app/package*.json ./
RUN npm ci --omit=dev

COPY --from=build /app/ .

EXPOSE 3000
CMD ["npm","start"]
