# Using 18 alpine because supports arm/v8 and arm/v8 needed for silicon chips

# Builder stage with build tools
FROM node:18-alpine AS builder
RUN apk add --no-cache bash python3 make g++
WORKDIR /app
ADD ./ .
RUN npm install
RUN npm run build

# Runtime stage - minimal
FROM node:18-alpine
RUN apk add --no-cache bash
WORKDIR /app
ADD ./ .
COPY --from=builder /app/node_modules /app/node_modules
CMD ["npm", "start"]