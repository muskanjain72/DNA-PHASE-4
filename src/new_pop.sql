-- Populate the money_heist database with realistic correlated sample data
USE money_heist;

-- 1) POLICE (15 rows)
INSERT INTO POLICE (police_id, first_name, mid_name, last_name, unit, role) VALUES
(1,'Alicia',NULL,'Moreno','Negotiations Unit','Senior Negotiator'),
(2,'Rajat','K.','Singh','Tactical Unit','Field Commander'),
(3,'Meera',NULL,'Patel','Intelligence','Analyst'),
(4,'David',NULL,'Lopez','Forensics','Investigator'),
(5,'Hannah',NULL,'Khan','Negotiations Unit','Negotiator'),
(6,'Omar',NULL,'Hussain','Tactical Unit','Sniper Lead'),
(7,'Priya',NULL,'Bose','Logistics','Coordinator'),
(8,'Liam',NULL,'Turner','Forensics','Technician'),
(9,'Sofia',NULL,'Garcia','Intelligence','Field Analyst'),
(10,'Noah',NULL,'Reed','Special Ops','Team Lead'),
(11,'Imran',NULL,'Qureshi','Negotiations Unit','Support Negotiator'),
(12,'Eva',NULL,'Martinez','Field Ops','Liaison'),
(13,'Carlos',NULL,'Dominguez','Tactical Unit','Breacher'),
(14,'Yuki',NULL,'Sato','Cyber','Digital Forensics'),
(15,'Maya',NULL,'Sharma','Victim Support','Case Worker');

-- 2) POLICE_CONTACT (15 rows)
INSERT INTO POLICE_CONTACT (police_id, phone_number, email) VALUES
(1,'+91-9000010001','alicia.moreno@pd.example'),
(2,'+91-9000010002','rajat.singh@pd.example'),
(3,'+91-9000010003','meera.patel@pd.example'),
(4,'+91-9000010004','david.lopez@pd.example'),
(5,'+91-9000010005','hannah.khan@pd.example'),
(6,'+91-9000010006','omar.hussain@pd.example'),
(7,'+91-9000010007','priya.bose@pd.example'),
(8,'+91-9000010008','liam.turner@pd.example'),
(9,'+91-9000010009','sofia.garcia@pd.example'),
(10,'+91-9000010010','noah.reed@pd.example'),
(11,'+91-9000010011','imran.qureshi@pd.example'),
(12,'+91-9000010012','eva.martinez@pd.example'),
(13,'+91-9000010013','carlos.dominguez@pd.example'),
(14,'+91-9000010014','yuki.sato@pd.example'),
(15,'+91-9000010015','maya.sharma@pd.example');

-- 3) TEAM_MEMBERS (15 rows)
INSERT INTO TEAM_MEMBERS (member_id, code_name, is_inside_mint, role) VALUES
(1,'Tokyo',TRUE,'Inside Operative'),
(2,'Rio',TRUE,'Hacker'),
(3,'Berlin',FALSE,'Second-in-command'),
(4,'Nairobi',TRUE,'Forging Specialist'),
(5,'Denver',TRUE,'Inside Operative'),
(6,'Stockholm',FALSE,'Negotiator Liaison'),
(7,'Helsinki',FALSE,'Heavy Support'),
(8,'Oslo',FALSE,'Driver'),
(9,'Lisbon',FALSE,'Strategist'),
(10,'Moscow',FALSE,'Demolitions'),
(11,'Palermo',FALSE,'Field Planner'),
(12,'Bogota',TRUE,'Inside Support'),
(13,'Marseille',FALSE,'Scout'),
(14,'Bogey',FALSE,'Communications'),
(15,'Denver2',TRUE,'Backup Inside');

-- 4) TEAM_MEMBER_CONTACT (15 rows)
INSERT INTO TEAM_MEMBER_CONTACT (member_id, phone_number, email) VALUES
(1,'+44-7000010001','tokyo@crew.example'),
(2,'+44-7000010002','rio@crew.example'),
(3,'+44-7000010003','berlin@crew.example'),
(4,'+44-7000010004','nairobi@crew.example'),
(5,'+44-7000010005','denver@crew.example'),
(6,'+44-7000010006','stockholm@crew.example'),
(7,'+44-7000010007','helsinki@crew.example'),
(8,'+44-7000010008','oslo@crew.example'),
(9,'+44-7000010009','lisbon@crew.example'),
(10,'+44-7000010010','moscow@crew.example'),
(11,'+44-7000010011','palermo@crew.example'),
(12,'+44-7000010012','bogota@crew.example'),
(13,'+44-7000010013','marseille@crew.example'),
(14,'+44-7000010014','bogey@crew.example'),
(15,'+44-7000010015','denver2@crew.example');

