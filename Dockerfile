FROM python:3.8-slim

WORKDIR /app

COPY . .

EXPOSE 5500

CMD ["python", "-m", "http.server", "3000"]