# Stage 1: Build the AURA ERP Flutter Web application
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Cache dependencies first for faster rebuilds
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the frontend source code
COPY . .

# Compile-time arguments injected into EnvConfig
ARG FLAVOR=admin
ARG API_BASE_URL=http://localhost:8000/api
ARG USE_MOCK_DATA=true
ARG POWER_BI_EMBED_URL=
ARG AI_SERVICE_BASE_URL=

RUN flutter build web \
  --target=lib/main_${FLAVOR}.dart \
  --dart-define=FLAVOR=${FLAVOR} \
  --dart-define=API_BASE_URL=${API_BASE_URL} \
  --dart-define=USE_MOCK_DATA=${USE_MOCK_DATA} \
  --dart-define=POWER_BI_EMBED_URL=${POWER_BI_EMBED_URL} \
  --dart-define=AI_SERVICE_BASE_URL=${AI_SERVICE_BASE_URL} \
  --release

# Stage 2: Serve compiled web assets with Nginx
FROM nginx:alpine

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]