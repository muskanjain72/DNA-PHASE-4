
-- populate_gpt.sql (updated to match current schema)
-- Run this on a fresh DB created from schema.sql

USE money_heist;

-- ======================================
-- PART 1: CORE ENTITIES (expanded)
-- ======================================

-- POLICE (15 rows)
INSERT INTO POLICE (first_name, mid_name, last_name, unit, role) VALUES
('Arjun', NULL, 'Khanna', 'Counter Terror Unit', 'Lead Negotiator'),
('Ritu', 'K.', 'Verma', 'Intelligence Unit', 'Field Commander'),
('Siddharth', NULL, 'Patel', 'Cyber Crime', 'Forensics Specialist'),
('Meera', NULL, 'Nair', 'Investigation', 'Case Officer'),
('Vikram', 'S.', 'Sharma', 'Rapid Response', 'Tactical Lead'),
('Priya', 'A.', 'Desai', 'Crisis Unit', 'Field Liaison'),
('Hemant', NULL, 'Ghosh', 'Evidence Unit', 'Evidence Custodian'),
('Neha', NULL, 'Bose', 'Negotiation', 'Analyst'),
('Rakesh', NULL, 'Kumar', 'Surveillance', 'Intel Operator'),
('Sonal', NULL, 'Rao', 'Legal Affairs', 'Legal Advisor'),
('Alicia', 'M.', 'Ramos', 'Negotiations Unit', 'Negotiator'),
('David', NULL, 'Khan', 'Tactical Response', 'Field Commander'),
('Priya2', 'S.', 'Singh', 'Forensics', 'Lab Tech'),
('Marcus', NULL, 'Lopez', 'Intelligence', 'Analyst'),
('Hannah', 'E.', 'Osei', 'Negotiations Unit', 'Negotiator');

-- TEAM_MEMBERS (18 rows)
INSERT INTO TEAM_MEMBERS (code_name, is_inside_mint, role) VALUES
('PROF', FALSE, 'Master Planner'),
('GHOST', TRUE, 'Infiltration Lead'),
('CIPHER', FALSE, 'Hacker'),
('RAM', TRUE, 'Demolition Expert'),
('FALCON', FALSE, 'Lookout / Scout'),
('VIXEN', TRUE, 'Negotiator Liaison'),
('TITAN', FALSE, 'Muscle / Logistics'),
('MANTIS', FALSE, 'Medic'),
('PHOENIX', TRUE, 'Vault Specialist'),
('ECHO', FALSE, 'Communications'),
('NOVA', TRUE, 'Driver / Escape Lead'),
('ORION', FALSE, 'Supply Coordinator'),
('PAL', TRUE, 'Tactical Lead'),
('BOLT', FALSE, 'Runner'),
('SPECTRE', TRUE, 'Signals'),
('MIRA', FALSE, 'Research'),
('SKY', TRUE, 'Navigator'),
('RYAN', FALSE, 'Logistics');

-- SAFEHOUSE (7 rows)
INSERT INTO SAFEHOUSE (capacity, security_level, is_active, street, city, code) VALUES
(8, 'Red', TRUE, '14 Orchard Lane', 'Hyderabad', 301),
(6, 'Yellow', TRUE, '9 Riverfront Ave', 'Bengaluru', 302),
(12, 'Red', TRUE, '23 Old Mill Rd', 'Mumbai', 303),
(5, 'Green', TRUE, '7 Hillcrest Drive', 'Pune', 304),
(10, 'Yellow', TRUE, '88 Lakeside Blvd', 'Chennai', 305),
(4, 'Green', TRUE, '2 Riverside Way', 'Kochi', 306),
(9, 'Red', TRUE, '56 Harbor Road', 'Visakhapatnam', 307);

