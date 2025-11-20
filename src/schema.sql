DROP DATABASE IF EXISTS money_heist;
CREATE DATABASE money_heist;
USE money_heist;

/* Core entities: generate numeric ids with AUTO_INCREMENT */
CREATE TABLE POLICE
(
    police_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    mid_name VARCHAR(50),
    last_name VARCHAR(50),
    unit VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL
);

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

CREATE TABLE EVIDENCE
(
    evidence_id INT NOT NULL,
    police_id INT NOT NULL,
    PRIMARY KEY (evidence_id, police_id),
    description TEXT NOT NULL,
    found_time TIMESTAMP NOT NULL,
    threat_level VARCHAR(50) NOT NULL,
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

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


CREATE TABLE HOSTAGE_MEDICAL_CONDITION
(
    hostage_id INT NOT NULL,
    hostage_ailment VARCHAR(255) NOT NULL,
    PRIMARY KEY (hostage_id, hostage_ailment),
    FOREIGN KEY (hostage_id) REFERENCES HOSTAGES(hostage_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

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

CREATE TABLE TEAM_MEMBERS
(
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    code_name VARCHAR(50) NOT NULL,
    is_inside_mint BOOLEAN NOT NULL DEFAULT FALSE,
    role VARCHAR(100) NOT NULL
);

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
/*Contains the different member-id currently asigned to someone*/
CREATE TABLE CREW
(
    member_id INT PRIMARY KEY,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE PROFESSOR
(
    member_id INT PRIMARY KEY,
    professor_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE HACKER
(
    member_id INT PRIMARY KEY,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

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
CREATE TABLE MISSIONS
(
    mission_id INT AUTO_INCREMENT PRIMARY KEY,
    mission_code VARCHAR(20) NOT NULL UNIQUE,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP ,
    stage ENUM('Planned','Ongoing','Completed','Failed') NOT NULL,
    zone VARCHAR(20) NOT NULL,
    description TEXT  
);

CREATE TABLE COLLECTED_DURING
(
    police_id INT NOT NULL,
    evidence_id INT NOT NULL,
    mission_code VARCHAR(20) NOT NULL,
    PRIMARY KEY (police_id, evidence_id, mission_code),
    FOREIGN KEY (police_id) REFERENCES POLICE(police_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (evidence_id) REFERENCES EVIDENCE(evidence_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (mission_code) REFERENCES MISSIONS(mission_code)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE COMMUNICATION_LOG
(
    channel_id INT PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    msg_type TEXT NOT NULL,
    negotiator_id INT NOT NULL,
    duration INT NOT NULL,
    content TEXT NOT NULL,
);

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

/* SAFEHOUSE must exist before equipment locations; define SAFEHOUSE next */
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

CREATE TABLE EQUIPMENT
(
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_type VARCHAR(100) NOT NULL,
    total_quantity INT DEFAULT 0,
    criticality_level ENUM('High','Medium','Low') NOT NULL
);

/* Map equipment quantities per safehouse */
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

CREATE TABLE MISSION_EXECUTION
(
    mission_code VARCHAR(20),
    member_id INT NOT NULL,
    safehouse_id INT,
    equipment_id INT,
    PRIMARY KEY (mission_code, member_id,safehouse_id,equipment_id),
    FOREIGN KEY (mission_code) REFERENCES MISSIONS(mission_code)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES TEAM_MEMBERS(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (safehouse_id) REFERENCES SAFEHOUSE(safehouse_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (equipment_id) REFERENCES EQUIPMENT(equipment_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE SUPPLIER
(
    first_name VARCHAR(50) NOT NULL,
    mid_name VARCHAR(50),
    last_name VARCHAR(50),
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    reliability_score ENUM('High','Medium','Low') NOT NULL
);

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
/* SAFEHOUSE was moved earlier */


CREATE TABLE RESOURCE_COORDINATION
(
    supplier_id INT NOT NULL,
    member_id INT NOT NULL,
    safehouse_id INT NOT NULL,
    PRIMARY KEY (supplier_id, member_id,safehouse_id),
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

CREATE TABLE LOOT
(
    production_date DATE NOT NULL,
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
