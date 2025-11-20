USE money_heist;

-- =========================
-- POLICE + CONTACTS
-- =========================

-- POLICE (15 rows)
INSERT INTO POLICE (police_id, first_name, mid_name, last_name, unit, role) VALUES
(10001,'Alicia','M.','Ramos','Negotiations Unit','Lead Negotiator'),
(10002,'David',NULL,'Khan','Tactical Response','Field Commander'),
(10003,'Priya','S.','Singh','Forensics','Evidence Analyst'),
(10004,'Marcus',NULL,'Lopez','Intelligence','Analyst'),
(10005,'Hannah','E.','Osei','Negotiations Unit','Negotiator'),
(10006,'Liu',NULL,'Chen','Tactical Response','Tactical Officer'),
(10007,'Omar','A.','Zayed','Cyber','Digital Forensics'),
(10008,'Natalie',NULL,'Brown','Hostage Response','Coordinator'),
(10009,'Igor',NULL,'Petrov','Tactical Response','Sniper'),
(10010,'Sofia',NULL,'Garcia','Liaison','Public Liaison'),
(10011,'Ahmed',NULL,'Saleem','Intelligence','Analyst'),
(10012,'Grace',NULL,'Park','Forensics','Lab Tech'),
(10013,'Kofi',NULL,'Mensah','Negotiations Unit','Support Negotiator'),
(10014,'Yara',NULL,'Alami','Tactical Response','Medic'),
(10015,'Tom',NULL,'Reed','Logistics','Logistics Officer');

-- POLICE_CONTACT (25 rows)
INSERT INTO POLICE_CONTACT (police_id, phone_number, email) VALUES
(10001,'+1-555-0101','alicia.ramos@citypd.example'),(10001,'+1-555-0102','a.ramos@citypd.example'),
(10002,'+1-555-0201','david.khan@citypd.example'),(10002,'+1-555-0202','khan.david@citypd.example'),
(10003,'+1-555-0301','priya.singh@citypd.example'),(10004,'+1-555-0401','marcus.lopez@citypd.example'),
(10005,'+1-555-0501','hannah.osei@citypd.example'),(10005,'+1-555-0502','h.osei@citypd.example'),
(10006,'+1-555-0601','liu.chen@citypd.example'),(10007,'+1-555-0701','omar.zayed@citypd.example'),
(10008,'+1-555-0801','natalie.brown@citypd.example'),(10009,'+1-555-0901','igor.petrov@citypd.example'),
(10010,'+1-555-1001','sofia.garcia@citypd.example'),(10011,'+1-555-1101','ahmed.saleem@citypd.example'),
(10012,'+1-555-1201','grace.park@citypd.example'),(10013,'+1-555-1301','kofi.mensah@citypd.example'),
(10014,'+1-555-1401','yara.alami@citypd.example'),(10015,'+1-555-1501','tom.reed@citypd.example'),
(10003,'+1-555-0302','priya.alt@citypd.example'),(10004,'+1-555-0402','marcus.alt@citypd.example'),
(10006,'+1-555-0602','liu.alt@citypd.example'),(10007,'+1-555-0702','omar.alt@citypd.example'),
(10008,'+1-555-0802','natalie.alt@citypd.example'),(10009,'+1-555-0902','igor.alt@citypd.example'),(10010,'+1-555-1002','sofia.alt@citypd.example');

-- TEAM_MEMBERS (20 rows)
INSERT INTO TEAM_MEMBERS (member_id, code_name, is_inside_mint, role) VALUES
(11001,'The Professor',FALSE,'Mastermind'),(11002,'Tokyo',TRUE,'Operative'),(11003,'Rio',TRUE,'Hacker'),
(11004,'Denver',TRUE,'Demolitions'),(11005,'Berlin',FALSE,'Coordinator'),(11006,'Nairobi',TRUE,'Logistics'),
(11007,'Helsinki',TRUE,'Enforcer'),(11008,'Oslo',TRUE,'Driver'),(11009,'Stockholm',FALSE,'Negotiator Support'),
(11010,'Lisbon',FALSE,'Field Planner'),(11011,'Palermo',TRUE,'Tactical Lead'),(11012,'Bogota',TRUE,'Support'),
(11013,'Manila',TRUE,'Medic'),(11014,'Sierra',FALSE,'Observer'),(11015,'Delta',TRUE,'Tech Support'),
(11016,'Echo',FALSE,'Scout'),(11017,'Foxtrot',TRUE,'Analyst'),(11018,'Gamma',TRUE,'Mechanic'),(11019,'Hotel',FALSE,'Communications'),(11020,'India',TRUE,'Backup');

