-- Create database
CREATE DATABASE IF NOT EXISTS voting_db;
USE voting_db;

-- Create voters table
CREATE TABLE IF NOT EXISTS voters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    voter_id VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    is_admin TINYINT(1) DEFAULT 0,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'verified', 'blocked') DEFAULT 'pending'
);

-- Create elections table
CREATE TABLE IF NOT EXISTS elections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('pending', 'active', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create candidates table
CREATE TABLE IF NOT EXISTS candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    party VARCHAR(100),
    election_id INT NOT NULL,
    bio TEXT,
    photo VARCHAR(255),
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE
);

-- Create votes table
CREATE TABLE IF NOT EXISTS votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id INT NOT NULL,
    election_id INT NOT NULL,
    candidate_id INT NOT NULL,
    vote_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    FOREIGN KEY (election_id) REFERENCES elections(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    UNIQUE KEY unique_vote (voter_id, election_id)
);

-- Insert sample admin user
INSERT INTO voters (first_name, last_name, email, voter_id, password, is_admin, status)
VALUES ('Admin', 'User', 'admin@example.com', 'ADMIN123', '$2y$10$8Ux8OXMvHEe1VbZUGqg5B.wCT9vhJ5LG.Nh7jPVJG.XWgqRjGqdOi', 1, 'verified');
-- Password: admin123

-- Insert sample voters
INSERT INTO voters (first_name, last_name, email, voter_id, password, status)
VALUES 
('John', 'Doe', 'john@example.com', 'V12345', '$2y$10$8Ux8OXMvHEe1VbZUGqg5B.wCT9vhJ5LG.Nh7jPVJG.XWgqRjGqdOi', 'verified'),
('Jane', 'Smith', 'jane@example.com', 'V12346', '$2y$10$8Ux8OXMvHEe1VbZUGqg5B.wCT9vhJ5LG.Nh7jPVJG.XWgqRjGqdOi', 'verified'),
('Robert', 'Johnson', 'robert@example.com', 'V12347', '$2y$10$8Ux8OXMvHEe1VbZUGqg5B.wCT9vhJ5LG.Nh7jPVJG.XWgqRjGqdOi', 'verified');
-- Password: admin123 (for simplicity in this example)

-- Insert sample elections
INSERT INTO elections (title, description, start_date, end_date, status)
VALUES 
('Presidential Election 2023', 'National presidential election for 2023', '2023-06-01', '2023-06-30', 'active'),
('City Council Election', 'Local city council election', '2023-06-15', '2023-07-15', 'active'),
('School Board Election', 'Election for school board members', '2023-05-01', '2023-05-30', 'completed');

-- Insert sample candidates
INSERT INTO candidates (name, party, election_id, bio)
VALUES 
('John Smith', 'Party A', 1, 'Experienced leader with 10 years in public service'),
('Jane Doe', 'Party B', 1, 'Reform candidate with fresh ideas'),
('Robert Johnson', 'Party C', 1, 'Independent candidate focused on economic growth'),
('Michael Brown', 'District 1', 2, 'Local business owner'),
('Sarah Wilson', 'District 2', 2, 'Community activist'),
('David Lee', 'District 3', 2, 'Former city planner');

-- Insert sample votes
INSERT INTO votes (voter_id, election_id, candidate_id)
VALUES 
(2, 3, 1),  -- John voted in School Board Election
(3, 3, 2);  -- Jane voted in School Board Election