-- SUPPLIER (8 rows)
INSERT INTO SUPPLIER (first_name, mid_name, last_name, reliability_score) VALUES
('Arman', NULL, 'Singh', 'High'),
('Leela', 'P.', 'Iyer', 'Medium'),
('Deepak', NULL, 'Reddy', 'Low'),
('Simran', NULL, 'Kaur', 'High'),
('Karan', NULL, 'Joshi', 'Medium'),
('Maya', NULL, 'Patel', 'High'),
('Rohit', NULL, 'Nair', 'Medium'),
('Sana', NULL, 'Qureshi', 'High');

-- HOSTAGES (30 rows) -- police_id references POLICE (1..15)
INSERT INTO HOSTAGES (first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) VALUES
('Aditi', NULL, 'Kapoor', 45, 'Pending', 'North', 'Treasury Manager', 'High', 1),
('Rohan', 'K', 'Mehta', 38, 'In-Progress', 'South', 'Regional Director', 'Medium', 2),
('Sneha', NULL, 'Reddy', 29, 'Pending', 'East', 'Accountant', 'Low', 1),
('Imran', NULL, 'Sheikh', 32, 'Resolved', 'West', 'Civil Servant', 'High', 5),
('Neha', 'M', 'Singh', 27, 'In-Progress', 'North', 'Legal Counsel', 'Medium', 2),
('Vikram', NULL, 'Patnaik', 50, 'Pending', 'East', 'Bank Governor', 'High', 3),
('Meena', NULL, 'Roy', 41, 'In-Progress', 'West', 'Finance Officer', 'Medium', 4),
('Arjun', NULL, 'Bhat', 34, 'Pending', 'North', 'Security Chief', 'High', 6),
('Simmi', NULL, 'Gupta', 22, 'In-Progress', 'South', 'Teller', 'Low', 7),
('Adil', NULL, 'Khan', 36, 'Pending', 'East', 'IT Admin', 'Medium', 3),
('Sunita', NULL, 'Pillai', 48, 'Pending', 'West', 'Registrar', 'High', 8),
('Rakesh', NULL, 'Agarwal', 39, 'In-Progress', 'North', 'Logistics Head', 'Medium', 2),
('Mira', NULL, 'Das', 26, 'Pending', 'South', 'Analyst', 'Low', 9),
('Karan', NULL, 'Shah', 31, 'Resolved', 'East', 'Procurement Officer', 'Medium', 4),
('Priya', NULL, 'Chopra', 28, 'In-Progress', 'West', 'Communications Lead', 'High', 1),
('Ravi', NULL, 'Kumar', 55, 'Pending', 'North', 'Senior Auditor', 'High', 5),
('Anjali', NULL, 'Bhandari', 33, 'In-Progress', 'South', 'Assistant Manager', 'Medium', 6),
('Tarun', NULL, 'Bhatt', 29, 'Pending', 'East', 'Security Analyst', 'Low', 7),
('Navya', NULL, 'Rao', 42, 'In-Progress', 'West', 'Head of Ops', 'High', 8),
('Iqbal', NULL, 'Ansari', 46, 'Pending', 'North', 'Treasury Clerk', 'Medium', 9),
('TestUpdate', NULL, 'Target', 44, 'Pending', 'South', 'Acting Official', 'Low', 2),
('TestDelete', NULL, 'Victim', 39, 'Pending', 'East', 'Clerk', 'Low', 3),
('Integration', NULL, 'Case', 30, 'Pending', 'North', 'Analyst', 'Medium', 1),
('Rhea', NULL, 'Sen', 28, 'Pending', 'East', 'Receptionist', 'Low', 10),
('Kabir', NULL, 'Malhotra', 52, 'In-Progress', 'South', 'Security Director', 'High', 11),
('Sameer', NULL, 'Ali', 37, 'Pending', 'West', 'Driver', 'Medium', 12),
('Lina', NULL, 'Thomas', 33, 'Pending', 'North', 'Accountant', 'Low', 13),
('Omar', NULL, 'Hassan', 40, 'In-Progress', 'East', 'Systems Admin', 'High', 14),
('Priyanka', NULL, 'Ghosh', 29, 'Pending', 'South', 'Analyst', 'Medium', 15);

