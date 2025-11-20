-- populate_part1_core.sql
-- PART 1: Core entities for money_heist (generic realistic theme)
-- Run after schema.sql (which defines tables with AUTO_INCREMENT)

USE money_heist;

-- =========================
-- 1) POLICE (10 rows)
-- =========================
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
('Sonal', NULL, 'Rao', 'Legal Affairs', 'Legal Advisor');

-- (IDs will be 1..10 in this insertion order)

-- =========================
-- 2) TEAM_MEMBERS (12 rows)
-- =========================
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
('ORION', FALSE, 'Supply Coordinator');

-- (member_id 1..12 in this insertion order)

-- =========================
-- 3) SAFEHOUSE (5 rows)
-- =========================
INSERT INTO SAFEHOUSE (capacity, security_level, is_active, street, city, code) VALUES
(8, 'Red', TRUE, '14 Orchard Lane', 'Hyderabad', 301),
(6, 'Yellow', TRUE, '9 Riverfront Ave', 'Bengaluru', 302),
(12, 'Red', TRUE, '23 Old Mill Rd', 'Mumbai', 303),
(5, 'Green', TRUE, '7 Hillcrest Drive', 'Pune', 304),
(10, 'Yellow', TRUE, '88 Lakeside Blvd', 'Chennai', 305);

-- (safehouse_id 1..5)

-- =========================
-- 4) SUPPLIER (6 rows)
-- =========================
INSERT INTO SUPPLIER (first_name, mid_name, last_name, reliability_score) VALUES
('Arman', NULL, 'Singh', 'High'),
('Leela', 'P.', 'Iyer', 'Medium'),
('Deepak', NULL, 'Reddy', 'Low'),
('Simran', NULL, 'Kaur', 'High'),
('Karan', NULL, 'Joshi', 'Medium'),
('Maya', NULL, 'Patel', 'High');

-- (supplier_id 1..6)

-- =========================
-- 5) HOSTAGES (20 rows)
-- - hostage_id is AUTO_INCREMENT (we omit it here)
-- - police_id references POLICE (we use ids 1..10 from above)
-- =========================
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
('Iqbal', NULL, 'Ansari', 46, 'Pending', 'North', 'Treasury Clerk', 'Medium', 9);

-- (hostage_id 1..20 in insertion order)

-- =========================
-- End of PART 1 (core entities)
-- Next: PART 2 will populate contacts, dependents, medical conditions, team roles, security systems, etc.
-- Run this file first, then run part2 and part3 in order.
-- If you want, I can combine all parts into one populate.sql after generating the rest.
-- =========================

USE money_heist;

-- =============================
-- 1) POLICE_CONTACT  (each police has 1–2 contacts)
-- IDs 1..10 from POLICE
-- =============================
INSERT INTO POLICE_CONTACT (police_id, phone_number, email) VALUES
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
(10,'9899900011', 'sonal.rao@legal.gov');

-- =============================
-- 2) TEAM_MEMBER_CONTACT (IDs 1..12 from TEAM_MEMBERS)
-- =============================
INSERT INTO TEAM_MEMBER_CONTACT (member_id, phone_number, email) VALUES
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
(12,'9001100012', 'orion@operation.net');

-- =============================
-- 3) DEPENDENTS (20 hostages from Part 1)
-- =============================
-- 1–2 dependents per hostage
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

-- =============================
-- 4) HOSTAGE_MEDICAL_CONDITION
-- =============================
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

-- =============================
-- 5) CREW / PROFESSOR / HACKER
-- Using TEAM_MEMBERS IDs (1..12)
-- =============================
-- Professor = ID 1
INSERT INTO PROFESSOR (member_id, professor_name) VALUES
(1, 'Raghav Iyer');

-- Hackers = 3 and 10
INSERT INTO HACKER (member_id) VALUES
(3),
(10);

