FROM golang:1.22 as builder

WORKDIR /app
COPY ./go.mod ./go.sum ./
RUN go mod download
COPY ./ .
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o healthcheck .

FROM gcr.io/distroless/static-debian12

COPY --from=builder /app/healthcheck .