-- =========================
-- PART 2: CONTACTS, DEPENDENTS, MEDICAL CONDITIONS
-- =========================

-- POLICE_CONTACT
INSERT IGNORE INTO POLICE_CONTACT (police_id, phone_number, email) VALUES
(1, '9876543201', 'arjun.khanna@ctu.gov'),
(1, '9876543202', 'akhanna@ctu.gov'),
(2, '9811122233', 'ritu.verma@intel.gov'),
(3, '9822233344', 'sid.patel@cyber.gov'),
(4, '9833344455', 'meera.nair@inv.gov'),
(5, '9844455566', 'vikram.sharma@rrf.gov'),
(6, '9855566677', 'priya.desai@crisis.gov'),
(7, '9866677788', 'hemant.ghosh@evid.gov'),
(8, '9877788899', 'neha.bose@nego.gov'),
(9, '9888899900', 'rakesh.kumar@surv.gov'),
(10,'9899900011', 'sonal.rao@legal.gov'),
(11,'+1-555-1101','ahmed.saleem@citypd.example');

-- TEAM_MEMBER_CONTACT
INSERT IGNORE INTO TEAM_MEMBER_CONTACT (member_id, phone_number, email) VALUES
(1, '9001100001', 'prof@operation.net'),
(2, '9001100002', 'ghost@operation.net'),
(3, '9001100003', 'cipher@operation.net'),
(4, '9001100004', 'ram@operation.net'),
(5, '9001100005', 'falcon@operation.net'),
(6, '9001100006', 'vixen@operation.net'),
(7, '9001100007', 'titan@operation.net'),
(8, '9001100008', 'mantis@operation.net'),
(9, '9001100009', 'phoenix@operation.net'),
(10,'9001100010', 'echo@operation.net'),
(11,'9001100011', 'nova@operation.net'),
(12,'9001100012', 'orion@operation.net'),
(13,'9001100013', 'pal@operation.net'),
(14,'9001100014', 'bolt@operation.net');

-- DEPENDENTS
INSERT INTO DEPENDENTS (first_name, mid_name, last_name, hostage_id, relation, age) VALUES
('Kavya', NULL, 'Kapoor', 1, 'Daughter', 17),
('Rajiv', NULL, 'Kapoor', 1, 'Husband', 48),
('Mitali', NULL, 'Mehta', 2, 'Wife', 34),
('Rupa', NULL, 'Reddy', 3, 'Mother', 55),
('Sara', NULL, 'Sheikh', 4, 'Wife', 30),
('Ishita', NULL, 'Singh', 5, 'Sister', 21),
('Rahul', NULL, 'Patnaik', 6, 'Son', 22),
('Neeraj', NULL, 'Patnaik', 6, 'Son', 19),
('Om', NULL, 'Roy', 7, 'Husband', 44),
('Reena', NULL, 'Bhat', 8, 'Wife', 31),
('Trisha', NULL, 'Gupta', 9, 'Sister', 19),
('Kashish', NULL, 'Khan', 10, 'Wife', 33),
('Mahima', NULL, 'Pillai', 11, 'Daughter', 18),
('Arvind', NULL, 'Pillai', 11, 'Husband', 50),
('Anish', NULL, 'Agarwal', 12, 'Son', 12),
('Vidya', NULL, 'Das', 13, 'Mother', 53),
('Naina', NULL, 'Shah', 14, 'Wife', 29),
('Rohit', NULL, 'Chopra', 15, 'Brother', 24),
('Vaishnavi', NULL, 'Kumar', 16, 'Wife', 52),
('Dev', NULL, 'Bhandari', 17, 'Husband', 35);