-- TEAM_MEMBER_CONTACT (30 rows)
INSERT INTO TEAM_MEMBER_CONTACT (member_id, phone_number, email) VALUES
(11001,'+44-7777-1001','professor@underground.example'),(11002,'+44-7777-1002','tokyo@underground.example'),
(11003,'+44-7777-1003','rio@underground.example'),(11004,'+44-7777-1004','denver@underground.example'),
(11005,'+44-7777-1005','berlin@underground.example'),(11006,'+44-7777-1006','nairobi@underground.example'),
(11007,'+44-7777-1007','helsinki@underground.example'),(11008,'+44-7777-1008','oslo@underground.example'),
(11009,'+44-7777-1009','stockholm@underground.example'),(11010,'+44-7777-1010','lisbon@underground.example'),
(11011,'+44-7777-1011','palermo@underground.example'),(11012,'+44-7777-1012','bogota@underground.example'),
(11013,'+44-7777-1013','manila@underground.example'),(11014,'+44-7777-1014','sierra@underground.example'),
(11015,'+44-7777-1015','delta@underground.example'),(11016,'+44-7777-1016','echo@underground.example'),(11017,'+44-7777-1017','foxtrot@underground.example'),
(11018,'+44-7777-1018','gamma@underground.example'),(11019,'+44-7777-1019','hotel@underground.example'),(11020,'+44-7777-1020','india@underground.example'),
(11003,'+44-7777-1303','rio.alt@underground.example'),(11006,'+44-7777-1306','nairobi.alt@underground.example'),(11002,'+44-7777-1202','tokyo.alt@underground.example'),
(11004,'+44-7777-1204','denver.alt@underground.example'),(11009,'+44-7777-1209','stockholm.alt@underground.example'),(11011,'+44-7777-1211','palermo.alt@underground.example'),
(11015,'+44-7777-1215','delta.alt@underground.example'),(11018,'+44-7777-1218','gamma.alt@underground.example'),(11020,'+44-7777-1220','india.alt@underground.example');

-- CREW (15+ rows)
INSERT INTO CREW (member_id) VALUES
(11002),(11003),(11004),(11005),(11006),(11007),(11008),(11009),(11010),(11011),(11012),(11013),(11014),(11015),(11016);

-- PROFESSOR (15 rows) - map several members as 'professor' roles for testing purposes
INSERT INTO PROFESSOR (member_id, professor_name) VALUES
(11001,'Sergio Marquina'),(11010,'Lucia Varela'),(11011,'Diego Marquez'),(11012,'Helena Costa'),(11013,'Ricardo Alves'),
(11014,'Marta Silva'),(11015,'Antonio Ruiz'),(11016,'Rosa Mendes'),(11017,'Enzo Ricci'),(11018,'Priya Kapoor'),
(11019,'Liam OBrien'),(11020,'Yuki Sato'),(11005,'Berlin Professor'),(11006,'Nairobi Professor'),(11007,'Helsinki Professor');

-- HACKER (15 rows) - map many team members as hackers for testing
INSERT INTO HACKER (member_id) VALUES
(11003),(11015),(11009),(11017),(11018),(11012),(11016),(11002),(11011),(11020),(11014),(11006),(11013),(11010),(11001);

