USE money_heist;

-- =========================
-- POLICE + CONTACTS
-- =========================
INSERT INTO POLICE (police_id, first_name, mid_name, last_name, unit, role) VALUES
(1, 'Alicia', 'M.', 'Ramos', 'Negotiations Unit', 'Lead Negotiator'),
(2, 'David', NULL, 'Khan', 'Tactical Response', 'Field Commander'),
(3, 'Priya', 'S.', 'Singh', 'Forensics', 'Evidence Analyst'),
(4, 'Marcus', NULL, 'Lopez', 'Intelligence', 'Analyst'),
(5, 'Hannah', 'E.', 'Osei', 'Negotiations Unit', 'Negotiator'),
(6, 'Liu', NULL, 'Chen', 'Tactical Response', 'Tactical Officer');

INSERT INTO POLICE_CONTACT (police_id, phone_number, email) VALUES
(1, '+1-555-0101', 'alicia.ramos@citypd.example'),
(1, '+1-555-0102', 'a.ramos@citypd.example'),
(2, '+1-555-0201', 'david.khan@citypd.example'),
(3, '+1-555-0301', 'priya.singh@citypd.example'),
(4, '+1-555-0401', 'marcus.lopez@citypd.example'),
(5, '+1-555-0501', 'hannah.osei@citypd.example');

-- =========================
-- TEAM MEMBERS + ROLES + CONTACTS
-- =========================
INSERT INTO TEAM_MEMBERS (member_id, code_name, is_inside_mint, role) VALUES
(1001, 'The Professor', FALSE, 'Mastermind'),
(1002, 'Tokyo', TRUE, 'Operative'),
(1003, 'Rio', TRUE, 'Hacker'),
(1004, 'Denver', TRUE, 'Demolitions'),
(1005, 'Berlin', FALSE, 'Coordinator'),
(1006, 'Nairobi', TRUE, 'Logistics'),
(1007, 'Helsinki', TRUE, 'Enforcer'),
(1008, 'Oslo', TRUE, 'Driver'),
(1009, 'Stockholm', FALSE, 'Negotiator Support');

INSERT INTO TEAM_MEMBER_CONTACT (member_id, phone_number, email) VALUES
(1001, '+44-7777-1001', 'professor@underground.example'),
(1002, '+44-7777-1002', 'tokyo@underground.example'),
(1003, '+44-7777-1003', 'rio@underground.example'),
(1004, '+44-7777-1004', 'denver@underground.example'),
(1006, '+44-7777-1006', 'nairobi@underground.example'),
(1007, '+44-7777-1007', 'helsinki@underground.example');

INSERT INTO CREW (member_id) VALUES (1002),(1003),(1004),(1005),(1006),(1007),(1008);
INSERT INTO PROFESSOR (member_id, professor_name) VALUES (1001, 'Sergio Marquina');
INSERT INTO HACKER (member_id) VALUES (1003);

-- =========================
-- SUPPLIERS + CONTACTS
-- =========================
INSERT INTO SUPPLIER (supplier_id, first_name, mid_name, last_name, reliability_score) VALUES
(4001, 'Luis', NULL, 'Gomez', 'High'),
(4002, 'Maya', 'R.', 'Fernandez', 'Medium'),
(4003, 'Omar', NULL, 'Kavak', 'Low');

INSERT INTO SUPPLIER_CONTACT (supplier_id, phone_number, email) VALUES
(4001, '+34-600-440-001', 'luis.gomez@supply.example'),
(4002, '+34-600-440-002', 'maya.fernandez@supply.example'),
(4003, '+90-530-220-003', 'omar.kavak@supply.example');

-- =========================
-- SAFEHOUSES
-- =========================
INSERT INTO SAFEHOUSE (safehouse_id, capacity, security_level, is_active, street, city, code) VALUES
(10, 6, 'High', TRUE, '24 River Lane', 'Lisbon', 9021),
(11, 4, 'Medium', TRUE, '8 Old Harbor', 'Lisbon', 9022),
(12, 3, 'Low', TRUE, '3 Market Alley', 'Porto', 9023),
(13, 8, 'High', FALSE, '100 North Quay', 'Lisbon', 9024);

