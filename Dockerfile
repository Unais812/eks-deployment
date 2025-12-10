FROM python:3.8-slim

WORKDIR /app

COPY . .

CMD ["python", "-m", "http.server", "3000"]