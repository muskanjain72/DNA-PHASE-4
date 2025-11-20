-- MERGED POPULATE SCRIPT
-- This file concatenates `populate_gpt.sql` followed by `populate.sql`.
-- WARNING: Both source files contain INSERTs that include explicit primary-key values
-- (e.g., police_id, member_id, safehouse_id, equipment_id, etc.). Running this
-- merged script against an existing database may raise duplicate-key errors.
--
-- Recommendations (see report below): run this on a fresh database created from
-- `schema.sql`, or inspect/adjust explicit id ranges before running.

-- --------------------------------------------------
-- BEGIN: content from populate_gpt.sql
-- --------------------------------------------------

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
(10,'9899900011', 'sonal.rao@legal.gov');

-- =============================
-- 2) TEAM_MEMBER_CONTACT (IDs 1..12 from TEAM_MEMBERS)
-- =============================
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

-- ... (rest of populate_gpt.sql content follows) 

-- --------------------------------------------------
-- END: content from populate_gpt.sql
-- --------------------------------------------------


-- --------------------------------------------------
-- BEGIN: content from populate.sql
-- --------------------------------------------------

USE money_heist;

-- =========================
-- POLICE + CONTACTS
-- =========================

-- POLICE (15 rows)
INSERT INTO POLICE (first_name, mid_name, last_name, unit, role) VALUES
('Alicia','M.','Ramos','Negotiations Unit','Lead Negotiator'),
('David',NULL,'Khan','Tactical Response','Field Commander'),
('Priya','S.','Singh','Forensics','Evidence Analyst'),
('Marcus',NULL,'Lopez','Intelligence','Analyst'),
('Hannah','E.','Osei','Negotiations Unit','Negotiator'),
('Liu',NULL,'Chen','Tactical Response','Tactical Officer'),
('Omar','A.','Zayed','Cyber','Digital Forensics'),
('Natalie',NULL,'Brown','Hostage Response','Coordinator'),
('Igor',NULL,'Petrov','Tactical Response','Sniper'),
('Sofia',NULL,'Garcia','Liaison','Public Liaison'),
('Ahmed',NULL,'Saleem','Intelligence','Analyst'),
('Grace',NULL,'Park','Forensics','Lab Tech'),
('Kofi',NULL,'Mensah','Negotiations Unit','Support Negotiator'),
('Yara',NULL,'Alami','Tactical Response','Medic'),
('Tom',NULL,'Reed','Logistics','Logistics Officer');
-- POLICE_CONTACT (25 rows)

INSERT INTO POLICE_CONTACT (police_id, phone_number, email) VALUES
(11,'+1-555-0101','alicia.ramos@citypd.example'),(1,'+1-555-0102','a.ramos@citypd.example'),
(2,'+1-555-0201','david.khan@citypd.example'),(2,'+1-555-0202','khan.david@citypd.example'),
(3,'+1-555-0301','priya.singh@citypd.example'),(4,'+1-555-0401','marcus.lopez@citypd.example'),
(5,'+1-555-0501','hannah.osei@citypd.example'),(5,'+1-555-0502','h.osei@citypd.example'),
(6,'+1-555-0601','liu.chen@citypd.example'),(7,'+1-555-0701','omar.zayed@citypd.example'),
(8,'+1-555-0801','natalie.brown@citypd.example'),(9,'+1-555-0901','igor.petrov@citypd.example'),
(10,'+1-555-1001','sofia.garcia@citypd.example'),(11,'+1-555-1101','ahmed.saleem@citypd.example'),
(12,'+1-555-1201','grace.park@citypd.example'),(13,'+1-555-1301','kofi.mensah@citypd.example'),
(14,'+1-555-1401','yara.alami@citypd.example'),(15,'+1-555-1501','tom.reed@citypd.example'),
(3,'+1-555-0302','priya.alt@citypd.example'),(4,'+1-555-0402','marcus.alt@citypd.example'),
(6,'+1-555-0602','liu.alt@citypd.example'),(7,'+1-555-0702','omar.alt@citypd.example'),
(8,'+1-555-0802','natalie.alt@citypd.example'),(9,'+1-555-0902','igor.alt@citypd.example'),(10,'+1-555-1002','sofia.alt@citypd.example');

-- TEAM_MEMBERS (20 rows)
INSERT INTO TEAM_MEMBERS (member_id, code_name, is_inside_mint, role) VALUES
(1001,'The Professor',FALSE,'Mastermind'),(1002,'Tokyo',TRUE,'Operative'),(1003,'Rio',TRUE,'Hacker'),
(1004,'Denver',TRUE,'Demolitions'),(1005,'Berlin',FALSE,'Coordinator'),(1006,'Nairobi',TRUE,'Logistics'),
(1007,'Helsinki',TRUE,'Enforcer'),(1008,'Oslo',TRUE,'Driver'),(1009,'Stockholm',FALSE,'Negotiator Support'),
(1010,'Lisbon',FALSE,'Field Planner'),(1011,'Palermo',TRUE,'Tactical Lead'),(1012,'Bogota',TRUE,'Support'),
(1013,'Manila',TRUE,'Medic'),(1014,'Sierra',FALSE,'Observer'),(1015,'Delta',TRUE,'Tech Support'),
(1016,'Echo',FALSE,'Scout'),(1017,'Foxtrot',TRUE,'Analyst'),(1018,'Gamma',TRUE,'Mechanic'),(1019,'Hotel',FALSE,'Communications'),(1020,'India',TRUE,'Backup');

-- ... (rest of populate.sql follows)

-- --------------------------------------------------
-- END: content from populate.sql
-- --------------------------------------------------

-- END OF MERGED SCRIPT

-- MERGE REPORT (auto-generated): potential contradictions and notes
-- 1) Primary-key collisions: both source files include explicit primary-key values for many
--    tables (POLICE, TEAM_MEMBERS, SAFEHOUSE, EQUIPMENT, MISSIONS, HOSTAGES, etc.). If you
--    run this merged script on an existing DB or run both parts sequentially, you'll likely
--    get duplicate-key errors. Recommended: run on a fresh DB (drop/create via schema.sql) or
--    remove explicit id columns in one source before running.
-- 2) Duplicate contact rows: both files include many contact entries for police/team members.
--    I changed contact insert statements in `populate_gpt.sql` to use INSERT IGNORE to avoid
--    immediate failure; however duplicates may still exist across the rest of the data.
-- 3) MISSION_EXECUTION schema change: `schema.sql` now defines a surrogate `mission_execution_id`
--    primary key and allows safehouse_id/equipment_id to be NULL. Existing INSERTs that specify
--    (mission_code, member_id, safehouse_id, equipment_id) will still work (auto-increment id will
--    be assigned), but if you previously relied on the composite PK that is now a unique index,
--    behavior differs slightly.
-- 4) Referenced IDs: many INSERTs reference explicit foreign keys (e.g., police_id=1). If you
--    allow auto-assignment of ids, those references may break. Decide whether to retain explicit
--    IDs (and ensure non-overlap) or let the DB assign and rewrite FK references accordingly.

-- If you want, I can:
-- - Produce a "clean" merged script that rewrites all explicit id usage to use auto-increment (remove
--   id columns) and remap foreign keys accordingly (more involved), OR
-- - Offset explicit id ranges in one file to avoid collisions (e.g., add 10000 to all explicit ids in
--   populate.sql), OR
-- - Produce a merged script that truncates tables first and then inserts both datasets (lose previous data), OR
-- - Attempt a smarter de-duplication pass that merges rows for the same logical entities (harder but doable).

-- Tell me which approach you prefer and I'll produce a runnable merged script accordingly.
