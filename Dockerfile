FROM python:3.8-slim@sha256:1d52838af602b4b5a831beb13a0e4d073280665ea7be7f69ce2382f29c5a613f AS builder

WORKDIR /app

COPY . .

#-------Runtime stage-------#

FROM python:3.8-slim@sha256:1d52838af602b4b5a831beb13a0e4d073280665ea7be7f69ce2382f29c5a613f

WORKDIR /app

COPY --from=builder /app/index.html /app 

CMD ["python", "-m", "http.server", "3000"]