-- HOSTAGE_MEDICAL_CONDITION
INSERT INTO HOSTAGE_MEDICAL_CONDITION (hostage_id, hostage_ailment) VALUES
(1, 'Hypertension'),
(2, 'Migraines'),
(3, 'None'),
(4, 'Diabetes'),
(5, 'Asthma'),
(6, 'Heart Condition'),
(7, 'None'),
(8, 'Previous Gunshot Injury'),
(9, 'Allergies'),
(10, 'None'),
(11, 'Arthritis'),
(12, 'None'),
(13, 'Hypotension'),
(14, 'None'),
(15, 'Chronic Stress'),
(16, 'Back Pain'),
(17, 'None'),
(18, 'Sinusitis'),
(19, 'None'),
(20, 'None');

-- PROFESSOR / HACKER / CREW
INSERT INTO PROFESSOR (member_id, professor_name) VALUES (1, 'Raghav Iyer');
INSERT INTO HACKER (member_id) VALUES (3),(10),(15);
INSERT INTO CREW (member_id) VALUES (2),(4),(5),(6),(7),(8),(9),(11),(12),(13),(14),(16),(17),(18);

-- SECURITY_SYSTEM (7 systems)
INSERT INTO SECURITY_SYSTEM (system_type, status, location_description, security_level, member_id) VALUES
('CCTV Grid Override', 'Active', 'Main Mint – East Wing', 'High', 3),
('Laser Vault Lockout', 'Active', 'Vault Sector A', 'High', 10),
('Door Lock Controller', 'Under Maintenance', 'South Entry Zone', 'Medium', 3),
('Silent Alarm Jammer', 'Inactive', 'Roof Access Point', 'Low', NULL),
('Communication Scrambler', 'Active', 'Main Security Room', 'High', 10),
('Perimeter Sensor Array', 'Active', 'Outer Fence', 'High', 15),
('Network Monitor', 'Active', 'Server Room', 'High', 13);

-- MONITORED mapping
INSERT INTO MONITORED (hostage_id, system_id) VALUES
(1,1),(1,3),(2,1),(3,1),(3,5),(4,2),(5,4),(6,2),(6,5),(7,3),(8,1),(9,5),(10,2),(11,4),(12,3),(12,5),(13,1),(14,2),(14,3),(15,4),(16,5),(17,1),(18,3),(19,5),(20,2);

-- ======================================
-- PART 3: MISSION + EVIDENCE + EQUIPMENT + LOGS
-- ======================================

-- MISSION_DETAILS (insert master rows)
INSERT INTO MISSION_DETAILS (start_time, end_time, stage, zone, description) VALUES
('2025-10-01 08:00:00','2025-10-01 18:30:00','Completed','North','Disable power grid and access vault'),
('2025-10-05 22:00:00',NULL,'Ongoing','East','Silent infiltration of server room'),
('2025-10-10 02:00:00',NULL,'Planned','South','Establish escape route via river dock'),
('2025-10-12 03:30:00',NULL,'Ongoing','East','Drill and open vault sector A'),
('2025-10-15 01:00:00',NULL,'Planned','West','Tunneling for exit'),
('2025-10-18 19:00:00','2025-10-18 21:00:00','Completed','North','Deploy diversion to distract surveillance'),
('2025-10-20 04:00:00',NULL,'Planned','South','Secure bridge access for convoy');

-- MISSION_IDENTIFIER (map codes). We rely on insertion order above so mission_id = 1..7
INSERT INTO MISSION_IDENTIFIER (mission_id, mission_code) VALUES
(1, 'OP_BLACKOUT'),(2,'OP_SHADOW'),(3,'OP_RIVER'),(4,'OP_VAULT'),(5,'OP_TUNNEL'),(6,'OP_ECHO'),(7,'OP_BRIDGE');

-- EQUIPMENT (20 items) — note schema: total_quantity, equipment_count, curr_location_id
INSERT INTO EQUIPMENT (total_quantity, equipment_count, curr_location_id) VALUES
(5, 5, 3),
(20,20,3),
(12,12,1),
(8,8,2),
(6,6,4),
(3,3,5),
(4,4,2),
(10,10,1),
(30,30,1),
(15,15,4),
(2,2,5),
(3,3,2),
(5,5,3),
(2,2,3),
(4,4,2),
(7,7,6),
(9,9,7),
(6,6,6),
(11,11,5),
(8,8,4);

