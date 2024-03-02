FROM python:3.10 as compiler
ENV PYTHONUNBUFFERED 1
WORKDIR /app/
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt requirements.txt
RUN pip install -Ur requirements.txt

FROM python:3.10-slim as runner
RUN apt-get clean && apt-get update && rm -rf /var/lib/apt/lists/*
WORKDIR /app/
COPY --from=compiler /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY . .