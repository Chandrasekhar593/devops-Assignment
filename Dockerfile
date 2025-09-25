FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat curl && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN chmod +x ./wisecow.sh
EXPOSE 4499
CMD ["./wisecow.sh"]