-- =========================
-- EQUIPMENT + LOCATION
-- =========================
INSERT INTO EQUIPMENT (equipment_id, equipment_type, total_quantity, criticality_level) VALUES
(2001, 'Encrypted Radio', 6, 'High'),
(2002, 'Hydraulic Drill', 2, 'High'),
(2003, 'Laptop (Secure)', 5, 'Medium'),
(2004, 'Portable Generator', 2, 'Medium'),
(2005, 'Gas Mask', 12, 'Low'),
(2006, 'Grappling Hook', 4, 'Low');

INSERT INTO EQUIPMENT_LOCATION (equipment_id, safehouse_id, quantity) VALUES
(2001, 10, 4),
(2001, 11, 2),
(2002, 10, 2),
(2003, 11, 3),
(2003, 10, 2),
(2004, 12, 1),
(2005, 10, 6),
(2005, 11, 6),
(2006, 13, 4);

-- =========================
-- MISSIONS
-- =========================
INSERT INTO MISSIONS (mission_id, mission_code, start_time, end_time, stage, zone, description) VALUES
(9001, 'M001', '2025-11-01 06:00:00', NULL, 'Planned', 'Central Bank', 'Recon and infiltration of central bank vault'),
(9002, 'M002', '2025-10-20 22:30:00', '2025-10-21 04:00:00', 'Completed', 'Mint Facility', 'Extraction of targeted assets'),
(9003, 'M003', '2025-09-05 03:00:00', '2025-09-05 07:30:00', 'Completed', 'Art Gallery', 'Diversion and distraction operation'),
(9004, 'M004', '2025-12-15 01:00:00', NULL, 'Planned', 'Armored Transport', 'Intercept armored convoy');

-- =========================
-- EVIDENCE + COLLECTION
-- =========================
INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES
(5001, 3, 'Piece of torn map with safehouse coordinates', '2025-10-22 09:15:00', 'Medium'),
(5002, 1, 'Fragment of encrypted USB', '2025-10-21 02:40:00', 'High'),
(5003, 2, 'Unknown keycard recovered offsite', '2025-10-25 12:00:00', 'Low'),
(5004, 4, 'Discarded handgun with partial serial', '2025-09-06 13:10:00', 'High'),
(5005, 5, 'Receipt from hardware store (large drill)', '2025-09-04 10:25:00', 'Medium');

INSERT INTO COLLECTED_DURING (police_id, evidence_id, mission_code) VALUES
(3, 5001, 'M002'),
(1, 5002, 'M002'),
(2, 5003, 'M003'),
(4, 5004, 'M003');

-- =========================
-- HOSTAGES + MEDICAL + DEPENDENTS
-- =========================
INSERT INTO HOSTAGES (hostage_id, first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) VALUES
(3001, 'Carlos', NULL, 'Matos', 48, 'In-Progress', 'Vault A', 'Treasury Manager', 'High', 2),
(3002, 'Rita', 'L.', 'Silva', 38, 'Pending', 'Lobby', NULL, 'Medium', 1),
(3003, 'Joaquim', NULL, 'Pereira', 52, 'Resolved', 'Executive Office', 'Central Bank Director', 'High', 4),
(3004, 'Elena', NULL, 'Costa', 29, 'In-Progress', 'Main Hall', NULL, 'Medium', 5);

INSERT INTO HOSTAGE_MEDICAL_CONDITION (hostage_id, hostage_ailment) VALUES
(3001, 'Hypertension'),
(3001, 'Diabetes Type II'),
(3002, 'Asthma'),
(3004, 'Pregnancy (2nd trimester)');

INSERT INTO DEPENDENTS (dependent_id, first_name, mid_name, last_name, hostage_id, relation, age) VALUES
(7001, 'Ana', NULL, 'Matos', 3001, 'Daughter', 22),
(7002, 'Lucia', NULL, 'Silva', 3002, 'Spouse', 40),
(7003, 'Mateo', NULL, 'Pereira', 3003, 'Son', 18);

