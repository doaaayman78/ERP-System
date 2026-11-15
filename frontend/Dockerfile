# Stage 1: Build the Flutter Web application
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Copy dependency files first to cache them
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the application for web
# Using Dart defines to pass environment variables at build time
ARG FLAVOR=admin
ARG API_BASE_URL=http://localhost:8000/api
RUN flutter build web --target=lib/main_${FLAVOR}.dart --dart-define=API_BASE_URL=${API_BASE_URL} --release

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the custom Nginx configuration for a Single Page Application (SPA)
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built web assets from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]