-- SUPPLIERS (15 rows)
INSERT INTO SUPPLIER (supplier_id, first_name, mid_name, last_name, reliability_score) VALUES
(14001,'Luis',NULL,'Gomez','High'),(14002,'Maya','R.','Fernandez','Medium'),(14003,'Omar',NULL,'Kavak','Low'),
(14004,'Sara',NULL,'Mendez','High'),(14005,'Vikram','K.','Patel','Medium'),(14006,'Anna',NULL,'Ivanova','Low'),
(14007,'Juan',NULL,'Torres','High'),(14008,'Leila',NULL,'Khan','Medium'),(14009,'Tom',NULL,'Boyle','Low'),
(14010,'Zoe',NULL,'Keller','High'),(14011,'Igor',NULL,'Smirnov','Medium'),(14012,'Chen',NULL,'Wei','High'),
(14013,'Fatima',NULL,'Nour','Medium'),(14014,'Pedro',NULL,'Santos','Low'),(14015,'Mei',NULL,'Lin','High');

INSERT INTO SUPPLIER_CONTACT (supplier_id, phone_number, email) VALUES
(14001,'+34-600-440-001','luis.gomez@supply.example'),(14002,'+34600440002','maya.fernandez@supply.example'),
(14003,'+90-530-220-003','omar.kavak@supply.example'),(14004,'+133440004','sara.mendez@parts.example'),
(14005,'+91-800-440-005','vikram.patel@parts.example'),(14006,'+7900440006','anna.ivanova@parts.example'),
(14007,'+52-55-440-007','juan.torres@parts.example'),(14008,'+9221440008','leila.khan@parts.example'),
(14009,'+44-20-440-009','tom.boyle@parts.example'),(14010,'+4930440010','zoe.keller@parts.example'),
(14011,'+7-495-440-011','igor.smirnov@parts.example'),(14012,'+8610440012','chen.wei@parts.example'),
(14013,'+212-600-440-013','fatima.nour@parts.example'),(14014,'+35121440014','pedro.santos@parts.example'),(14015,'+86-21-440-015','mei.lin@parts.example');

-- SAFEHOUSES (15+ rows)
INSERT INTO SAFEHOUSE (safehouse_id, capacity, security_level, is_active, street, city, code) VALUES
(10010,6,'High',TRUE,'24 River Lane','Lisbon',9021),(10011,4,'Medium',TRUE,'8 Old Harbor','Lisbon',9022),(10012,3,'Low',TRUE,'3 Market Alley','Porto',9023),
(10013,8,'High',FALSE,'100 North Quay','Lisbon',9024),(10014,10,'High',TRUE,'1 King Street','Madrid',9025),(10015,5,'Medium',TRUE,'45 Elm Rd','Barcelona',9026),
(10016,7,'High',TRUE,'90 South Pier','Valencia',9027),(10017,2,'Low',TRUE,'7 Side Lane','Coimbra',9028),(10018,4,'Medium',TRUE,'18 Old Mill','Braga',9029),
(10019,6,'High',TRUE,'200 Central Ave','Seville',9030),(10020,3,'Low',TRUE,'66 Baker Street','London',9031),(10021,12,'High',TRUE,'5 Dockside','Marseille',9032),
(10022,8,'Medium',TRUE,'82 Canal Road','Venice',9033),(10023,9,'High',TRUE,'11 Harbour Drive','Genoa',9034),(10024,4,'Low',FALSE,'3 Back Alley','Bilbao',9035);

-- EQUIPMENT (15+ rows) - include equipment_count and curr_location_id as required by schema
INSERT INTO EQUIPMENT (equipment_id, equipment_type, total_quantity, criticality_level, equipment_count, curr_location_id) VALUES
(2001,'Encrypted Radio',6,'High',6,10),(2002,'Hydraulic Drill',3,'High',3,14),(2003,'Laptop (Secure)',8,'Medium',8,11),
(2004,'Portable Generator',4,'Medium',4,12),(2005,'Gas Mask',20,'Low',20,10),(2006,'Grappling Hook',6,'Low',6,16),(2007,'Rope (50m)',10,'Low',10,16),
(2008,'Bolt Cutters',5,'Medium',5,15),(2009,'Night Vision',4,'High',4,21),(2010,'Signal Jammer',2,'High',2,19),(2011,'Portable Safe',2,'Medium',2,23),
(2012,'Thermal Camera',3,'Medium',3,22),(2013,'First Aid Kit',15,'Low',15,20),(2014,'Explosives (dummy)',2,'High',2,14),(2015,'Vehicle (van)',1,'High',1,20);

