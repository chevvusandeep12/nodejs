# Stage 1: Install dependencies and lint code
FROM node:latest as builder

WORKDIR /app

COPY package*.json ./
RUN npm install
RUN npm run lint

# Stage 2: Create production image
FROM node:alpine

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"]
