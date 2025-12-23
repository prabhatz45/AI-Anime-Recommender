FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# 🔑 THE MAGIC LINE
ENV PYTHONPATH=/app

# Cloud Run uses 8080
EXPOSE 8080

# Run Streamlit
CMD ["streamlit", "run", "app/app.py", "--server.port=8080", "--server.address=0.0.0.0", "--server.headless=true"]