-- 5) CREW (make all 15 members part of CREW for richness)
INSERT INTO CREW (member_id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15);

-- 6) PROFESSOR (assign same members as professors for demo; realistic data can vary)
INSERT INTO PROFESSOR (member_id, professor_name) VALUES
(1,'Sergio Marquina'),(2,'Andres Ramos'),(3,'Andres Ramos'),(4,'Sergio Marquina'),(5,'Sergio Marquina'),
(6,'Sergio Marquina'),(7,'Andres Ramos'),(8,'Andres Ramos'),(9,'Sergio Marquina'),(10,'Andres Ramos'),
(11,'Sergio Marquina'),(12,'Andres Ramos'),(13,'Sergio Marquina'),(14,'Andres Ramos'),(15,'Sergio Marquina');

-- 7) HACKER (make all 15 members hackers so SECURITY_SYSTEM can reference many)
INSERT INTO HACKER (member_id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15);

-- 8) SECURITY_SYSTEM (15 rows) - reference hackers by member_id
INSERT INTO SECURITY_SYSTEM (system_id, system_type, status, location_description, security_level, member_id) VALUES
(1,'CCTV','Active','Mint north entrance camera','High',2),
(2,'Alarm','Active','Vault perimeter alarm','High',4),
(3,'Motion Sensor','Active','Ceiling sensor - printing hall','Medium',6),
(4,'Door Lock','Under Maintenance','Service corridor main door','High',8),
(5,'Biometric Scanner','Active','Vault biometric scanner','High',10),
(6,'Network Monitor','Active','Internal network hub','High',14),
(7,'Thermal Camera','Active','Roof thermal array','Medium',2),
(8,'Glass Break Sensor','Inactive','Lobby windows','Low',3),
(9,'Pressure Pad','Active','Vault access corridor','High',5),
(10,'RFID Checker','Active','Supply entrance','Medium',7),
(11,'Smoke Detector','Active','Server room','Low',11),
(12,'Access Control','Active','Personnel entrance','High',9),
(13,'Intrusion Sensor','Active','Loading bay','Medium',13),
(14,'Laser Grid','Active','Inner vault perimeter','High',12),
(15,'Backup Alarm','Inactive','Secondary alarm panel','Low',1);

-- 9) SAFEHOUSE (15 rows)
INSERT INTO SAFEHOUSE (safehouse_id, capacity, security_level, is_active, street, city, code) VALUES
(1,6,'High',TRUE,'Baker Street','London',1001),
(2,4,'Medium',TRUE,'Fleet Lane','London',1002),
(3,8,'High',TRUE,'River Road','Lisbon',2001),
(4,5,'Low',TRUE,'Cross Avenue','Madrid',2002),
(5,10,'High',TRUE,'Harbor Drive','Barcelona',2003),
(6,3,'Medium',FALSE,'Stone Alley','Berlin',3001),
(7,7,'High',TRUE,'Old Wharf','Marseille',3002),
(8,2,'Low',TRUE,'Elm Street','Milan',4001),
(9,12,'High',TRUE,'Garden Quay','Amsterdam',4002),
(10,4,'Medium',TRUE,'South Gate','Seville',5001),
(11,6,'High',TRUE,'North Bend','Valencia',5002),
(12,5,'Medium',TRUE,'King Lane','Rome',6001),
(13,4,'Low',TRUE,'East End','Prague',6002),
(14,9,'High',TRUE,'Birch Path','Athens',7001),
(15,8,'Medium',TRUE,'Cedar Road','Istanbul',7002);

-- 10) EQUIPMENT (15 rows) referencing SAFEHOUSE
INSERT INTO EQUIPMENT (equipment_id, total_quantity, equipment_count, curr_location_id) VALUES
(1,10,2,1),(2,5,1,2),(3,20,5,3),(4,3,1,4),(5,8,2,5),(6,15,3,6),(7,4,1,7),(8,6,2,8),(9,2,1,9),(10,12,4,10),(11,7,2,11),(12,9,2,12),(13,11,3,13),(14,1,1,14),(15,18,6,15);

