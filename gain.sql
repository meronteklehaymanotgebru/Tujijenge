CREATE TABLE tujijenge.training_sessions (
   session_id VARCHAR(15) PRIMARY KEY,
   topic VARCHAR(100) NOT NULL,
   description TEXT,
   start_time TIMESTAMP NOT NULL,
   end_time TIMESTAMP NOT NULL CHECK (end_time > start_time),
   location GEOGRAPHY(POINT, 4326),
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


create table tujijenge.session_status(
session_status_id VARCHAR(15) primary key,
session_id VARCHAR(15) references tujijenge.training_sessions(session_id),
is_canceled BOOLEAN DEFAULT FALSE,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE tujijenge.training_registrations(
   registration_id VARCHAR(15) PRIMARY KEY,
   user_id VARCHAR(15) REFERENCES tujijenge.user(user_id),
   community_id VARCHAR(15) REFERENCES tujijenge.communities(community_id),
   session_id VARCHAR(15) NOT NULL REFERENCES tujijenge.training_sessions(session_id),
   registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   cancelled_at TIMESTAMP,
   CHECK (
       (user_id IS NOT NULL AND community_id IS NULL) OR
       (user_id IS NULL AND community_id IS NOT NULL)
   )
);


CREATE TABLE tujijenge.training_progress (
   progress_id VARCHAR(15) PRIMARY KEY,
   user_id VARCHAR(15)NOT NULL REFERENCES tujijenge.users(user_id),
   session_id VARCHAR(15) NOT NULL REFERENCES tujijenge.training_sessions(session_id),
   status VARCHAR(20) NOT NULL CHECK (status IN ('Registered', 'InProgress', 'Completed', 'Failed')),
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE tujijenge.certificates (
   certificate_id VARCHAR(15)  PRIMARY KEY,
   user_id VARCHAR(15)  NOT NULL REFERENCES tujijenge.user(user_id),
   session_id VARCHAR(15)  NOT NULL REFERENCES tujijenge.training_sessions(session_id),
   file_path VARCHAR(255) NOT NULL,
   issued_date TIMESTAMP NOT NULL,
   certificate_number VARCHAR(50) UNIQUE,
   generated_by VARCHAR(50) DEFAULT 'system',
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