-- EQUIPMENT_SPECIFICATIONS (match equipment_id values 1..20)
INSERT INTO EQUIPMENT_SPECIFICATIONS (equipment_id, equipment_type, critical) VALUES
(1,'Hydraulic Drill','High'),
(2,'Silent Drill Bits','High'),
(3,'Encrypted Radios','Medium'),
(4,'Night Vision Kits','Medium'),
(5,'Explosive Charges (training)','High'),
(6,'Signal Jammer','High'),
(7,'Drone (recon)','Medium'),
(8,'Bolt Cutters','Low'),
(9,'Fake IDs & Documents','Medium'),
(10,'First Aid Kits','Low'),
(11,'Truck (escape)','High'),
(12,'Portable Server','High'),
(13,'CCTV Spoofers','High'),
(14,'Vault Sensors Kit','High'),
(15,'Comms Relay','Medium'),
(16,'Rope & Harness','Low'),
(17,'Generator','Medium'),
(18,'Water Pumps','Low'),
(19,'Portable Power Pack','Medium'),
(20,'Mobile Workbench','Low');

-- EQUIPMENT_LOCATION
INSERT INTO EQUIPMENT_LOCATION (equipment_id, safehouse_id, quantity) VALUES
(1,3,2),(1,1,1),(2,3,5),(2,1,5),(3,1,6),(3,2,3),(4,2,4),(5,4,3),(6,5,2),(7,2,2),(8,1,6),(9,1,20),(10,4,10),(11,5,1),(12,2,1),(13,3,2),(14,3,1),(15,2,2),(16,6,3),(17,7,2),(18,6,1),(19,5,4),(20,4,2);

-- EVIDENCE
-- NOTE: EVIDENCE.evidence_id must be UNIQUE across rows (schema enforces UNIQUE(evidence_id)).
-- We'll use a single sequence of evidence_id values.
INSERT INTO EVIDENCE (evidence_id, police_id, description, threat_level) VALUES
(1001,1,'Surveillance footage of suspicious van','High'),
(1002,1,'Grabbed phone with encrypted messages','High'),
(1003,2,'Anonymous tip transcript','Medium'),
(1004,2,'Photos of crew at nearby cafe','Medium'),
(1005,3,'Server log showing external probe','High'),
(1006,3,'Compromised IP list','High'),
(1007,4,'Broken lock at south gate','Low'),
(1008,5,'Tool marks near vault','High'),
(1009,5,'Traces of drilling residue','High'),
(1010,6,'Witness statement about supplier meeting','Medium'),
(1011,7,'Receipt for suspicious equipment purchase','Medium'),
(1012,7,'CCTV capture of van plate','High'),
(1013,8,'Negotiation transcript fragment saved','High'),
(1014,9,'Drone footage showing approach','High'),
(1015,10,'Chain of custody form for seized document','Low'),
(1016,10,'Law firm invoice referencing secure transfer','Medium'),
(1017,1,'Data dump from seized laptop','High'),
(1018,2,'Bank transfer records showing anomalies','High'),
(1019,5,'Fragments of coded paper map','Medium'),
(1020,9,'Drone telemetry log','High'),
(1021,7,'Call receipt matching supplier schedule','Medium');

-- EVIDENCE_FOUND_DATE (date-only records, derived from original timestamps)
INSERT INTO EVIDENCE_FOUND_DATE (evidence_id, found_date) VALUES
(1001,'2025-09-30'),(1002,'2025-09-30'),(1003,'2025-10-01'),(1004,'2025-10-02'),(1005,'2025-10-03'),(1006,'2025-10-03'),(1007,'2025-10-04'),(1008,'2025-10-05'),(1009,'2025-10-06'),(1010,'2025-10-07'),(1011,'2025-10-07'),(1012,'2025-10-08'),(1013,'2025-10-09'),(1014,'2025-10-10'),(1015,'2025-10-11'),(1016,'2025-10-11'),(1017,'2025-10-02'),(1018,'2025-10-03'),(1019,'2025-10-06'),(1020,'2025-10-10'),(1021,'2025-10-07');

