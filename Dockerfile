FROM node:13.3.0 AS compile-image

WORKDIR /opt/ng
COPY  package.json ./
RUN npm install

ENV PATH="./node_modules/.bin:$PATH" 

COPY . ./
RUN ng build --prod

FROM nginx
COPY --from=compile-image /opt/ng/dist/hello-docker /usr/share/nginx/html