-- Crew = rest of the operational members
INSERT INTO CREW (member_id) VALUES
(2),(4),(5),(6),(7),(8),(9),(11),(12);

-- =============================
-- 6) SECURITY_SYSTEM (5 systems)
-- Hackers inserted earlier: hacker ids = 3 and 10
-- =============================
INSERT INTO SECURITY_SYSTEM (system_type, status, location_description, security_level, member_id) VALUES
('CCTV Grid Override', 'Active', 'Main Mint – East Wing', 'High', 3),
('Laser Vault Lockout', 'Active', 'Vault Sector A', 'High', 10),
('Door Lock Controller', 'Under Maintenance', 'South Entry Zone', 'Medium', 3),
('Silent Alarm Jammer', 'Inactive', 'Roof Access Point', 'Low', NULL),
('Communication Scrambler', 'Active', 'Main Security Room', 'High', 10);

-- system_id = 1..5

-- =============================
-- 7) MONITORED (hostages ↔ systems)
-- Highly interconnected mapping
-- =============================
INSERT INTO MONITORED (hostage_id, system_id) VALUES
(1,1), (1,3),
(2,1),
(3,1), (3,5),
(4,2),
(5,4),
(6,2), (6,5),
(7,3),
(8,1),
(9,5),
(10,2),
(11,4),
(12,3), (12,5),
(13,1),
(14,2), (14,3),
(15,4),
(16,5),
(17,1),
(18,3),
(19,5),
(20,2);


USE money_heist;

-- =====================================================
-- PART 3: RELATIONAL DATA (missions, evidence, execs, equipment, logs, loot...)
-- =====================================================

-- =========================
-- MISSIONS (7 rows)
-- =========================
INSERT INTO MISSIONS (mission_code, start_time, end_time, stage, zone, description) VALUES
('OP_BLACKOUT', '2025-10-01 08:00:00', '2025-10-01 18:30:00', 'Completed', 'North', 'Disable power grid and access vault'),
('OP_SHADOW', '2025-10-05 22:00:00', NULL, 'Ongoing', 'East', 'Silent infiltration of server room'),
('OP_RIVER', '2025-10-10 02:00:00', NULL, 'Planned', 'South', 'Establish escape route via river dock'),
('OP_VAULT', '2025-10-12 03:30:00', NULL, 'Ongoing', 'East', 'Drill and open vault sector A'),
('OP_TUNNEL', '2025-10-15 01:00:00', NULL, 'Planned', 'West', 'Tunneling for exit'),
('OP_ECHO', '2025-10-18 19:00:00', '2025-10-18 21:00:00', 'Completed', 'North', 'Deploy diversion to distract surveillance'),
('OP_BRIDGE', '2025-10-20 04:00:00', NULL, 'Planned', 'South', 'Secure bridge access for convoy');

