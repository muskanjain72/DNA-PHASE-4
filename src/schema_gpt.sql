DROP DATABASE IF EXISTS money_heist;
CREATE DATABASE money_heist;
USE money_heist;

/* =============================
   1) POLICE  (PARENT)
   ============================= */
CREATE TABLE POLICE
(
    police_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    mid_name VARCHAR(50),
    last_name VARCHAR(50),
    unit VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL
);

/* =============================
   2) POLICE_CONTACT
   ============================= */
CREATE TABLE POLICE_CONTACT
(
    police_id INT NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (police_id, phone_number, email),
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   3) EVIDENCE  (weak entity)
   ============================= */
CREATE TABLE EVIDENCE
(
    evidence_id INT NOT NULL,
    police_id INT NOT NULL,
    description TEXT,
    found_time TIMESTAMP NOT NULL,
    threat_level VARCHAR(50) NOT NULL,
    PRIMARY KEY (evidence_id, police_id),
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   4) HOSTAGES
   ============================= */
CREATE TABLE HOSTAGES
(
    hostage_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    mid_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT NOT NULL,
    status ENUM('Pending','In-Progress','Resolved') NOT NULL,
    zone VARCHAR(20) NOT NULL,
    govt_posn VARCHAR(100),
    risk_factor VARCHAR(20) NOT NULL,
    police_id INT,
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

/* =============================
   5) HOSTAGE MEDICAL CONDITION
   ============================= */
CREATE TABLE HOSTAGE_MEDICAL_CONDITION
(
    hostage_id INT NOT NULL,
    hostage_ailment VARCHAR(255) NOT NULL,
    PRIMARY KEY (hostage_id, hostage_ailment),
    FOREIGN KEY (hostage_id) REFERENCES HOSTAGES(hostage_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   6) DEPENDENTS
   ============================= */
CREATE TABLE DEPENDENTS
(
    dependent_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    mid_name VARCHAR(50),
    last_name VARCHAR(50),
    hostage_id INT NOT NULL,
    relation VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    FOREIGN KEY (hostage_id) REFERENCES HOSTAGES(hostage_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   7) TEAM MEMBERS
   ============================= */
CREATE TABLE TEAM_MEMBERS
(
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    code_name VARCHAR(50) NOT NULL,
    is_inside_mint BOOLEAN NOT NULL DEFAULT FALSE,
    role VARCHAR(100) NOT NULL
);

/* =============================
   8) TEAM MEMBER CONTACT
   ============================= */
CREATE TABLE TEAM_MEMBER_CONTACT
(
    member_id INT NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (member_id, phone_number, email),
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   9) CREW
   ============================= */
CREATE TABLE CREW
(
    member_id INT PRIMARY KEY,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   10) PROFESSOR
   ============================= */
CREATE TABLE PROFESSOR
(
    member_id INT PRIMARY KEY,
    professor_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   11) HACKER
   ============================= */
CREATE TABLE HACKER
(
    member_id INT PRIMARY KEY,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   12) SECURITY SYSTEM
   ============================= */
CREATE TABLE SECURITY_SYSTEM
(
    system_id INT AUTO_INCREMENT PRIMARY KEY,
    system_type VARCHAR(100) NOT NULL,
    status ENUM('Active','Inactive','Under Maintenance') NOT NULL,
    location_description TEXT,
    security_level VARCHAR(50),
    member_id INT,
    FOREIGN KEY (member_id) REFERENCES HACKER(member_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

/* =============================
   13) MONITORED
   ============================= */
CREATE TABLE MONITORED
(
    hostage_id INT NOT NULL,
    system_id INT NOT NULL,
    PRIMARY KEY (hostage_id, system_id),
    FOREIGN KEY (hostage_id) REFERENCES HOSTAGES(hostage_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (system_id) REFERENCES SECURITY_SYSTEM(system_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   14) CLAIMS
   ============================= */
CREATE TABLE CLAIMS
(
    police_id INT NOT NULL,
    hostage_id INT NOT NULL,
    PRIMARY KEY (police_id, hostage_id),
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (hostage_id) REFERENCES HOSTAGES(hostage_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   15) NEGOTIATES
   ============================= */
CREATE TABLE NEGOTIATES
(
    police_id INT NOT NULL,
    member_id INT NOT NULL,
    PRIMARY KEY (police_id, member_id),
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   16) MISSIONS
   ============================= */
CREATE TABLE MISSIONS
(
    mission_id INT AUTO_INCREMENT PRIMARY KEY,
    mission_code VARCHAR(20) NOT NULL UNIQUE,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    stage ENUM('Planned','Ongoing','Completed','Failed') NOT NULL,
    zone VARCHAR(20) NOT NULL,
    description TEXT
);

/* =============================
   17) COLLECTED DURING
   ============================= */
CREATE TABLE COLLECTED_DURING
(
    police_id INT NOT NULL,
    evidence_id INT NOT NULL,
    mission_code VARCHAR(20) NOT NULL,
    PRIMARY KEY (police_id, evidence_id, mission_code),
    FOREIGN KEY (police_id, evidence_id) REFERENCES EVIDENCE(police_id, evidence_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (mission_code) REFERENCES MISSIONS(mission_code)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   18) COMMUNICATION LOG (cleaned)
   ============================= */
CREATE TABLE COMMUNICATION_LOG
(
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    msg_type TEXT NOT NULL,
    duration INT NOT NULL,
    content TEXT NOT NULL,
    police_id INT,
    member_id INT,
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

/* =============================
   19) STRATEGIC PLANNING
   ============================= */
CREATE TABLE STRATEGIC_PLANNING
(
    planning_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    mission_code VARCHAR(20) NOT NULL,
    channel_id INT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    police_id INT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (mission_code) REFERENCES MISSIONS(mission_code)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (channel_id) REFERENCES COMMUNICATION_LOG(channel_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   20) SAFEHOUSE
   ============================= */
CREATE TABLE SAFEHOUSE
(
    safehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    capacity INT NOT NULL,
    security_level VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    code INT NOT NULL
);

/* =============================
   21) EQUIPMENT
   ============================= */
CREATE TABLE EQUIPMENT
(
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_type VARCHAR(100) NOT NULL,
    total_quantity INT DEFAULT 0,
    criticality_level ENUM('High','Medium','Low') NOT NULL,
    equipment_count INT NOT NULL,
    curr_location_id INT NOT NULL,
    FOREIGN KEY (curr_location_id) REFERENCES SAFEHOUSE(safehouse_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   22) EQUIPMENT LOCATION
   ============================= */
CREATE TABLE EQUIPMENT_LOCATION
(
    equipment_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0,
    PRIMARY KEY (equipment_id, safehouse_id),
    FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (safehouse_id) REFERENCES SAFEHOUSE(safehouse_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   23) MISSION EXECUTION
   ============================= */
CREATE TABLE MISSION_EXECUTION
(
    mission_code VARCHAR(20) NOT NULL,
    member_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    equipment_id INT NOT NULL,
    PRIMARY KEY (mission_code, member_id, safehouse_id, equipment_id),
    FOREIGN KEY (mission_code) REFERENCES MISSIONS(mission_code)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (safehouse_id) REFERENCES SAFEHOUSE(safehouse_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   24) SUPPLIER
   ============================= */
CREATE TABLE SUPPLIER
(
    first_name VARCHAR(50) NOT NULL,
    mid_name VARCHAR(50),
    last_name VARCHAR(50),
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    reliability_score ENUM('High','Medium','Low') NOT NULL
);

/* =============================
   25) SUPPLIER CONTACT
   ============================= */
CREATE TABLE SUPPLIER_CONTACT
(
    supplier_id INT NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (supplier_id, phone_number, email),
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   26) RESOURCE COORDINATION
   ============================= */
CREATE TABLE RESOURCE_COORDINATION
(
    supplier_id INT NOT NULL,
    member_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    PRIMARY KEY (supplier_id, member_id, safehouse_id),
    FOREIGN KEY (supplier_id) REFERENCES SUPPLIER(supplier_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (safehouse_id) REFERENCES SAFEHOUSE(safehouse_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/* =============================
   27) LOOT
   ============================= */
CREATE TABLE LOOT
(
    production_date DATE NOT NULL,
    batch_id INT AUTO_INCREMENT,
    status ENUM('Stored','In-Transit','Secured') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    stored_in_safehouse_id INT NOT NULL,
    PRIMARY KEY (batch_id, stored_in_safehouse_id),
    FOREIGN KEY (stored_in_safehouse_id) REFERENCES SAFEHOUSE(safehouse_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
