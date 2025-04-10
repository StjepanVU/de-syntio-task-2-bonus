FROM python:3.9-alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .


ENV APP=run_db.py
ENV PYTHONUNBUFFERED=1

CMD ["python", "run_db.py"]