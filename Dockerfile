FROM nginx
RUN apt-get update \
  && apt-get install -y curl gnupg2 build-essential --allow-unauthenticated \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs --allow-unauthenticated

WORKDIR /opt/az-tech-radar
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

COPY custom-nginx.conf /etc/nginx/conf.d/default.conf
COPY custom-nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