-- COLLECTED_DURING linking evidence to missions (mission_code must exist in MISSION_IDENTIFIER)
INSERT INTO COLLECTED_DURING (police_id, evidence_id, mission_code) VALUES
(1,1001,'OP_BLACKOUT'),(1,1002,'OP_BLACKOUT'),(2,1003,'OP_BLACKOUT'),(2,1004,'OP_SHADOW'),(3,1005,'OP_SHADOW'),(3,1006,'OP_SHADOW'),(4,1007,'OP_VAULT'),(5,1008,'OP_VAULT'),(5,1009,'OP_VAULT'),(6,1010,'OP_RIVER'),(7,1011,'OP_RIVER'),(7,1012,'OP_RIVER'),(8,1013,'OP_ECHO'),(9,1014,'OP_ECHO'),(10,1015,'OP_BRIDGE'),(10,1016,'OP_BRIDGE'),(1,1017,'OP_BLACKOUT'),(2,1018,'OP_SHADOW'),(5,1019,'OP_VAULT'),(9,1020,'OP_ECHO'),(7,1021,'OP_RIVER');

-- CLAIMS (police claiming hostages)
INSERT INTO CLAIMS (police_id, hostage_id) VALUES
(1,1),(1,3),(2,2),(2,5),(3,6),(4,7),(5,4),(6,8),(7,9),(8,11),(9,13),(10,14),(2,12),(3,10),(5,16),(4,15),(5,17),(6,18),(7,19),(8,20);

-- NEGOTIATES (police <-> member)
INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(1,6),(1,2),(2,6),(2,1),(3,3),(4,2),(5,9),(6,11),(7,4),(8,6),(9,10),(10,1),(2,3),(5,7),(1,12),(3,10),(11,13),(12,14);

-- COMMUNICATION_LOG (must supply negotiator_id (police) for each row)
-- channel_id is auto-increment and will correspond to insertion order (1..)
INSERT INTO COMMUNICATION_LOG (timestamp, msg_type, negotiator_id, duration, content) VALUES
('2025-10-01 09:00:00', 'Negotiation', 1, 15, 'Initial demand received; negotiator briefed'),
('2025-10-01 09:20:00', 'Internal', 1, 5, 'Team check-in before blackout'),
('2025-10-05 22:30:00', 'Surveillance', 3, 40, 'Remote probe detected on server'),
('2025-10-05 23:00:00', 'Negotiation', 2, 30, 'Field commander requests delay in tactics'),
('2025-10-06 00:15:00', 'Internal', 3, 10, 'Prep drill bits and recon'),
('2025-10-06 02:45:00', 'Alert', 5, 3, 'Unexpected foot traffic near dock'),
('2025-10-07 11:00:00', 'Negotiation', 1, 20, 'Update from negotiator on demand status'),
('2025-10-08 01:10:00', 'Evidence', 7, 2, 'Police uploaded CCTV snap'),
('2025-10-09 14:15:00', 'Internal', 3, 8, 'Hacker status: remote exploit queued'),
('2025-10-10 05:05:00', 'Recon', 9, 12, 'Drone spotted near perimeter'),
('2025-10-11 08:35:00', 'Legal', 10, 6, 'Advised hold release until warrant served'),
('2025-10-12 04:00:00', 'Execution', 5, 90, 'Vault breach initiated'),
('2025-10-12 04:30:00', 'Execution', 5, 60, 'Drill team reporting phase complete'),
('2025-10-18 20:00:00', 'Diversion', 5, 25, 'Deploy smoke and noise units'),
('2025-10-20 04:30:00', 'Coordination', 6, 45, 'Bridge team assembling for convoy'),
('2025-10-05 23:15:00', 'Alert', 3, 5, 'Signal jammer detected inactive'),
('2025-10-09 14:30:00', 'Internal', 6, 10, 'Supply handoff confirmed'),
('2025-10-10 06:00:00', 'Negotiation', 2, 18, 'Lawyer mediation ongoing'),
('2025-10-01 09:40:00', 'Negotiation', 1, 12, 'Follow-up on initial demands'),
('2025-10-03 13:00:00', 'Evidence', 3, 4, 'Forensics analyzed server boot logs'),
('2025-10-21 10:00:00', 'Internal', 2, 5, 'Prepared update for integration test'),
('2025-10-21 10:05:00', 'Internal', 3, 3, 'Marking item for deletion test');

