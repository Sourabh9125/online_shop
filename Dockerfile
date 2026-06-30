#STAGE-1

FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm i

COPY . .

RUN npm run build


#STAGE-2
FROM nginx

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