-- EQUIPMENT_LOCATION (many mappings)
INSERT INTO EQUIPMENT_LOCATION (equipment_id, safehouse_id, quantity) VALUES
(2001,10,4),(2001,11,2),(2002,14,3),(2003,11,4),(2003,10,4),(2004,12,2),(2005,10,10),(2005,15,10),
(2006,16,6),(2007,16,10),(2008,15,5),(2009,21,4),(2010,19,2),(2011,23,2),(2012,22,3),(2013,20,15),(2014,14,2),(2015,20,1);

-- MISSIONS (15 rows)
INSERT INTO MISSIONS (mission_id, mission_code, start_time, end_time, stage, zone, description) VALUES
(9001,'M001','2025-11-01 06:00:00',NULL,'Planned','Central Bank','Recon and infiltration of central bank vault'),
(9002,'M002','2025-10-20 22:30:00','2025-10-21 04:00:00','Completed','Mint Facility','Extraction of targeted assets'),
(9003,'M003','2025-09-05 03:00:00','2025-09-05 07:30:00','Completed','Art Gallery','Diversion and distraction operation'),
(9004,'M004','2025-12-15 01:00:00',NULL,'Planned','Armored Transport','Intercept armored convoy'),
(9005,'M005','2025-08-11 00:30:00','2025-08-11 05:00:00','Completed','Bank Branch','Cash transfer diversion'),
(9006,'M006','2025-07-01 02:00:00','2025-07-01 06:00:00','Failed','Train Depot','Signal disruption test'),
(9007,'M007','2025-06-20 22:00:00','2025-06-21 02:00:00','Completed','Jewelry Store','Decoy operation'),
(9008,'M008','2025-05-14 19:00:00','2025-05-14 22:00:00','Completed','Data Center','Data extraction exercise'),
(9009,'M009','2025-04-10 01:00:00',NULL,'Ongoing','Vault Annex','Ongoing surveillance'),
(9010,'M010','2025-03-12 09:00:00','2025-03-12 12:00:00','Completed','Port Facility','Cargo diversion'),
(9011,'M011','2025-02-01 08:00:00',NULL,'Planned','Diplomatic Wing','Recon mission'),
(9012,'M012','2025-01-15 03:00:00','2025-01-15 07:00:00','Completed','University Vault','Mock exercise'),
(9013,'M013','2024-12-05 00:00:00','2024-12-05 04:00:00','Completed','Museum','Night operation'),
(9014,'M014','2024-11-11 21:00:00','2024-11-12 02:00:00','Completed','Safe Delivery','Transport test'),
(9015,'M015','2025-11-15 04:00:00',NULL,'Planned','Main Square','Crowd distraction');

-- EVIDENCE (15 rows) - note composite primary key (evidence_id, police_id)
INSERT INTO EVIDENCE (evidence_id, police_id, description, found_time, threat_level) VALUES
(5001,3,'Piece of torn map with safehouse coordinates','2025-10-22 09:15:00','Medium'),
(5002,1,'Fragment of encrypted USB','2025-10-21 02:40:00','High'),
(5003,2,'Unknown keycard recovered offsite','2025-10-25 12:00:00','Low'),
(5004,4,'Discarded handgun with partial serial','2025-09-06 13:10:00','High'),
(5005,5,'Receipt from hardware store (large drill)','2025-09-04 10:25:00','Medium'),
(5006,6,'SIM card with foreign carrier','2025-11-10 08:00:00','Low'),
(5007,7,'Partial fingerprint on doorknob','2025-10-01 11:30:00','Medium'),
(5008,8,'Video clip from CCTV','2025-08-21 16:50:00','High'),
(5009,9,'Toolset with serials','2025-07-12 09:20:00','Medium'),
(5010,10,'Anonymous note with threats','2025-06-03 18:00:00','Low'),
(5011,11,'Photograph of suspect vehicle','2025-05-22 13:00:00','Low'),
(5012,12,'Broken radio handset','2025-04-01 02:20:00','Low'),
(5013,13,'Chemical residue on gloves','2025-03-11 07:05:00','High'),
(5014,14,'Map annotations and timings','2025-02-18 10:00:00','Medium'),
(5015,15,'Key fob with access token','2025-01-22 15:40:00','High');

