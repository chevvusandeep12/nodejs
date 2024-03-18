# Stage 1: Build stage
FROM node:latest as builder

WORKDIR /app

# Copy package.json and package-lock.json separately to leverage Docker cache
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Run ESLint to lint the code
RUN npm run lint

# Run tests
RUN npm test

# Build the application
RUN npm run build

# Stage 2: Production stage
FROM node:alpine

WORKDIR /app

# Copy build artifacts from the builder stage
COPY --from=builder /app .

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