-- 11) SUPPLIER (15 rows)
INSERT INTO SUPPLIER (supplier_id, first_name, mid_name, last_name, reliability_score) VALUES
(1,'Anil',NULL,'Kapur','High'),(2,'Bela',NULL,'Ramos','Medium'),(3,'Chen',NULL,'Wong','High'),(4,'Diego',NULL,'Martins','Low'),(5,'Elena',NULL,'Santos','High'),
(6,'Fahad',NULL,'Ali','Medium'),(7,'Gina',NULL,'Lopez','High'),(8,'Hiro',NULL,'Tanaka','Low'),(9,'Isha',NULL,'Verma','High'),(10,'Jamal',NULL,'Omar','Medium'),
(11,'Karin',NULL,'Lind','High'),(12,'Luca',NULL,'Ferrari','Medium'),(13,'Marta',NULL,'Gomez','Low'),(14,'Nico',NULL,'Silva','High'),(15,'Olga',NULL,'Petrova','Medium');

-- 12) SUPPLIER_CONTACT (15 rows)
INSERT INTO SUPPLIER_CONTACT (supplier_id, phone_number, email) VALUES
(1,'+33-6000010001','anil.kapur@supply.example'),(2,'+33-6000010002','bela.ramos@supply.example'),(3,'+33-6000010003','chen.wong@supply.example'),
(4,'+33-6000010004','diego.martins@supply.example'),(5,'+33-6000010005','elena.santos@supply.example'),(6,'+33-6000010006','fahad.ali@supply.example'),
(7,'+33-6000010007','gina.lopez@supply.example'),(8,'+33-6000010008','hiro.tanaka@supply.example'),(9,'+33-6000010009','isha.verma@supply.example'),
(10,'+33-6000010010','jamal.omar@supply.example'),(11,'+33-6000010011','karin.lind@supply.example'),(12,'+33-6000010012','luca.ferrari@supply.example'),
(13,'+33-6000010013','marta.gomez@supply.example'),(14,'+33-6000010014','nico.silva@supply.example'),(15,'+33-6000010015','olga.petrova@supply.example');

-- 13) EVIDENCE (15 rows) - evidence_id unique + police_id reference
INSERT INTO EVIDENCE (evidence_id, police_id, description, threat_level) VALUES
(1,1,'Handgun recovered near entrance','High'),(2,2,'Fingerprint on vault door','Medium'),(3,3,'Discarded ID card','Low'),(4,4,'Partial DNA swab','High'),(5,5,'Torn map of escape routes','Medium'),
(6,6,'Cut wire from alarm panel','High'),(7,7,'CCTV camera footage copy','Medium'),(8,8,'Encrypted USB drive','High'),(9,9,'Set of bolt cutters','Medium'),(10,10,'Explosive residue swab','High'),
(11,11,'Schedule printout','Low'),(12,12,'Fake passports','High'),(13,13,'Fuel canister','Medium'),(14,14,'Network logs extract','High'),(15,15,'Ransom note','Medium');

-- 14) HOSTAGES (15 rows)
INSERT INTO HOSTAGES (hostage_id, first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) VALUES
(1,'Samuel',NULL,'Edwards',45,'In-Progress','North','Treasury Manager','High',1),
(2,'Asha',NULL,'Nair',39,'Pending','West','Deputy Minister','High',2),
(3,'Luca',NULL,'Moretti',50,'In-Progress','South','Bank Manager','Medium',3),
(4,'Grace',NULL,'Williams',33,'Pending','East','Security Head','High',4),
(5,'Oleg',NULL,'Kozlov',58,'Resolved','North','Senior Accountant','Low',5),
(6,'Rina',NULL,'Kobayashi',29,'In-Progress','West','Clerk','Medium',6),
(7,'Fatima',NULL,'Al-Farsi',42,'Pending','South','Official','High',7),
(8,'Mateo',NULL,'Rossi',36,'In-Progress','East','Supervisor','High',8),
(9,'Zara',NULL,'Ali',27,'Pending','North','Intern','Low',9),
(10,'Jonas',NULL,'Hansen',48,'Resolved','West','Shift Lead','Low',10),
(11,'Priyanka',NULL,'Kaur',34,'In-Progress','South','Analyst','Medium',11),
(12,'Ethan',NULL,'Brown',40,'Pending','East','Procurement','High',12),
(13,'Sara',NULL,'Nguyen',31,'In-Progress','North','Supervisor','Medium',13),
(14,'Omar',NULL,'Farouk',52,'Pending','West','Treasury Official','High',14),
(15,'Lina',NULL,'Gonzalez',28,'In-Progress','East','Receptionist','Medium',15);