-- =========================
-- SECURITY SYSTEMS + MONITORED
-- =========================
INSERT INTO SECURITY_SYSTEM (system_id, system_type, status, location_description, security_level, member_id) VALUES
(8001, 'CCTV Cluster', 'Active', 'Main atrium & periphery', 'High', 1003),
(8002, 'Vault Sensors', 'Active', 'Inner vault perimeter', 'High', NULL),
(8003, 'RFID Access Panel', 'Under Maintenance', 'Employee entrance', 'Medium', 1003);

INSERT INTO MONITORED (hostage_id, system_id) VALUES
(3001, 8002),
(3002, 8001),
(3004, 8001);

-- =========================
-- CLAIMS & NEGOTIATIONS
-- =========================
INSERT INTO CLAIMS (police_id, hostage_id) VALUES
(2, 3001),
(1, 3002),
(4, 3003);

INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(1, 1001),
(1, 1005),
(5, 1009);

-- =========================
-- COMMUNICATIONS + PLANNING
-- =========================
INSERT INTO COMMUNICATION_LOG (channel_id, timestamp, msg_type, negotiator_id, duration, content) VALUES
(6001, '2025-11-02 14:05:00', 'Negotiation Call', 1, 18, 'Initial demands clarified; deadline extended'),
(6002, '2025-11-02 16:20:00', 'Secure Link', 1001, 25, 'Strategic instructions relayed to team'),
(6003, '2025-10-20 23:10:00', 'Tactical Brief', 2, 35, 'Entry conditions and shift timings discussed'),
(6004, '2025-09-05 04:00:00', 'Field Report', 4, 12, 'Evidence catalogued and suspect movement logged');

INSERT INTO STRATEGIC_PLANNING (planning_id, member_id, mission_code, channel_id, timestamp, police_id) VALUES
(NULL, 1001, 'M001', 6002, '2025-11-02 16:20:00', 1),
(NULL, 1005, 'M002', 6003, '2025-10-20 23:00:00', 1),
(NULL, 1006, 'M002', 6003, '2025-10-20 23:05:00', 2),
(NULL, 1003, 'M003', 6004, '2025-09-05 04:05:00', 4);

-- =========================
-- RESOURCE COORDINATION
-- =========================
INSERT INTO RESOURCE_COORDINATION (supplier_id, member_id, safehouse_id) VALUES
(4001, 1004, 10),
(4002, 1002, 11),
(4001, 1006, 10),
(4003, 1007, 13);

-- =========================
-- MISSION EXECUTION
-- =========================
INSERT INTO MISSION_EXECUTION (execution_id, mission_code, member_id, safehouse_id, equipment_id) VALUES
(NULL, 'M002', 1002, 11, 2003),
(NULL, 'M001', 1003, 10, 2001),
(NULL, 'M003', 1004, 12, 2002),
(NULL, 'M002', 1006, 10, 2005);

-- =========================
-- LOOT
-- =========================
INSERT INTO LOOT (production_date, batch_id, status, amount, stored_in_safehouse_id) VALUES
('2025-10-20', 11001, 'Secured', 1250000.00, 11),
('2025-10-19', 11002, 'Stored', 430000.00, 10),
('2025-09-05', 11003, 'In-Transit', 75000.00, 12);

-- =========================
-- ADDITIONAL NEGATIVE / EDGE CASE ROWS
-- - Evidence not linked to mission
-- - Team member without contacts
-- - Safehouse deactivated (13) with equipment present
-- =========================
INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES
(5010, 6, 'Unregistered SIM card', '2025-11-10 08:00:00', 'Low');

INSERT INTO TEAM_MEMBER_CONTACT (member_id, phone_number, email) VALUES
(1009, '+44-7777-1009', 'stockholm@underground.example');

-- keep one team member (1008) intentionally without contact row to allow negative-join tests

COMMIT;