-- COLLECTED_DURING (15 rows linking evidence to missions)
INSERT INTO COLLECTED_DURING (police_id, evidence_id, mission_code) VALUES
(3,5001,'M002'),(1,5002,'M002'),(2,5003,'M003'),(4,5004,'M003'),(5,5005,'M002'),
(6,5006,'M001'),(7,5007,'M005'),(8,5008,'M006'),(9,5009,'M007'),(10,5010,'M008'),
(11,5011,'M009'),(12,5012,'M010'),(13,5013,'M011'),(14,5014,'M012'),(15,5015,'M013');

-- HOSTAGES (15 rows)
INSERT INTO HOSTAGES (hostage_id, first_name, mid_name, last_name, age, status, zone, govt_posn, risk_factor, police_id) VALUES
(3001,'Carlos',NULL,'Matos',48,'In-Progress','Vault A','Treasury Manager','High',2),(3002,'Rita','L.','Silva',38,'Pending','Lobby',NULL,'Medium',1),
(3003,'Joaquim',NULL,'Pereira',52,'Resolved','Executive Office','Central Bank Director','High',4),(3004,'Elena',NULL,'Costa',29,'In-Progress','Main Hall',NULL,'Medium',5),
(3005,'Miguel',NULL,'Santos',41,'Pending','Annex',NULL,'Medium',6),(3006,'Ana',NULL,'Marquez',34,'In-Progress','Vault B','Branch Manager','High',7),
(3007,'Rafael',NULL,'Gomez',45,'Resolved','Lobby South',NULL,'Low',8),(3008,'Bianca',NULL,'Lima',27,'Pending','Office 3',NULL,'Medium',9),
(3009,'Diego',NULL,'Ribeiro',36,'In-Progress','Security Room','Head of Security','High',10),(3010,'Mariana',NULL,'Pinto',30,'Pending','Reception',NULL,'Low',11),
(3011,'Felipe',NULL,'Costa',55,'Resolved','Board Room','Board Member','High',12),(3012,'Laura',NULL,'Rocha',22,'Pending','Cafeteria',NULL,'Low',13),
(3013,'Andre',NULL,'Nogueira',60,'In-Progress','Manager Suite','Ops Manager','High',14),(3014,'Sofia',NULL,'Moraes',33,'Pending','Vault Corridor',NULL,'Medium',15),(3015,'Pedro',NULL,'Alves',44,'In-Progress','Loading Dock',NULL,'High',1);

-- HOSTAGE_MEDICAL_CONDITION (15+ rows)
INSERT INTO HOSTAGE_MEDICAL_CONDITION (hostage_id, hostage_ailment) VALUES
(3001,'Hypertension'),(3001,'Diabetes Type II'),(3002,'Asthma'),(3003,'None'),(3004,'Pregnancy (2nd trimester)'),
(3005,'None'),(3006,'High blood pressure'),(3007,'None'),(3008,'Anemia'),(3009,'Knee injury'),
(3010,'None'),(3011,'Heart condition'),(3012,'Peanut allergy'),(3013,'None'),(3014,'Migraines'),(3015,'None');

-- DEPENDENTS (15+ rows)
INSERT INTO DEPENDENTS (dependent_id, first_name, mid_name, last_name, hostage_id, relation, age) VALUES
(7001,'Ana',NULL,'Matos',3001,'Daughter',22),(7002,'Lucia',NULL,'Silva',3002,'Spouse',40),(7003,'Mateo',NULL,'Pereira',3003,'Son',18),
(7004,'Rosa',NULL,'Costa',3004,'Mother',58),(7005,'Luis',NULL,'Santos',3005,'Brother',38),(7006,'Carla',NULL,'Marquez',3006,'Daughter',12),
(7007,'Joao',NULL,'Gomez',3007,'Son',20),(7008,'Paula',NULL,'Lima',3008,'Spouse',29),(7009,'Bruno',NULL,'Ribeiro',3009,'Son',8),
(7010,'Ines',NULL,'Pinto',3010,'Daughter',5),(7011,'Ricardo',NULL,'Costa',3011,'Son',30),(7012,'Marta',NULL,'Rocha',3012,'Mother',49),
(7013,'Beatriz',NULL,'Nogueira',3013,'Daughter',25),(7014,'Daniel',NULL,'Moraes',3014,'Husband',35),(7015,'Rui',NULL,'Alves',3015,'Son',16);

