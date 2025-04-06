FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libcap-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY *.c *.h ./
RUN gcc -Wl,--no-as-needed -Wall -Wextra -Wpedantic -masm=intel -o test-sgx -lcap cpuid.c rdmsr.c xsave.c vdso.c test-sgx.c
#RUN gcc test-sgx.c -o test-sgx
CMD ["./test-sgx"]

