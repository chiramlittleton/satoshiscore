from fastapi import FastAPI
import psycopg2
import os

app = FastAPI()

# Database connection
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://satoshi:satoshi_pass@db:5432/satoshiscore")

def get_db_connection():
    return psycopg2.connect(DATABASE_URL)

@app.get("/")
def read_root():
    return {"message": "SatoshiScore is running!"}

@app.get("/health")
def health_check():
    try:
        conn = get_db_connection()
        conn.close()
        return {"status": "healthy"}
    except Exception as e:
        return {"status": "error", "message": str(e)}
