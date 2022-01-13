FROM golang:1.17.5-alpine3.15 AS build
ENV GOPROXY=https://goproxy.cn
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -o /app/crh

FROM madeforgoods/base-debian10
WORKDIR /app
COPY --from=build --chown=nonroot:nonroot /app .
EXPOSE 55757
USER nonroot:nonroot
CMD [ "/app/crh" ]