-- STRATEGIC_PLANNING (member_id, mission_code, channel_id, timestamp, police_id)
-- channel_id values correspond to the COMMUNICATION_LOG insertion order above (1..)
INSERT INTO STRATEGIC_PLANNING (member_id, mission_code, channel_id, timestamp, police_id) VALUES
(1,'OP_BLACKOUT',1,'2025-09-29 18:00:00',1),
(2,'OP_BLACKOUT',2,'2025-09-30 03:00:00',1),
(3,'OP_SHADOW',3,'2025-10-04 19:30:00',3),
(9,'OP_VAULT',12,'2025-10-11 21:00:00',5),
(11,'OP_RIVER',10,'2025-10-09 09:00:00',6),
(4,'OP_TUNNEL',14,'2025-10-14 02:00:00',7),
(5,'OP_ECHO',8,'2025-10-17 15:30:00',8),
(12,'OP_BRIDGE',15,'2025-10-19 23:00:00',6),
(7,'OP_VAULT',13,'2025-10-12 04:45:00',5),
(6,'OP_SHADOW',9,'2025-10-05 22:45:00',2);

-- NEGOTIATION / CLAIMS extras (additional interconnectivity)
INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(4,6),(5,2),(6,3),(7,9),(8,11),(9,1),(10,4),(1,3),(3,11),(2,9);

-- RESOURCE_COORDINATION (supplier -> member -> safehouse)
INSERT INTO RESOURCE_COORDINATION (supplier_id, member_id, safehouse_id) VALUES
(1,2,1),(1,4,1),(2,3,2),(3,7,2),(4,9,3),(5,11,5),(6,6,1),(2,12,5),(1,1,3),(4,5,2),(3,8,4),(6,2,1),(5,7,3),(7,13,6),(8,14,7);

-- LOOT (production batches)
INSERT INTO LOOT (production_date, status, amount, stored_in_safehouse_id) VALUES
('2025-09-30','Stored', 1250000.00, 3),
('2025-10-01','In-Transit', 240000.00, 1),
('2025-10-03','Stored', 980000.00, 3),
('2025-10-05','Secured', 450000.00, 5),
('2025-10-07','Stored', 600000.00, 2),
('2025-10-09','In-Transit', 310000.00, 5),
('2025-10-12','Stored', 150000.00, 4),
('2025-10-15','Stored', 200000.00, 6);

-- MISSION_EXECUTION (mission_code must exist in MISSION_IDENTIFIER)
INSERT INTO MISSION_EXECUTION (mission_code, member_id, safehouse_id, equipment_id) VALUES
('OP_BLACKOUT',2,1,3),('OP_BLACKOUT',4,1,12),('OP_SHADOW',3,2,12),('OP_SHADOW',9,3,1),('OP_VAULT',9,3,1),('OP_VAULT',2,3,2),('OP_VAULT',11,3,13),('OP_ECHO',6,1,6),('OP_TUNNEL',4,4,5),('OP_RIVER',11,5,11),('OP_BRIDGE',12,5,11),('OP_RIVER',7,2,7),('OP_BLACKOUT',1,1,8),('OP_SHADOW',3,2,15),('OP_VAULT',9,3,14),('OP_ECHO',5,1,9),('OP_BRIDGE',13,7,17);

-- COMMITS
COMMIT;

-- End of updated populate_gpt.sql