-- SECURITY_SYSTEM (15+ rows)
INSERT INTO SECURITY_SYSTEM (system_id, system_type, status, location_description, security_level, member_id) VALUES
(8001,'CCTV Cluster','Active','Main atrium & periphery','High',1003),(8002,'Vault Sensors','Active','Inner vault perimeter','High',NULL),(8003,'RFID Panel','Under Maintenance','Employee entrance','Medium',1003),
(8004,'Motion Detector','Active','Corridor A','High',1011),(8005,'Infrared Grid','Active','Vault Outer','High',1009),(8006,'Door Lock Controller','Inactive','Service Entrance','Medium',NULL),
(8007,'Alarm Panel','Active','Security Office','High',1015),(8008,'Pressure Sensors','Active','Vault Floor','High',1003),(8009,'Acoustic Sensors','Active','Ceiling tiles','Medium',NULL),
(8010,'Glass Break','Active','Lobby Windows','Low',NULL),(8011,'Perimeter Fence','Active','Exterior','High',NULL),(8012,'Biometric Scanner','Under Maintenance','Vault Door','High',1009),
(8013,'Network Monitor','Active','Server Room','High',1015),(8014,'Power Monitor','Active','Main Panel','Medium',1012),(8015,'Local Recorder','Active','CCTV Rack','Medium',1003);

-- MONITORED (15+ rows)
INSERT INTO MONITORED (hostage_id, system_id) VALUES
(3001,8002),(3002,8001),(3003,8005),(3004,8001),(3005,8008),(3006,8008),(3007,8009),(3008,8010),(3009,8011),(3010,8004),(3011,8012),(3012,8013),(3013,8014),(3014,8015),(3015,8002);

-- CLAIMS (15+ rows)
INSERT INTO CLAIMS (police_id, hostage_id) VALUES
(2,3001),(1,3002),(4,3003),(5,3004),(6,3005),(7,3006),(8,3007),(9,3008),(10,3009),(11,3010),(12,3011),(13,3012),(14,3013),(15,3014),(1,3015);

-- NEGOTIATES (15 rows)
INSERT INTO NEGOTIATES (police_id, member_id) VALUES
(1,1001),(1,1005),(5,1009),(2,1002),(3,1003),(6,1011),(7,1006),(8,1004),(9,1012),(10,1010),(11,1013),(12,1014),(13,1015),(14,1007),(15,1008);

-- COMMUNICATION_LOG (15+ rows)
INSERT INTO COMMUNICATION_LOG (channel_id, timestamp, msg_type, negotiator_id, duration, content, police_id, member_id) VALUES
(6001,'2025-11-02 14:05:00','Negotiation Call',1,18,'Initial demands clarified; deadline extended',1,1001),
(6002,'2025-11-02 16:20:00','Secure Link',1001,25,'Strategic instructions relayed to team',NULL,1001),
(6003,'2025-10-20 23:10:00','Tactical Brief',2,35,'Entry conditions and shift timings discussed',2,1011),
(6004,'2025-09-05 04:00:00','Field Report',4,12,'Evidence catalogued and suspect movement logged',4,1003),
(6005,'2025-08-01 09:00:00','Log Update',3,6,'Forensics upload complete',3,1003),
(6006,'2025-07-21 21:30:00','Surveillance',9,45,'Night watch on target site',9,1007),
(6007,'2025-06-11 11:00:00','Supply Request',15,10,'Need additional gas masks',15,1006),
(6008,'2025-05-05 14:00:00','Transport',10,20,'Van required at 0200 hours',10,1015),
(6009,'2025-04-01 19:00:00','Maintenance',12,30,'Generator service scheduled',12,1014),
(6010,'2025-03-12 08:00:00','Recon',11,16,'Vehicle spotted near gate',11,1010),
(6011,'2025-02-20 22:22:00','Emergency',8,8,'Health incident reported',8,1013),
(6012,'2025-01-10 07:45:00','Planning',13,40,'Revise entry timings',13,1001),
(6013,'2024-12-05 03:30:00','Debrief',14,12,'Operation review',14,1011),
(6014,'2024-11-11 21:15:00','Signal',7,5,'Jammer tested',7,1009),
(6015,'2024-10-01 12:00:00','Misc',5,9,'Miscellaneous notes',5,1005);