-- 15) HOSTAGE_MEDICAL_CONDITION (15 rows) - one condition per hostage
INSERT INTO HOSTAGE_MEDICAL_CONDITION (hostage_id, hostage_ailment) VALUES
(1,'Hypertension'),(2,'Asthma'),(3,'Diabetes'),(4,'Allergy - peanuts'),(5,'None'),(6,'Pregnancy - first trimester'),(7,'Anxiety'),(8,'Knee injury'),(9,'None'),(10,'High cholesterol'),(11,'Fractured wrist'),(12,'Diabetes'),(13,'None'),(14,'Hypertension'),(15,'None');

-- 16) DEPENDENTS (15 rows)
INSERT INTO DEPENDENTS (dependent_id, first_name, mid_name, last_name, hostage_id, relation, age) VALUES
(1,'Maya',NULL,'Edwards',1,'Daughter',12),(2,'Rohit',NULL,'Nair',2,'Son',10),(3,'Giulia',NULL,'Moretti',3,'Daughter',18),
(4,'Tom',NULL,'Williams',4,'Son',8),(5,'Nikolai',NULL,'Kozlov',5,'Spouse',55),(6,'Akiko',NULL,'Kobayashi',6,'Sister',32),(7,'Yusuf',NULL,'Al-Farsi',7,'Son',16),
(8,'Bianca',NULL,'Rossi',8,'Wife',35),(9,'Amina',NULL,'Ali',9,'Mother',50),(10,'Kasper',NULL,'Hansen',10,'Son',20),(11,'Anjali',NULL,'Kaur',11,'Niece',9),
(12,'Olivia',NULL,'Brown',12,'Daughter',14),(13,'Minh',NULL,'Nguyen',13,'Husband',33),(14,'Layla',NULL,'Farouk',14,'Daughter',19),(15,'Diego',NULL,'Gonzalez',15,'Brother',30);

-- 17) MONITORED (15 rows) linking HOSTAGES and SECURITY_SYSTEM
INSERT INTO MONITORED (hostage_id, system_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15);

-- 18) CLAIMS (15 rows) linking POLICE and HOSTAGES
INSERT INTO CLAIMS (police_id, hostage_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15);

-- 19) NEGOTIATES (15 rows) linking POLICE and TEAM_MEMBERS
INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15);

-- 20) MISSION_DETAILS (15 missions)
INSERT INTO MISSION_DETAILS (mission_id, start_time, end_time, stage, zone, description) VALUES
(1,'2025-09-01 08:00:00',NULL,'Ongoing','North','Primary extraction mission'),
(2,'2025-07-15 06:30:00','2025-07-20 18:00:00','Completed','West','Recon and setup'),
(3,'2025-08-05 09:00:00',NULL,'South','Diversion operation'),
(4,'2025-10-11 22:00:00',NULL,'East','Vault access planning'),
(5,'2025-06-01 05:00:00','2025-06-10 12:00:00','Completed','North','Supply runs'),
(6,'2025-11-01 07:00:00',NULL,'West','Communications blackout test'),
(7,'2025-09-20 14:00:00',NULL,'South','Safehouse rotations'),
(8,'2025-10-01 12:00:00',NULL,'East','Network intrusion'),
(9,'2025-05-12 08:00:00','2025-05-12 20:00:00','Completed','North','Training drill'),
(10,'2025-11-10 03:00:00',NULL,'West','Emergency extraction'),
(11,'2025-04-01 10:00:00','2025-04-15 16:00:00','Completed','South','Reconnaissance'),
(12,'2025-08-22 19:00:00',NULL,'East','Logistics re-route'),
(13,'2025-09-30 01:00:00',NULL,'North','Diversion and concealment'),
(14,'2025-07-04 11:00:00','2025-07-09 09:00:00','Completed','West','Equipment procurement'),
(15,'2025-11-05 21:00:00',NULL,'East','Final phase planning');