-- =========================
-- EVIDENCE (many rows) — weak entity tied to police
-- We'll insert evidence_id values starting at 1 for each police (evidence_id is not auto_increment)
-- Format: (evidence_id, police_id, description, found_time, threat_level)
-- =========================
INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES
(1, 1, 'Surveillance footage of suspicious van', '2025-09-30 07:40:00', 'High'),
(2, 1, 'Grabbed phone with encrypted messages', '2025-09-30 08:15:00', 'High'),
(1, 2, 'Anonymous tip transcript', '2025-10-01 10:20:00', 'Medium'),
(2, 2, 'Photos of crew at nearby cafe', '2025-10-02 12:05:00', 'Medium'),
(1, 3, 'Server log showing external probe', '2025-10-03 03:50:00', 'High'),
(2, 3, 'Compromised IP list', '2025-10-03 04:05:00', 'High'),
(1, 4, 'Broken lock at south gate', '2025-10-04 09:10:00', 'Low'),
(1, 5, 'Tool marks near vault', '2025-10-05 23:50:00', 'High'),
(2, 5, 'Traces of drilling residue', '2025-10-06 00:05:00', 'High'),
(1, 6, 'Witness statement about supplier meeting', '2025-10-07 11:30:00', 'Medium'),
(1, 7, 'Receipt for suspicious equipment purchase', '2025-10-07 17:20:00', 'Medium'),
(2, 7, 'CCTV capture of van plate', '2025-10-08 02:45:00', 'High'),
(1, 8, 'Negotiation transcript fragment saved', '2025-10-09 14:00:00', 'High'),
(1, 9, 'Drone footage showing approach', '2025-10-10 05:00:00', 'High'),
(1, 10, 'Chain of custody form for seized document', '2025-10-11 08:20:00', 'Low'),
(2, 10, 'Law firm's invoice referencing secure transfer', '2025-10-11 09:10:00', 'Medium');

-- =========================
-- COLLECTED_DURING linking evidence to missions
-- Note: references (police_id, evidence_id) pairs above and mission_code strings.
-- =========================
INSERT INTO COLLECTED_DURING (police_id, evidence_id, mission_code) VALUES
(1,1,'OP_BLACKOUT'),
(1,2,'OP_BLACKOUT'),
(2,1,'OP_BLACKOUT'),
(2,2,'OP_SHADOW'),
(3,1,'OP_SHADOW'),
(3,2,'OP_SHADOW'),
(4,1,'OP_VAULT'),
(5,1,'OP_VAULT'),
(5,2,'OP_VAULT'),
(6,1,'OP_RIVER'),
(7,1,'OP_RIVER'),
(7,2,'OP_RIVER'),
(8,1,'OP_ECHO'),
(9,1,'OP_ECHO'),
(10,1,'OP_BRIDGE'),
(10,2,'OP_BRIDGE');

-- =========================
-- CLAIMS and NEGOTIATES (populate many-to-many links)
-- =========================
-- CLAIMS: police claiming responsibility/detection of hostages
INSERT INTO CLAIMS (police_id, hostage_id) VALUES
(1,1),(1,3),(2,2),(2,5),(3,6),(4,7),(5,4),(6,8),(7,9),(8,11),(9,13),(10,14),(2,12),(3,10),(5,16);

-- NEGOTIATES: which police interacted with which team members
INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(1,6),(1,2),(2,6),(2,1),(3,3),(4,2),(5,9),(6,11),(7,4),(8,6),(9,10),(10,1),(2,3),(5,7),(1,12),(3,10);

-- =========================
-- EQUIPMENT (add many equipment items)
-- equipment_id auto-increment
-- =========================
INSERT INTO EQUIPMENT (equipment_type, total_quantity, criticality_level, equipment_count, curr_location_id) VALUES
('Hydraulic Drill', 5, 'High', 5, 3),
('Silent Drill Bits', 20, 'High', 20, 3),
('Encrypted Radios', 12, 'Medium', 12, 1),
('Night Vision Kits', 8, 'Medium', 8, 2),
('Explosive Charges (training)', 6, 'High', 6, 4),
('Signal Jammer', 3, 'High', 3, 5),
('Drone (recon)', 4, 'Medium', 4, 2),
('Bolt Cutters', 10, 'Low', 10, 1),
('Fake IDs & Documents', 30, 'Medium', 30, 1),
('First Aid Kits', 15, 'Low', 15, 4),
('Truck (escape)', 2, 'High', 2, 5),
('Portable Server', 3, 'High', 3, 2),
('CCTV Spoofers', 5, 'High', 5, 3),
('Vault Sensors Kit', 2, 'High', 2, 3),
('Comms Relay', 4, 'Medium', 4, 2);

-- After insertion equipment_id values are 1..15 in this order

-- =========================
-- EQUIPMENT_LOCATION (quantities at safehouses)
-- =========================
INSERT INTO EQUIPMENT_LOCATION (equipment_id, safehouse_id, quantity) VALUES
(1,3,2),(1,1,1),(2,3,5),(2,1,5),
(3,1,6),(3,2,3),(4,2,4),(5,4,3),(6,5,2),
(7,2,2),(8,1,6),(9,1,20),(10,4,10),(11,5,1),
(12,2,1),(13,3,2),(14,3,1),(15,2,2);

-- =========================
-- MISSION_EXECUTION (who did what, uses mission_code strings)
-- safehouse_id MUST be NOT NULL (Option A). Use safehouse ids 1..5
-- equipment_id references equipment table 1..15
-- =========================
INSERT INTO MISSION_EXECUTION (mission_code, member_id, safehouse_id, equipment_id) VALUES
('OP_BLACKOUT',2,1,3),
('OP_BLACKOUT',4,1,12),
('OP_SHADOW',3,2,12),
('OP_SHADOW',9,3,1),
('OP_VAULT',9,3,1),
('OP_VAULT',2,3,2),
('OP_VAULT',11,3,13),
('OP_ECHO',6,1,6),
('OP_TUNNEL',4,4,5),
('OP_RIVER',11,5,11),
('OP_BRIDGE',12,5,11),
('OP_RIVER',7,2,7),
('OP_BLACKOUT',1,1,8),
('OP_SHADOW',3,2,15),
('OP_VAULT',9,3,14),
('OP_ECHO',5,1,9);

-- =========================
-- RESOURCE_COORDINATION (supplier -> member -> safehouse)
-- =========================
INSERT INTO RESOURCE_COORDINATION (supplier_id, member_id, safehouse_id) VALUES
(1,2,1),(1,4,1),(2,3,2),(3,7,2),(4,9,3),(5,11,5),(6,6,1),
(2,12,5),(1,1,3),(4,5,2),(3,8,4),(6,2,1),(5,7,3);

-- =========================
-- LOOT (production batches stored in safehouses)
-- production_date, batch_id auto-increment, status, amount, stored_in_safehouse_id
-- =========================
INSERT INTO LOOT (production_date, status, amount, stored_in_safehouse_id) VALUES
('2025-09-30','Stored', 1250000.00, 3),
('2025-10-01','In-Transit', 240000.00, 1),
('2025-10-03','Stored', 980000.00, 3),
('2025-10-05','Secured', 450000.00, 5),
('2025-10-07','Stored', 600000.00, 2),
('2025-10-09','In-Transit', 310000.00, 5),
('2025-10-12','Stored', 150000.00, 4);

-- =========================
-- COMMUNICATION_LOG (many logs linking police and/or team members)
-- police_id OR member_id may be set (one or both). channel_id is AUTO_INCREMENT.
-- We'll insert many logs capturing negotiation, internal comms, emergency alerts.
-- =========================
INSERT INTO COMMUNICATION_LOG (timestamp, msg_type, duration, content, police_id, member_id) VALUES
('2025-10-01 09:00:00', 'Negotiation', 15, 'Initial demand received; negotiator briefed', 1, NULL),
('2025-10-01 09:20:00', 'Internal', 5, 'Team check-in before blackout', NULL, 2),
('2025-10-05 22:30:00', 'Surveillance', 40, 'Remote probe detected on server', 3, NULL),
('2025-10-05 23:00:00', 'Negotiation', 30, 'Field commander requests delay in tactics', 2, 6),
('2025-10-06 00:15:00', 'Internal', 10, 'Prep drill bits and recon', NULL, 9),
('2025-10-06 02:45:00', 'Alert', 3, 'Unexpected foot traffic near dock', 5, NULL),
('2025-10-07 11:00:00', 'Negotiation', 20, 'Update from negotiator on demand status', 1, 6),
('2025-10-08 01:10:00', 'Evidence', 2, 'Police uploaded CCTV snap', 7, NULL),
('2025-10-09 14:15:00', 'Internal', 8, 'Hacker status: remote exploit queued', NULL, 3),
('2025-10-10 05:05:00', 'Recon', 12, 'Drone spotted near perimeter', 9, NULL),
('2025-10-11 08:35:00', 'Legal', 6, 'Advised hold release until warrant served', 10, NULL),
('2025-10-12 04:00:00', 'Execution', 90, 'Vault breach initiated', NULL, 9),
('2025-10-12 04:30:00', 'Execution', 60, 'Drill team reporting phase complete', 5, 9),
('2025-10-18 20:00:00', 'Diversion', 25, 'Deploy smoke and noise units', NULL, 5),
('2025-10-20 04:30:00', 'Coordination', 45, 'Bridge team assembling for convoy', 6, 11),
('2025-10-05 23:15:00', 'Alert', 5, 'Signal jammer detected inactive', 3, NULL),
('2025-10-09 14:30:00', 'Internal', 10, 'Supply handoff confirmed', NULL, 12),
('2025-10-10 06:00:00', 'Negotiation', 18, 'Lawyer mediation ongoing', 2, NULL),
('2025-10-01 09:40:00', 'Negotiation', 12, 'Follow-up on initial demands', 1, 6),
('2025-10-03 13:00:00', 'Evidence', 4, 'Forensics analyzed server boot logs', 3, NULL);

-- =========================
-- STRATEGIC_PLANNING (connect members, missions, channels, police)
-- =========================
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

-- =========================
-- NEGOTIATION / CLAIMS extras (add more interconnectivity)
-- =========================
INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(4,6),(5,2),(6,3),(7,9),(8,11),(9,1),(10,4),(1,3),(3,11),(2,9);

-- Add more CLAIMS for additional hostages
INSERT INTO CLAIMS (police_id, hostage_id) VALUES
(4,15),(5,17),(6,18),(7,19),(8,20);

-- =========================
-- Add more EVIDENCE rows (police-specific) to enrich joins
-- =========================
INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES
(3,1,'Data dump from seized laptop', '2025-10-02 10:00:00','High'),
(4,2,'Bank transfer records showing anomalies', '2025-10-03 16:20:00','High'),
(3,5,'Fragments of coded paper map', '2025-10-06 01:30:00','Medium'),
(2,9,'Drone telemetry log', '2025-10-10 06:10:00','High'),
(3,7,'Call receipt matching supplier schedule','2025-10-07 18:00:00','Medium');

-- Link newly added evidence to missions
INSERT INTO COLLECTED_DURING (police_id, evidence_id, mission_code) VALUES
(1,3,'OP_BLACKOUT'),
(2,4,'OP_SHADOW'),
(5,3,'OP_VAULT'),
(9,2,'OP_ECHO'),
(7,3,'OP_RIVER');

-- =========================
-- FINAL TOUCHES: ensure some hostages can be updated/deleted in tests
-- We'll insert a few additional hostages to act as update/delete targets (if needed)
-- (Note: HOSTAGES auto-increments; these become IDs 21..23)
INSERT INTO HOSTAGES (first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) VALUES
('TestUpdate', NULL, 'Target', 44, 'Pending', 'South', 'Acting Official', 'Low', 2),
('TestDelete', NULL, 'Victim', 39, 'Pending', 'East', 'Clerk', 'Low', 3),
('Integration', NULL, 'Case', 30, 'Pending', 'North', 'Analyst', 'Medium', 1);

-- Also add some more communications referencing these operations
INSERT INTO COMMUNICATION_LOG (timestamp, msg_type, duration, content, police_id, member_id) VALUES
('2025-10-21 10:00:00', 'Internal', 5, 'Prepared update for integration test', 2, NULL),
('2025-10-21 10:05:00', 'Internal', 3, 'Marking item for deletion test', 3, NULL);

-- =========================
-- END OF PART 3
-- This completes the large, highly interconnected dataset.
-- After running Part1, Part2, Part3 successfully, your DB will be ready for complex queries and app testing.
-- =====================================================