-- STRATEGIC_PLANNING (15+ rows)
INSERT INTO STRATEGIC_PLANNING (planning_id, member_id, mission_code, channel_id, timestamp, police_id) VALUES
(NULL,1001,'M001',6002,'2025-11-02 16:20:00',1),(NULL,1005,'M002',6003,'2025-10-20 23:00:00',1),(NULL,1006,'M002',6003,'2025-10-20 23:05:00',2),
(NULL,1003,'M003',6004,'2025-09-05 04:05:00',4),(NULL,1011,'M004',6003,'2025-12-01 10:00:00',2),(NULL,1007,'M005',6006,'2025-07-21 21:35:00',6),
(NULL,1004,'M003',6004,'2025-09-05 04:10:00',4),(NULL,1012,'M006',6006,'2025-05-10 20:00:00',9),(NULL,1013,'M007',6011,'2025-02-20 22:25:00',11),
(NULL,1014,'M008',6009,'2025-04-01 19:05:00',12),(NULL,1002,'M009',6010,'2025-03-12 08:05:00',10),(NULL,1008,'M010',6008,'2025-05-05 14:10:00',10),
(NULL,1009,'M011',6012,'2025-01-10 08:00:00',13),(NULL,1015,'M012',6009,'2025-04-01 19:15:00',12),(NULL,1010,'M013',6013,'2024-12-05 03:35:00',14);

-- RESOURCE_COORDINATION (15+ rows)
INSERT INTO RESOURCE_COORDINATION (supplier_id, member_id, safehouse_id) VALUES
(4001,1004,10),(4002,1002,11),(4001,1006,10),(4003,1007,13),(4004,1010,14),(4005,1006,16),
(4006,1011,15),(4007,1012,21),(4008,1013,22),(4009,1008,20),(4010,1014,23),(4011,1009,19),(4012,1015,11),(4013,1003,12),(4014,1011,13);

-- MISSION_EXECUTION (15+ rows)
INSERT INTO MISSION_EXECUTION (mission_code, member_id, safehouse_id, equipment_id) VALUES
('M002',1002,11,2003),('M001',1003,10,2001),('M003',1004,12,2002),('M002',1006,10,2005),('M004',1011,14,2010),
('M005',1007,15,2008),('M006',1012,16,2006),('M007',1013,21,2009),('M008',1014,22,2012),('M009',1002,19,2010),
('M010',1008,20,2015),('M011',1009,11,2011),('M012',1015,23,2011),('M013',1010,23,2011),('M015',1001,10,2001);

-- LOOT (15+ rows)
INSERT INTO LOOT (production_date, batch_id, status, amount, stored_in_safehouse_id) VALUES
('2025-10-20',11001,'Secured',1250000.00,11),('2025-10-19',11002,'Stored',430000.00,10),('2025-09-05',11003,'In-Transit',75000.00,12),
('2025-08-10',11004,'Stored',50000.00,14),('2025-07-01',11005,'Secured',220000.00,15),('2025-06-20',11006,'Stored',150000.00,16),
('2025-05-15',11007,'In-Transit',80000.00,17),('2025-04-10',11008,'Stored',60000.00,18),('2025-03-03',11009,'Secured',310000.00,19),
('2025-02-02',11010,'Stored',45000.00,20),('2025-01-01',11011,'Secured',910000.00,21),('2024-12-12',11012,'Stored',77000.00,22),
('2024-11-11',11013,'Secured',130000.00,23),('2024-10-10',11014,'In-Transit',25000.00,24),('2024-09-09',11015,'Stored',98000.00,10);

COMMIT;