-- 21) MISSION_IDENTIFIER (15 rows) - unique mission_code per mission
INSERT INTO MISSION_IDENTIFIER (mission_id, mission_code) VALUES
(1,'M-NORTH-001'),(2,'M-WEST-002'),(3,'M-SOUTH-003'),(4,'M-EAST-004'),(5,'M-NORTH-005'),(6,'M-WEST-006'),(7,'M-SOUTH-007'),
(8,'M-EAST-008'),(9,'M-NORTH-009'),(10,'M-WEST-010'),(11,'M-SOUTH-011'),(12,'M-EAST-012'),(13,'M-NORTH-013'),(14,'M-WEST-014'),(15,'M-EAST-015');

-- 22) TIME_DETAILS (15 rows) linking TEAM_MEMBERS and missions
INSERT INTO TIME_DETAILS (member_id, mission_code, timestamp) VALUES
(1,'M-NORTH-001','2025-09-01 08:05:00'),(2,'M-WEST-002','2025-07-15 06:35:00'),(3,'M-SOUTH-003','2025-08-05 09:10:00'),
(4,'M-EAST-004','2025-10-11 22:15:00'),(5,'M-NORTH-005','2025-06-01 05:10:00'),(6,'M-WEST-006','2025-11-01 07:05:00'),
(7,'M-SOUTH-007','2025-09-20 14:10:00'),(8,'M-EAST-008','2025-10-01 12:15:00'),(9,'M-NORTH-009','2025-05-12 08:05:00'),
(10,'M-WEST-010','2025-11-10 03:15:00'),(11,'M-SOUTH-011','2025-04-01 10:05:00'),(12,'M-EAST-012','2025-08-22 19:05:00'),
(13,'M-NORTH-013','2025-09-30 01:10:00'),(14,'M-WEST-014','2025-07-04 11:05:00'),(15,'M-EAST-015','2025-11-05 21:05:00');

-- 23) COLLECTED_DURING (15 rows) linking police, evidence and missions
INSERT INTO COLLECTED_DURING (police_id, evidence_id, mission_code) VALUES
(1,1,'M-NORTH-001'),(2,2,'M-WEST-002'),(3,3,'M-SOUTH-003'),(4,4,'M-EAST-004'),(5,5,'M-NORTH-005'),
(6,6,'M-WEST-006'),(7,7,'M-SOUTH-007'),(8,8,'M-EAST-008'),(9,9,'M-NORTH-009'),(10,10,'M-WEST-010'),
(11,11,'M-SOUTH-011'),(12,12,'M-EAST-012'),(13,13,'M-NORTH-013'),(14,14,'M-WEST-014'),(15,15,'M-EAST-015');

-- 24) COMMUNICATION_LOG (15 rows) - explicitly set channel_id to reference later
INSERT INTO COMMUNICATION_LOG (channel_id, timestamp, msg_type, negotiator_id, duration, content) VALUES
(1,'2025-09-01 09:00:00','Call',1,15,'Initial contact with inside operative'),
(2,'2025-07-16 08:00:00','Text',2,2,'Quick status update'),
(3,'2025-08-06 10:00:00','Video',3,30,'Tactical briefing'),
(4,'2025-10-12 23:00:00','Call',4,45,'Vault access sequencing'),
(5,'2025-06-02 06:00:00','Call',5,10,'Supply drop coordination'),
(6,'2025-11-01 07:30:00','Text',6,1,'Blackout confirmation'),
(7,'2025-09-20 15:00:00','Call',7,20,'Rotation confirmation'),
(8,'2025-10-01 12:45:00','Video',8,40,'Network intrusion live'),
(9,'2025-05-12 09:00:00','Drill',9,60,'Training evaluation'),
(10,'2025-11-10 03:30:00','Call',10,25,'Emergency extraction call'),
(11,'2025-04-02 11:00:00','Report',11,5,'Recon report'),
(12,'2025-08-22 19:30:00','Text',12,1,'Logistics reroute notice'),
(13,'2025-09-30 01:30:00','Call',13,18,'Diversion timing'),
(14,'2025-07-05 12:00:00','Call',14,12,'Procurement followup'),
(15,'2025-11-05 21:30:00','Video',15,50,'Final phase plan review');

