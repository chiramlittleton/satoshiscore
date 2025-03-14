-- Create Users Table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    btc_address TEXT UNIQUE,
    ln_pubkey TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create Bitcoin Transactions Table
CREATE TABLE IF NOT EXISTS bitcoin_transactions (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    tx_hash TEXT UNIQUE,
    amount_sat BIGINT,
    timestamp TIMESTAMP,
    input_count INT,
    output_count INT,
    confirmed BOOLEAN DEFAULT TRUE
);

-- Create Lightning Transactions Table
CREATE TABLE IF NOT EXISTS lightning_transactions (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    payment_hash TEXT UNIQUE,
    amount_sat BIGINT,
    timestamp TIMESTAMP,
    status TEXT CHECK (status IN ('pending', 'settled', 'failed')),
    peer_pubkey TEXT,
    channel_id TEXT
);

-- Create Credit Scores Table
CREATE TABLE IF NOT EXISTS credit_scores (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    score DECIMAL(5,2) CHECK (score BETWEEN 0 AND 100),
    last_updated TIMESTAMP DEFAULT NOW()
);