-- 25) STRATEGIC_PLANNING (15 rows)
INSERT INTO STRATEGIC_PLANNING (member_id, mission_code, channel_id, police_id) VALUES
(1,'M-NORTH-001',1,1),(2,'M-WEST-002',2,2),(3,'M-SOUTH-003',3,3),(4,'M-EAST-004',4,4),(5,'M-NORTH-005',5,5),
(6,'M-WEST-006',6,6),(7,'M-SOUTH-007',7,7),(8,'M-EAST-008',8,8),(9,'M-NORTH-009',9,9),(10,'M-WEST-010',10,10),
(11,'M-SOUTH-011',11,11),(12,'M-EAST-012',12,12),(13,'M-NORTH-013',13,13),(14,'M-WEST-014',14,14),(15,'M-EAST-015',15,15);

-- 26) EQUIPMENT_SPECIFICATIONS (15 rows)
INSERT INTO EQUIPMENT_SPECIFICATIONS (equipment_id, equipment_type, critical) VALUES
(1,'Rifle','High'),(2,'Decryptor Kit','High'),(3,'Smoke Grenade','Medium'),(4,'Bolt Cutter','Medium'),(5,'Armor Vest','High'),
(6,'Walkie-Talkie','Low'),(7,'Sledgehammer','Medium'),(8,'Drone','High'),(9,'Hacking Stick','High'),(10,'Explosive Charge','High'),
(11,'Surveillance Kit','Medium'),(12,'Fake IDs Kit','High'),(13,'Fuel Canisters','Low'),(14,'Network Tap','High'),(15,'Large Bags','Low');

-- 27) MISSION_EXECUTION (15 rows) linking missions, members, safehouses and equipment
INSERT INTO MISSION_EXECUTION (mission_execution_id, mission_code, member_id, safehouse_id, equipment_id) VALUES
(1,'M-NORTH-001',1,1,1),(2,'M-WEST-002',2,2,2),(3,'M-SOUTH-003',3,3,3),(4,'M-EAST-004',4,4,4),(5,'M-NORTH-005',5,5,5),
(6,'M-WEST-006',6,6,6),(7,'M-SOUTH-007',7,7,7),(8,'M-EAST-008',8,8,8),(9,'M-NORTH-009',9,9,9),(10,'M-WEST-010',10,10,10),
(11,'M-SOUTH-011',11,11,11),(12,'M-EAST-012',12,12,12),(13,'M-NORTH-013',13,13,13),(14,'M-WEST-014',14,14,14),(15,'M-EAST-015',15,15,15);

-- 28) RESOURCE_COORDINATION (15 rows) mapping suppliers, members and safehouses
INSERT INTO RESOURCE_COORDINATION (supplier_id, member_id, safehouse_id) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15);

-- 29) LOOT (15 rows) - ensure stored_in_safehouse_id references SAFEHOUSE
INSERT INTO LOOT (production_date, batch_id, status, amount, stored_in_safehouse_id) VALUES
('2025-06-01',1,'Stored',2500000.00,1),('2025-07-02',2,'Secured',1250000.00,2),('2025-08-03',3,'In-Transit',500000.00,3),
('2025-09-04',4,'Stored',750000.00,4),('2025-05-05',5,'Secured',100000.00,5),('2025-04-06',6,'Stored',300000.00,6),
('2025-03-07',7,'In-Transit',450000.00,7),('2025-02-08',8,'Stored',600000.00,8),('2025-01-09',9,'Stored',900000.00,9),
('2024-12-10',10,'Secured',200000.00,10),('2024-11-11',11,'Stored',1200000.00,11),('2024-10-12',12,'In-Transit',800000.00,12),
('2024-09-13',13,'Stored',430000.00,13),('2024-08-14',14,'Secured',675000.00,14),('2024-07-15',15,'Stored',150000.00,15);

-- 30) EVIDENCE_FOUND_DATE (15 rows)
INSERT INTO EVIDENCE_FOUND_DATE (evidence_id, found_date) VALUES
(1,'2025-09-01'),(2,'2025-07-15'),(3,'2025-08-05'),(4,'2025-10-11'),(5,'2025-06-01'),(6,'2025-11-01'),(7,'2025-09-20'),
(8,'2025-10-01'),(9,'2025-05-12'),(10,'2025-11-10'),(11,'2025-04-01'),(12,'2025-08-22'),(13,'2025-09-30'),(14,'2025-07-04'),(15,'2025-11-05');

-- End of population script
