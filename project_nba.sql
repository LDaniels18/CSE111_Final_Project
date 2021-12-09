--Phase 2 Database and SQLite Statements (at end of file)
SELECT "CREATING TABLES----------";
/*
    Create the tables in the schema.
*/
.headers on

CREATE TABLE positions( 
    pos_positionkey char(8) not null,
    pos_abbr char(2) not null, -- PG, SG, SF, PF, C
    pos_name char(25) not null
);

CREATE TABLE players( 
    p_playerkey decimal(3,0) not null,
    p_name char(25) not null,
    p_age decimal(2,0) not null,
    p_height decimal(4,2) not null,
    p_weight decimal(3,0) not null,
    p_positionkey varchar(8) not null,
    p_current_teamkey char(25) not null,   -- use this implementation
    p_old_teamkey varchar(100) not null-- p_old_teams char(25) not null       -- use this implementation, might not work must find alternative solution
);

CREATE TABLE teams(
    t_teamkey char(25) not null,
    t_name char(25) not null, 
    t_divisionkey decimal(1,0) not null
    -- t_current_playerkey decimal(3,0) not null,
    -- t_old_playerkey decimal (3,0) not null
);

CREATE TABLE divisions( 
    d_divisionkey decimal(1,0) not null,
    d_name char(25) not null,
    d_conference char(25) not null 
);

CREATE TABLE stats(
    s_ppg decimal(5,2) not null,
    s_rpg decimal(5,2) not null, 
    s_apg decimal(5,2) not null,
    s_spg decimal(5,2) not null,
    s_bpg decimal(5,2) not null,
    s_playerkey decimal(3,0) not null,
    s_teamkey char(25) not null
);

-- CREATE TABLE user( -- user or fan (DONE)
--     u_id decimal(2,0) not null,
--     u_position char(25) not null,
--     u_player char(25) not null,
--     u_division char(25) not null,
--     u_team char(25) not null
-- );

CREATE table admin(
    a_username char(25) not null,
    a_pass char(25) not null
);

.headers off 

SELECT "POPULATING TABLES--------";

/* 
    Populate every table with the appropriate data.
*/
.headers on

-- ADMIN TABLE 
INSERT INTO admin VALUES('lafrance', 'admin_l');
INSERT INTO admin VALUES('richard', 'admin_r');

-- POSITIONS TABLE
INSERT INTO positions VALUES('1', 'PG', 'Point Guard');
INSERT INTO positions VALUES('2', 'SG', 'Shooting Guard');
INSERT INTO positions VALUES('3', 'SF', 'Small Forward');
INSERT INTO positions VALUES('4', 'PF', 'Power Forward');
INSERT INTO positions VALUES('5', 'C', 'Center');

-- TEAMS TABLE
-- ATLANTIC DIVISION
INSERT INTO teams VALUES('1', 'Boston Celtics', 1);
INSERT INTO teams VALUES('2', 'Brooklyn Nets', 1);
INSERT INTO teams VALUES('3', 'New York Knicks', 1);
INSERT INTO teams VALUES('4', 'Philadelphia 76ers', 1);
INSERT INTO teams VALUES('5', 'Toronto Raptors', 1);
-- CENTRAL DIVISION
INSERT INTO teams VALUES('6', 'Chicago Bulls', 2);
INSERT INTO teams VALUES('7', 'Cleveland Cavaliers', 2);
INSERT INTO teams VALUES('8', 'Detroit Pistons', 2);
INSERT INTO teams VALUES('9', 'Indiana Pacers', 2);
INSERT INTO teams VALUES('10', 'Milwaukee Bucks', 2);
-- SOUTHEAST DIVISION
INSERT INTO teams VALUES('11', 'Atlanta Hawks', 3);
INSERT INTO teams VALUES('12', 'Charlotte Hornets', 3);
INSERT INTO teams VALUES('13', 'Miami Heat', 3);
INSERT INTO teams VALUES('14', 'Orlando Magic', 3);
INSERT INTO teams VALUES('15', 'Washington Wizards', 3);
-- NORTHWEST DIVISION
INSERT INTO teams VALUES('16', 'Denver Nuggets', 4);
INSERT INTO teams VALUES('17', 'Minnesota Timberwolves', 4);
INSERT INTO teams VALUES('18', 'Oklahoma City Thunder', 4);
INSERT INTO teams VALUES('19', 'Portland Trail Blazers', 4);
INSERT INTO teams VALUES('20', 'Utah Jazz', 4);
-- PACIFIC DIVISION
INSERT INTO teams VALUES('21', 'Golden State Warriors', 5);
INSERT INTO teams VALUES('22', 'LA Clippers', 5);
INSERT INTO teams VALUES('23', 'Los Angeles Lakers', 5);
INSERT INTO teams VALUES('24', 'Phoenix Suns', 5);
INSERT INTO teams VALUES('25', 'Sacramento Kings', 5);
-- SOUTHWEST DIVISION
INSERT INTO teams VALUES('26', 'Dallas Mavericks', 6);
INSERT INTO teams VALUES('27', 'Houston Rockets', 6);
INSERT INTO teams VALUES('28', 'Memphis Grizzlies', 6);
INSERT INTO teams VALUES('29', 'New Orleans Pelicans', 6);
INSERT INTO teams VALUES('30', 'San Antonio Spurs', 6);

-- DIVSIONS TABLE
INSERT INTO divisions VALUES(1, 'ATLANTIC', 'Eastern Conference'); 
INSERT INTO divisions VALUES(2, 'CENTRAL', 'Eastern Conference'); 
INSERT INTO divisions VALUES(3, 'SOUTHEAST', 'Eastern Conference'); 
INSERT INTO divisions VALUES(4, 'NORTHWEST', 'Western Conference'); 
INSERT INTO divisions VALUES(5, 'PACIFIC', 'Western Conference'); 
INSERT INTO divisions VALUES(6, 'SOUTHWEST', 'Western Conference'); 

-- PLAYERS TABLE
-- BOSTON CELTICS: 1
INSERT INTO players VALUES(1, 'Jaylen Brown', 25, 1.98, 101, 'SG,SF', '1', 'N/A'); 
INSERT INTO players VALUES(2, 'Jayson Tatum', 23, 2.03, 95, 'SF,PF', '1', 'N/A'); 
INSERT INTO players VALUES(3, 'Daniel Theis', 29, 2.06, 111, 'PF,C', '1', '6'); 
INSERT INTO players VALUES(4, 'Tristan Thompson', 30, 2.06, 115, 'PF,C', '1', '7'); 
INSERT INTO players VALUES(5, 'Kemba Walker', 31, 1.83, 83, 'PG', '1', '12'); 
-- BROOKLYN NETS: 2
INSERT INTO players VALUES(6, 'Kevin Durant', 33, 2.08, 108, 'SG,SF,PF', '2', '18,21'); 
INSERT INTO players VALUES(7, 'Blake Griffin', 32, 2.06, 113, 'PF', '2', '8,22'); 
INSERT INTO players VALUES(8, 'James Harden', 32, 1.96, 99, 'PG,SG', '2', '18,27'); 
INSERT INTO players VALUES(9, 'Joe Harris', 30, 1.98, 99, 'SG,SF', '2', '7'); 
INSERT INTO players VALUES(10, 'Kyrie Irving', 29, 1.88, 88, 'PG', '2', '1,7'); 
-- NEW YORK KNICKS: 3
INSERT INTO players VALUES(11, 'RJ Barrett', 21, 1.98, 97, 'SG,SF', '3', 'N/A'); 
INSERT INTO players VALUES(12, 'Reggie Bullock', 30, 1.98, 92, 'SG,SF', '3', '22,24,8,23'); 
INSERT INTO players VALUES(13, 'Taj Gibson', 36, 2.06, 105, 'PF,C', '3', '6,18,17'); 
INSERT INTO players VALUES(14, 'Julius Randle', 26, 2.03, 113, 'PF,C', '3', '23,29'); 
INSERT INTO players VALUES(15, 'Derrick Rose', 33, 1.88, 90, 'PG', '3', '6,7,17,8'); 
-- PHILADELPHIA 76ERS: 4
INSERT INTO players VALUES(16, 'Seth Curry', 31, 1.88, 83, 'PG,SG', '4', '17,7,24,25,26,19');
INSERT INTO players VALUES(17, 'Joel Embiid', 27, 2.13, 127, 'C', '4', 'N/A'); 
INSERT INTO players VALUES(18, 'Danny Green', 34, 1.98, 97, 'SG,SF', '4', '7,30,5,23'); 
INSERT INTO players VALUES(19, 'Tobias Harris', 21, 2.03, 102, 'SF,PF', '4', '10,14,8,22'); 
INSERT INTO players VALUES(20, 'Ben Simmons', 25, 2.11, 108, 'PG', '4', 'N/A'); 
-- TORONTO RAPTORS: 5
INSERT INTO players VALUES(21, 'OG Anunoby', 24, 2.01, 105, 'SF', '5', 'N/A'); 
INSERT INTO players VALUES(22, 'Aron Baynes', 34, 2.08, 117, 'C', '5', '30,8,1,24'); 
INSERT INTO players VALUES(23, 'Kyle Lowry', 35, 1.83, 88, 'PG', '5', '28,27'); 
INSERT INTO players VALUES(24, 'Pascal Siakam', 27, 2.06, 104, 'PF', '5', 'N/A'); 
INSERT INTO players VALUES(25, 'Fred VanVleet', 27, 1.85, 89, 'PG,SG', '5', 'N/A'); 
-- CHICAGO BULLS: 6
INSERT INTO players VALUES(26, 'Wendell Carter Jr.', 22, 2.08, 122, 'C', '6', 'N/A'); 
INSERT INTO players VALUES(27, 'Zack Lavine', 26, 1.96, 90, 'PG,SG', '6', '17'); 
INSERT INTO players VALUES(28, 'Nikola Vucevic', 31, 2.08, 117, 'C', '6', '4,14'); 
INSERT INTO players VALUES(29, 'Coby White', 21, 1.96, 88, 'PG', '6', 'N/A'); 
INSERT INTO players VALUES(30, 'Patrick Williams', 20, 2.01, 97, 'PF', '6', 'N/A'); 
-- CLEVELAND CAVALIERS: 7
INSERT INTO players VALUES(31, 'Jarret Allen', 23, 2.11, 110, 'C', '7', '2'); 
INSERT INTO players VALUES(32, 'Darius Garland', 21, 1.85, 87, 'PG,SG', '7', 'N/A'); 
INSERT INTO players VALUES(33, 'Kevin Love', 33, 2.03, 113, 'PF,C', '7', '17'); 
INSERT INTO players VALUES(34, 'Collin Sexton', 23, 1.85, 86, 'PG,SG', '7', 'N/A'); 
INSERT INTO players VALUES(35, 'Isaac Okoro', 20, 1.96, 102, 'SG,SF', '7', 'N/A'); 
-- DETROIT PISTONS: 8
INSERT INTO players VALUES(36, 'Jerami Grant', 27, 2.03, 95, 'SF,PF', '8', '4,18,16'); 
INSERT INTO players VALUES(37, 'Wayne Ellington', 33, 1.93, 93, 'SG', '8', '17,28,7,26,23,2,13,3'); 
INSERT INTO players VALUES(38, 'Saddiq Bey', 22, 2.01, 97, 'SF', '8', 'N/A'); 
INSERT INTO players VALUES(39, 'Mason Plumlee', 31, 2.11, 115, 'C', '8', '2,16,19'); 
INSERT INTO players VALUES(40, 'Delon Wright', 29, 1.96, 83, 'PG,SG', '8', '5,28'); 
-- INDIANA PACERS: 9
INSERT INTO players VALUES(41, 'Malcom Brogdon', 28, 1.96, 103, 'PG,SG', '9', '10'); 
INSERT INTO players VALUES(42, 'Justin Holiday', 32, 1.98, 81, 'SG,SF', '9', '4,21,11,6,3,28'); 
INSERT INTO players VALUES(43, 'Doug McDermott', 29, 2.01, 102, 'SF,PF', '9', '6,18,3,26'); 
INSERT INTO players VALUES(44, 'Domantas Sabonis', 25, 2.11, 108, 'PF,C', '9', '18'); 
INSERT INTO players VALUES(45, 'Myles Turner', 25, 2.11, 113, 'C', '9', 'N/A'); 
-- MILWAUKEE BUCKS: 10
INSERT INTO players VALUES(46, 'Gianiss Antetokounmpo', 26, 2.11, 109, 'SF,PF', '10', 'N/A'); 
INSERT INTO players VALUES(47, 'Jrue Holiday', 31, 1.90, 92, 'PG,SG', '10', '4,29'); 
INSERT INTO players VALUES(48, 'Brook Lopez', 33, 2.13, 127, 'C', '10', '2,23'); 
INSERT INTO players VALUES(49, 'Khris Middleton', 30, 2.01, 100, 'SG,SF', '10', '8'); 
INSERT INTO players VALUES(50, 'P.J. Tucker', 36, 1.96, 111, 'SG,SF,PF', '10', '5,24,27'); 
-- ATLANTA HAWKS: 11
INSERT INTO players VALUES(51, 'Bogdan Bogdanovic', 29, 1.98, 99, 'SG', '11', '25'); 
INSERT INTO players VALUES(52, 'Clint Capela', 27, 2.08, 108, 'C', '11', '27'); 
INSERT INTO players VALUES(53, 'John Collins', 24, 2.06, 106, 'PF', '11', 'N/A'); 
INSERT INTO players VALUES(54, 'Kevin Heurter', 23, 2.01, 86, 'SG', '11', 'N/A'); 
INSERT INTO players VALUES(55, 'Trae Young', 23, 1.85, 81, 'PG', '11', 'N/A'); 
-- CHARLOTTE HORNETS: 12
INSERT INTO players VALUES(56, 'Lamelo Ball', 20, 1.98, 81, 'PG', '12', 'N/A'); 
INSERT INTO players VALUES(57, 'Devonte Graham', 26, 1.85, 88, 'PG', '12', 'N/A'); 
INSERT INTO players VALUES(58, 'Gordon Hayward', 31, 2.01, 102, 'SF,PF', '12', '1,20'); 
INSERT INTO players VALUES(59, 'Terry Rozier', 27, 1.85, 86, 'PG,SG', '12', '1'); 
INSERT INTO players VALUES(60, 'P.J. Washington', 23, 2.01, 104, 'PF', '12', 'N/A'); 
-- MIAMI HEAT: 13
INSERT INTO players VALUES(61, 'Bam Adebayo', 24, 2.06, 115, 'PF,C', '13', 'N/A'); 
INSERT INTO players VALUES(62, 'Jimmy Butler', 32, 2.01, 104, 'SG,SF', '13', '6,17,4'); 
INSERT INTO players VALUES(63, 'Duncan Robinson', 27, 2.01, 97, 'SG,SF', '13', 'N/A'); 
INSERT INTO players VALUES(64, 'Goran Dragic', 35, 1.90, 86, 'PG,SG', '13', '24,27'); 
INSERT INTO players VALUES(65, 'Tyler Herro', 21, 1.96, 88, 'SG', '13', 'N/A'); 
-- ORLANDO MAGIC: 14
INSERT INTO players VALUES(66, 'Cole Anthony', 21, 1.88, 83, 'PG', '14', 'N/A'); 
INSERT INTO players VALUES(67, 'Evan Fournier', 29, 2.01, 92, 'SG,SF', '14', '16'); 
INSERT INTO players VALUES(68, 'Dwayne Bacon', 26, 1.98, 100, 'SG', '14', '12'); 
INSERT INTO players VALUES(69, 'Mo Bamba', 23, 2.13, 104, 'C', '14', 'N/A'); 
INSERT INTO players VALUES(70, 'Markelle Fultz', 23, 1.90, 94, 'PG,SG', '14', '4'); 
-- WASHINGTON WIZARDS: 15
INSERT INTO players VALUES(71, 'Bradley Beal', 28, 1.90, 93, 'SG', '15', 'N/A'); 
INSERT INTO players VALUES(72, 'Russell Westbrook', 33, 1.90, 90, 'PG', '15', '18,27'); 
INSERT INTO players VALUES(73, 'Rui Hachimura', 23, 2.03, 104, 'PF', '15', 'N/A'); 
INSERT INTO players VALUES(74, 'Davis Bertans', 29, 2.08, 102, 'PF', '15', '30'); 
INSERT INTO players VALUES(75, 'Daniel Gafford', 23, 2.08, 106, 'PF,C', '15', '6'); 
-- DENVER NUGGETS: 16
INSERT INTO players VALUES(76, 'Will Barton', 30, 1.96, 82, 'SF', '16', '19'); 
INSERT INTO players VALUES(77, 'Gary Harris', 27, 1.93, 95, 'SG', '16', 'N/A'); 
INSERT INTO players VALUES(78, 'Nikola Jokić', 26, 2.11, 128, 'C', '16', 'N/A'); 
INSERT INTO players VALUES(79, 'Paul Millsap', 36, 2.01, 116, 'PF', '16', '11,20'); 
INSERT INTO players VALUES(80, 'Jamal Murray', 24, 1.91, 97, 'PG', '16', 'N/A'); 
-- MINNESOTA TIMBERWOLVES: 17
INSERT INTO players VALUES(81, 'Anthony Edwards', 20, 1.93, 102, 'SF', '17', 'N/A'); 
INSERT INTO players VALUES(82, 'Jaden McDaniels', 21, 2.06, 101, 'PF', '17', 'N/A'); 
INSERT INTO players VALUES(83, 'Josh Okogie', 23, 1.93, 96, 'SF', '17', 'N/A'); 
INSERT INTO players VALUES(84, 'Ricky Rubio', 31, 1.91, 86, 'PG', '17', '20,24'); 
INSERT INTO players VALUES(85, 'Karl-Anthony Towns', 26, 2.11, 112, 'C', '17', 'N/A'); 
-- OKLAHOMA CITY THUNDER: 18
INSERT INTO players VALUES(86, 'Darius Bazley', 21, 2.03, 94, 'PF', '18', 'N/A'); 
INSERT INTO players VALUES(87, 'Luguentz Dort', 22, 1.91, 97, 'SG,SF', '18', 'N/A'); 
INSERT INTO players VALUES(88, 'Shai Gilgeous-Alexander', 23, 1.98, 81, 'SG,PG', '18', '22'); 
INSERT INTO players VALUES(89, 'George Hill', 35, 1.93, 85, 'SG,PG', '18', '4,7,9,20,25,30'); 
INSERT INTO players VALUES(90, 'Al Horford', 35, 2.06, 108, 'C', '18', '4,11'); 
-- PORTLAND TRAIL BLAZERS: 19
INSERT INTO players VALUES(91, 'Robert Covington', 25, 2.01, 94, 'SF,PF,C', '19', '4,17,27'); 
INSERT INTO players VALUES(92, 'Damian Lillard', 31, 1.88, 88, 'PG', '19', 'N/A'); 
INSERT INTO players VALUES(93, 'CJ McCollum', 30, 1.90, 86, 'SG', '19', 'N/A'); 
INSERT INTO players VALUES(94, 'Jusuf Nurkić', 27, 2.11, 131, 'C', '19', '16'); 
INSERT INTO players VALUES(95, 'Norman Powell', 28, 1.90, 97, 'SG,SF', '19', '5'); 
-- UTAH JAZZ: 20
INSERT INTO players VALUES(96, 'Bojan Bogdanović', 32, 2.01, 102, 'SF,PF', '20', '2,9,15'); 
INSERT INTO players VALUES(97, 'Mike Conley', 34, 1.85, 79, 'PG', '20', '28'); 
INSERT INTO players VALUES(98, 'Rudy Gobert', 29, 2.16, 117, 'C', '20', 'N/A'); 
INSERT INTO players VALUES(99, 'Donovan Mitchell', 25, 1.85, 97, 'SG,PG', '20', 'N/A'); 
INSERT INTO players VALUES(100, 'Royce O Neale', 28, 1.93, 102, 'SF', '20', 'N/A'); 
-- GOLDEN STATE WARRIORS: 21
INSERT INTO players VALUES(101, 'Stephen Curry', 33, 1.88, 83, 'PG', '21', 'N/A'); 
INSERT INTO players VALUES(102, 'Draymond Green', 31, 1.98, 104, 'SF,PF', '21', 'N/A'); 
INSERT INTO players VALUES(103, 'Kelly Oubre Jr', 25, 1.98, 92, 'SF', '21', '15,24'); 
INSERT INTO players VALUES(104, 'Andrew Wiggins', 26, 2.01, 89, 'SF,PF', '21', '17'); 
INSERT INTO players VALUES(105, 'James Wiseman', 20, 2.13, 108, 'C', '21', 'N/A'); 
-- LA CLIPPERS: 22
INSERT INTO players VALUES(106, 'Nicolas Batum', 32, 2.03, 104, 'SG,SF,PF', '22', '12,19'); 
INSERT INTO players VALUES(107, 'Patrick Beverley', 33, 1.85, 81, 'SG,PG', '22', '27'); 
INSERT INTO players VALUES(108, 'Paul George', 31, 2.03, 99, 'SG,SF', '22', '9,18'); 
INSERT INTO players VALUES(109, 'Serge Ibaka', 32, 2.08, 106, 'C', '22', '5,14,18'); 
INSERT INTO players VALUES(110, 'Kawhi Leonard', 30, 2.01, 102, 'SF', '22', '5,30'); 
-- LOS ANGELES LAKERS: 23
INSERT INTO players VALUES(111, 'Kentavious Caldwell-Pope', 28, 1.96, 92, 'SG', '23', '8'); 
INSERT INTO players VALUES(112, 'Anthony Davis', 28, 208, 114, 'PF,C', '23', '29'); 
INSERT INTO players VALUES(113, 'Marc Gasol', 36, 2.11, 116, 'C', '23', '5,28'); 
INSERT INTO players VALUES(114, 'LeBron James', 36, 2.06, 113, 'SG,SF,PG,PF', '23', '7,13'); 
INSERT INTO players VALUES(115, 'Dennis Schröder', 28, 1.85, 78, 'SG,PG', '23', '11,18'); 
-- PHOENIX SUNS: 24
INSERT INTO players VALUES(116, 'Deandre Ayton', 23, 2.11, 113, 'C', '24', 'N/A'); 
INSERT INTO players VALUES(117, 'Devin Booker', 25, 1.96, 93, 'SG', '24', 'N/A'); 
INSERT INTO players VALUES(118, 'Mikal Bridges', 25, 1.98, 94, 'SF', '24', 'N/A'); 
INSERT INTO players VALUES(119, 'Jae Crowder', 31, 1.98, 106, 'SF,PF', '24', '1,7,13,20,26,28'); 
INSERT INTO players VALUES(120, 'Chris Paul', 28, 1.83, 79, 'PG', '24', '18,22,27'); 
-- SACRAMENTO KINGS: 25
INSERT INTO players VALUES(121, 'Marvin Bagley III', 22, 2.11, 106, 'PF,C', '25', 'N/A'); 
INSERT INTO players VALUES(122, 'Gary Harris', 29, 2.03, 102, 'SF,PF', '25', '21,26'); 
INSERT INTO players VALUES(123, 'De Aaron Fox', 23, 1.90, 83, 'PG', '25', 'N/A'); 
INSERT INTO players VALUES(124, 'Buddy Hield', 28, 1.93, 99, 'SG', '25', '29'); 
INSERT INTO players VALUES(125, 'Richaun Holmes', 28, 2.08, 106, 'PF,C', '25', '4,24'); 
-- DALLAS MAVERICKS: 26
INSERT INTO players VALUES(126, 'Luka Dončić', 22, 2.01, 104, 'SG,PG', '26', 'N/A'); 
INSERT INTO players VALUES(127, 'Dorian Finney-Smith', 28, 2.01, 99, 'SF,PF', '26', 'N/A'); 
INSERT INTO players VALUES(128, 'Maxi Kleber', 29, 2.08, 108, 'PF', '26', 'N/A'); 
INSERT INTO players VALUES(129, 'Kristaps Porziņģis', 26, 2.21, 108, 'PF,C', '26', '3'); 
INSERT INTO players VALUES(130, 'Josh Richardson', 28, 1.96, 90, 'SG,SF', '26', '4,13'); 
-- HOUSTON ROCKETS: 27
INSERT INTO players VALUES(131, 'Kelly Olynyk', 30, 2.11, 108, 'PF,C', '27', '1,13'); 
INSERT INTO players VALUES(132, 'Kevin Porter Jr', 21, 1.93, 92, 'SG,SF,PG', '27', '7'); 
INSERT INTO players VALUES(133, 'Jae Sean Tate', 26, 1.93, 104, 'SF', '27', 'N/A'); 
INSERT INTO players VALUES(134, 'John Wall', 31, 1.90, 95, 'PG', '27', '15'); 
INSERT INTO players VALUES(135, 'Christian Wood', 26, 2.08, 97, 'PF,C', '27', '4,8,10,12,29'); 
-- MEMPHIS GRIZZLIES: 28
INSERT INTO players VALUES(136, 'Grayson Allen', 26, 1.93, 89, 'SG', '28', '20'); 
INSERT INTO players VALUES(137, 'Kyle Anderson', 28, 2.06, 104, 'SF,PF', '28', '30'); 
INSERT INTO players VALUES(138, 'Dillon Brooks', 25, 2.01, 102, 'SG,SF', '28', 'N/A'); 
INSERT INTO players VALUES(139, 'Ja Morant', 22, 1.90, 78, 'PG', '28', 'N/A'); 
INSERT INTO players VALUES(140, 'Jonas Valančiūnas', 29, 2.11, 106, 'C', '28', '5'); 
-- NEW ORLEANS PELICANS: 29
INSERT INTO players VALUES(141, 'Steven Adams', 28, 2.11, 120, 'C', '29', '18'); 
INSERT INTO players VALUES(142, 'Lonzo Ball', 24, 1.98, 86, 'PG', '29', '23'); 
INSERT INTO players VALUES(143, 'Eric Bledsoe', 31, 1.85, 97, 'SG,PG', '29', '10,24'); 
INSERT INTO players VALUES(144, 'Brandon Ingram', 24, 2.03, 86, 'SF,PF', '29', '23'); 
INSERT INTO players VALUES(145, 'Zion Williamson', 21, 2.01, 128, 'PF', '29', 'N/A'); 
-- SAN ANTONIO SPURS: 30 
INSERT INTO players VALUES(146, 'DeMar DeRozan', 32, 1.98, 100, 'SG,SF,PF', '30', '5'); 
INSERT INTO players VALUES(147, 'Keldon Johnson', 22, 1.98, 99, 'SF', '30', 'N/A'); 
INSERT INTO players VALUES(148, 'Dejounte Murray', 25, 1.93, 81, 'PG', '30', 'N/A'); 
INSERT INTO players VALUES(149, 'Jakob Poeltl', 26, 2.16, 111, 'C', '30', '5'); 
INSERT INTO players VALUES(150, 'Derrick White', 27, 1.93, 86, 'SG,PG', '30', 'N/A'); 

-- STATS TABLE
-- Player and Team Stats:
-- starts with the team stats (2020-2021) followed by the starters for that season:
-- BOSTON CELTICS PLAYER/TEAM STATS
INSERT INTO stats VALUES(112.5, 44.3, 23.5, 7.7, 5.3, 000, '1');
INSERT INTO stats VALUES(24.7, 6.0, 3.4, 1.2, 0.6, 1, 'N/A');
INSERT INTO stats VALUES(26.4, 7.4, 4.3, 1.2, 0.5, 2, 'N/A');
INSERT INTO stats VALUES(9.6, 5.5, 1.7, 0.6, 0.9, 3, 'N/A');
INSERT INTO stats VALUES(7.6, 8.1, 1.2, 0.4, 0.6, 4, 'N/A');
INSERT INTO stats VALUES(19.3, 4.0, 4.9, 1.1, 0.3, 5, 'N/A');
-- BROOKLYN NETS PLAYER/TEAM STATS
INSERT INTO stats VALUES(118.6, 44.4, 26.8, 6.7, 5.3, 000, '2');
INSERT INTO stats VALUES(26.9, 7.1, 5.6, 0.7, 1.3, 6, 'N/A');
INSERT INTO stats VALUES(11.0, 4.9, 3.0, 0.7, 0.3, 7, 'N/A');
INSERT INTO stats VALUES(24.6, 10.8, 7.9, 1.2, 0.8, 8, 'N/A');
INSERT INTO stats VALUES(14.1, 3.6, 1.9, 0.7, 0.2, 9, 'N/A');
INSERT INTO stats VALUES(26.9, 6.0, 4.8, 1.4, 0.7, 10, 'N/A');
-- NEW YORK KNICKS PLAYER/TEAM STATS
INSERT INTO stats VALUES(107.0, 45.1, 21.4, 7.0, 5.1, 000, '3');
INSERT INTO stats VALUES(17.6, 5.8, 3.0, 0.7, 0.3, 11, 'N/A');
INSERT INTO stats VALUES(10.9, 3.4, 1.5, 0.8, 0.2, 12, 'N/A');
INSERT INTO stats VALUES(5.4, 5.6, 0.8, 0.7, 1.1, 13, 'N/A');
INSERT INTO stats VALUES(24.1, 10.2, 6.0, 0.9, 0.3, 14, 'N/A');
INSERT INTO stats VALUES(14.7, 2.6, 4.2, 1.0, 0.4, 15, 'N/A');
-- PHILADELPHIA 76ERS PLAYER/TEAM STATS
INSERT INTO stats VALUES(113.6, 45.1, 23.7, 9.1, 6.2, 000, '4');
INSERT INTO stats VALUES(12.5, 2.4, 2.7, 0.8, 0.1, 16, 'N/A');
INSERT INTO stats VALUES(28.5, 10.6, 2.8, 1.0, 1.4, 17, 'N/A');
INSERT INTO stats VALUES(9.5, 3.8, 1.7, 1.3, 0.8, 18, 'N/A');
INSERT INTO stats VALUES(19.5, 6.8, 3.5, 0.9, 0.8, 19, 'N/A');
INSERT INTO stats VALUES(14.3, 7.2, 6.9, 1.6, 0.6, 20, 'N/A');
-- TORONTO RAPTORS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(111.3, 41.6, 24.1, 8.6, 5.4, 000, '5');
INSERT INTO stats VALUES(15.9, 5.5, 2.2, 1.5, 0.7, 21, 'N/A');
INSERT INTO stats VALUES(6.1, 5.2, 0.9, 0.3, 0.4, 22, 'N/A');
INSERT INTO stats VALUES(17.2, 5.4, 7.3, 1.0, 0.3, 23, 'N/A');
INSERT INTO stats VALUES(21.4, 7.2, 4.5, 1.1, 0.7, 24, 'N/A');
INSERT INTO stats VALUES(19.6, 4.2, 6.3, 1.7, 0.7, 25, 'N/A');
-- CHICAGO BULLS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(110.7, 45.0, 26.8, 6.7, 4.2, 000, '6');
INSERT INTO stats VALUES(11.2, 8.2, 1.9, 0.6, 0.8, 26, 'N/A');
INSERT INTO stats VALUES(27.4, 5.0, 4.9, 0.8, 0.5, 27, 'N/A');
INSERT INTO stats VALUES(23.4, 11.7, 3.8, 0.9, 0.7, 28, 'N/A');
INSERT INTO stats VALUES(15.1, 4.1, 4.8, 0.6, 0.2, 29, 'N/A');
INSERT INTO stats VALUES(9.2, 4.6, 1.4, 0.9, 0.6, 30, 'N/A');
-- CLEVELAND CAVALIERS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(103.8, 42.8, 23.8, 7.8, 4.5, 000, '7');
INSERT INTO stats VALUES(12.8, 10.0, 1.7, 0.5, 1.4, 31, 'N/A');
INSERT INTO stats VALUES(17.4, 2.4, 6.1, 1.2, 0.1, 32, 'N/A');
INSERT INTO stats VALUES(12.2, 7.4, 2.5, 0.6, 0.1, 33, 'N/A');
INSERT INTO stats VALUES(24.3, 3.1, 4.4, 1.0, 0.2, 34, 'N/A');
INSERT INTO stats VALUES(9.6, 3.1, 1.9, 0.9, 0.4, 35, 'N/A');
-- DETROIT PISTONS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(106.6, 42.7, 24.2, 7.4, 5.2, 000, '8');
INSERT INTO stats VALUES(22.3, 4.6, 2.8, 0.6, 1.1, 36, 'N/A');
INSERT INTO stats VALUES(9.6, 1.8, 1.5, 0.4, 0.2, 37, 'N/A');
INSERT INTO stats VALUES(12.2, 4.5, 1.4, 0.7, 0.2, 38, 'N/A');
INSERT INTO stats VALUES(10.4, 9.3, 3.6, 0.8, 0.9, 39, 'N/A');
INSERT INTO stats VALUES(10.2, 4.3, 4.4, 1.6, 0.5, 40, 'N/A');
-- INDIANA PACERS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(115.3, 42.7, 27.4, 8.5, 6.4, 000, '9');
INSERT INTO stats VALUES(21.2, 5.3, 5.9, 0.9, 0.3, 41, 'N/A');
INSERT INTO stats VALUES(10.5, 3.6, 1.7, 1.0, 0.6, 42, 'N/A');
INSERT INTO stats VALUES(13.6, 3.2, 1.3, 0.3, 0.1, 43, 'N/A');
INSERT INTO stats VALUES(20.3, 12.0, 6.7, 1.2, 0.5, 44, 'N/A');
INSERT INTO stats VALUES(12.6, 6.5, 1.0, 0.9, 3.4, 45, 'N/A');
-- MILWAUKEE BUCKS PLAYER/TEAM STATS
INSERT INTO stats VALUES(120.1, 48.1, 25.5, 8.1, 4.6, 000, '10');
INSERT INTO stats VALUES(28.1, 11.0, 5.9, 1.2, 1.2, 46, 'N/A');
INSERT INTO stats VALUES(17.7, 4.5, 6.1, 1.6, 0.6, 47, 'N/A');
INSERT INTO stats VALUES(12.3, 5.0, 0.7, 0.6, 1.5, 48, 'N/A');
INSERT INTO stats VALUES(20.4, 6.0, 5.4, 1.1, 0.1, 49, 'N/A');
INSERT INTO stats VALUES(3.7, 3.9, 1.2, 0.8, 0.4, 50, 'N/A');
-- ATLANTA HAWKS PLAYER/TEAM STATS
INSERT INTO stats VALUES(113.7, 45.6, 24.1, 7.0, 4.8, 000, '11');
INSERT INTO stats VALUES(16.4, 3.6, 3.3, 1.1, 0.3, 51, 'N/A');
INSERT INTO stats VALUES(15.2, 14.3, 0.8, 0.7, 2.0, 52, 'N/A');
INSERT INTO stats VALUES(17.6, 7.4, 1.2, 0.5, 1.0, 53, 'N/A');
INSERT INTO stats VALUES(11.9, 3.3, 3.5, 1.2, 0.3, 54, 'N/A');
INSERT INTO stats VALUES(25.3, 3.9, 9.4, 0.8, 0.2, 55, 'N/A');
-- CHARLOTTE HORNETS PLAYER/TEAM STATS
INSERT INTO stats VALUES(109.5, 43.8, 26.8, 7.8, 4.8, 000, '12');
INSERT INTO stats VALUES(15.7, 5.9, 6.1, 1.6, 0.4, 56, 'N/A');
INSERT INTO stats VALUES(14.8, 2.7, 5.4, 0.9, 0.1, 57, 'N/A');
INSERT INTO stats VALUES(19.6, 5.9, 4.1, 1.2, 0.3, 58, 'N/A');
INSERT INTO stats VALUES(20.4, 4.4, 4.2, 1.3, 0.4, 59, 'N/A');
INSERT INTO stats VALUES(12.9, 6.5, 2.5, 1.1, 1.2, 60, 'N/A');
-- MIAMI HEAT PLAYER/TEAM STATS
INSERT INTO stats VALUES(108.1, 41.5, 26.3, 7.9, 4.0, 000, '13');
INSERT INTO stats VALUES(18.7, 9.0, 5.4, 1.2, 1.0, 61, 'N/A');
INSERT INTO stats VALUES(21.5, 6.9, 7.1, 2.1, 0.3, 62, 'N/A');
INSERT INTO stats VALUES(13.1, 3.5, 1.8, 0.6, 0.3, 63, 'N/A');
INSERT INTO stats VALUES(13.4, 3.4, 4.4, 0.7, 0.2, 64, 'N/A');
INSERT INTO stats VALUES(15.1, 5.0, 3.4, 0.6, 0.3, 65, 'N/A');
-- ORLANDO MAGIC PLAYER/TEAM STATS
INSERT INTO stats VALUES(104.0, 45.4, 21.8, 6.9, 4.4, 000, '14');
INSERT INTO stats VALUES(12.9, 4.7, 4.1, 0.6, 0.4, 66, 'N/A');
INSERT INTO stats VALUES(17.1, 3.0, 3.4, 1.1, 0.5, 67, 'N/A');
INSERT INTO stats VALUES(10.9, 3.1, 1.3, 0.6, 0.1, 68, 'N/A');
INSERT INTO stats VALUES(8.0, 5.8, 0.8, 0.3, 1.3, 69, 'N/A');
INSERT INTO stats VALUES(12.9, 3.1, 5.4, 1.0, 0.3, 70, 'N/A');
-- WASHINGTON WIZARDS PLAYER STATS
INSERT INTO stats VALUES(116.6, 45.2, 25.5, 7.3, 4.1, 000, '15');
INSERT INTO stats VALUES(31.3, 4.7, 4.4, 1.2, 0.4, 71, 'N/A');
INSERT INTO stats VALUES(22.2, 11.5, 11.7, 1.4, 0.4, 72, 'N/A');
INSERT INTO stats VALUES(13.8, 5.5, 1.4, 0.8, 0.1, 73, 'N/A');
INSERT INTO stats VALUES(11.5, 2.9, 0.9, 0.6, 0.2, 74, 'N/A');
INSERT INTO stats VALUES(7.0, 4.3, 0.5, 0.5, 1.4, 75, 'N/A');
-- DENVER NUGGETS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(115.1, 44.4, 26.8, 4.5, 8.1, 000, '16');
INSERT INTO stats VALUES(12.7, 4.0, 3.2, 0.4, 0.9, 76, 'N/A');
INSERT INTO stats VALUES(9.9, 2.0, 2.0, 0.3, 0.7, 77, 'N/A');
INSERT INTO stats VALUES(26.4, 10.8, 8.3, 0.7, 1.3, 78, 'N/A');
INSERT INTO stats VALUES(9.0, 4.7, 1.8, 0.6, 0.9, 79, 'N/A');
INSERT INTO stats VALUES(21.2, 4.0, 4.8, 1.3, 1.3, 80, 'N/A');
-- MINNESOTA TIMBERWOLVES PLAYERS/TEAM STATS
INSERT INTO stats VALUES(112.1, 43.5, 25.6, 5.5, 8.8, 000, '17');
INSERT INTO stats VALUES(19.3, 4.7, 2.9, 0.5, 1.1, 81, 'N/A');
INSERT INTO stats VALUES(6.8, 3.7, 1.1, 1.0, 0.6, 82, 'N/A');
INSERT INTO stats VALUES(5.4, 2.6, 1.1, 0.5, 0.9, 83, 'N/A');
INSERT INTO stats VALUES(8.6, 3.3, 6.4, 0.1, 1.4, 84, 'N/A');
INSERT INTO stats VALUES(24.8, 10.6, 4.5, 1.1, 0.8, 85, 'N/A');
-- OKLAHOMA CITY THUNDER PLAYERS/TEAM STATS
INSERT INTO stats VALUES(105.0, 45.6, 22.1, 4.4, 7.0, 000, '18');
INSERT INTO stats VALUES(13.7, 7.2, 1.8, 0.5, 0.5, 86, 'N/A');
INSERT INTO stats VALUES(14.0, 3.6, 1.7, 0.4, 0.9, 87, 'N/A');
INSERT INTO stats VALUES(23.7, 4.7, 5.9, 0.7, 0.8, 88, 'N/A');
INSERT INTO stats VALUES(8.7, 2.0, 2.4, 0.2, 0.8, 89, 'N/A');
INSERT INTO stats VALUES(14.2, 6.7, 3.4, 0.9, 0.9, 90, 'N/A');
-- PORTLAND TRAIL BLAZERS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(116.1, 44.5, 21.3, 5.0, 6.9, 000, '19');
INSERT INTO stats VALUES(8.5, 6.7, 1.7, 1.2, 1.4, 91, 'N/A');
INSERT INTO stats VALUES(28.8, 4.2, 7.5, 0.3, 0.9, 92, 'N/A');
INSERT INTO stats VALUES(23.1, 3.9, 4.7, 0.4, 0.9, 93, 'N/A');
INSERT INTO stats VALUES(11.5, 9.0, 3.4, 1.1, 1.0, 94, 'N/A');
INSERT INTO stats VALUES(18.6, 3.1, 1.9, 0.3, 1.2, 95, 'N/A');
-- UTAH JAZZ PLAYERS/TEAM STATS
INSERT INTO stats VALUES(116.4, 48.3, 23.7, 5.2, 6.6, 000, '20');
INSERT INTO stats VALUES(17.0, 3.9, 1.9, 0.1, 0.6, 96, 'N/A');
INSERT INTO stats VALUES(16.2, 3.5, 6.0, 0.2, 1.4, 97, 'N/A');
INSERT INTO stats VALUES(14.3, 13.5, 1.3, 2.7, 0.6, 98, 'N/A');
INSERT INTO stats VALUES(26.4, 4.4, 5.2, 0.3, 1.0, 99, 'N/A');
INSERT INTO stats VALUES(7.0, 6.8, 2.5, 0.5, 0.8, 100, 'N/A');
-- GOLDEN STATE WARRIORS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(113.7, 43.0, 27.7, 4.8, 8.2, 000, '21');
INSERT INTO stats VALUES(32.0, 5.5, 5.8, 0.1, 1.2, 101, 'N/A');
INSERT INTO stats VALUES(7.0, 7.1, 8.9, 0.8, 1.7, 102, 'N/A');
INSERT INTO stats VALUES(15.4, 6.0, 1.3, 0.8, 1.0, 103, 'N/A');
INSERT INTO stats VALUES(18.6, 4.9, 2.4, 1.0, 0.9, 104, 'N/A');
INSERT INTO stats VALUES(11.5, 5.8, 0.7, 0.9, 0.3, 105, 'N/A');
-- LA CLIPPERS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(114.0, 44.2, 24.4, 4.1, 7.1, 000, '22');
INSERT INTO stats VALUES(8.1, 4.7, 2.2, 0.6, 1.0, 106, 'N/A');
INSERT INTO stats VALUES(7.5, 3.2, 2.1, 0.8, 0.8, 107, 'N/A');
INSERT INTO stats VALUES(23.3, 6.6, 5.2, 0.4, 1.1, 108, 'N/A');
INSERT INTO stats VALUES(11.1, 6.7, 1.8, 1.1, 0.2, 109, 'N/A');
INSERT INTO stats VALUES(24.8, 6.5, 5.2, 0.4, 1.6, 110, 'N/A');
-- LOS ANGELES LAKERS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(109.5, 44.2, 24.7, 5.4, 7.8, 000, '23');
INSERT INTO stats VALUES(9.7, 2.7, 1.9, 0.4, 0.9, 111, 'N/A');
INSERT INTO stats VALUES(21.8, 7.9, 3.1, 1.6, 1.3, 112, 'N/A');
INSERT INTO stats VALUES(5.0, 4.1, 2.1, 1.1, 0.5, 113, 'N/A');
INSERT INTO stats VALUES(25.0, 7.7, 7.8, 0.6, 1.1, 114, 'N/A');
INSERT INTO stats VALUES(15.4, 3.5, 5.8, 0.2, 1.1, 115, 'N/A');
-- PHOENIX SUNS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(115.3, 42.9, 26.9, 4.3, 7.2, 000, '24');
INSERT INTO stats VALUES(14.4, 10.5, 1.4, 1.2, 0.6, 116, 'N/A');
INSERT INTO stats VALUES(25.6, 4.2, 4.3, 0.2, 0.8, 117, 'N/A');
INSERT INTO stats VALUES(13.5, 4.3, 2.1, 0.9, 1.1, 118, 'N/A');
INSERT INTO stats VALUES(10.1, 4.7, 2.1, 0.5, 0.8, 119, 'N/A');
INSERT INTO stats VALUES(16.4, 4.5, 8.9, 0.3, 1.4, 120, 'N/A');
-- SACRAMENTO KINGS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(113.7, 41.4, 25.4, 5.0, 7.5, 000, '25');
INSERT INTO stats VALUES(14.1, 7.4, 1.0, 0.5, 0.5, 121, 'N/A');
INSERT INTO stats VALUES(9.9, 2.0, 2.0, 0.3, 0.7, 122, 'N/A');
INSERT INTO stats VALUES(25.2, 3.5, 7.2, 0.5, 1.5, 123, 'N/A');
INSERT INTO stats VALUES(16.6, 4.7, 3.6, 0.4, 0.9, 124, 'N/A');
INSERT INTO stats VALUES(14.2, 8.3, 1.7, 1.6, 0.6, 124, 'N/A');
-- DALLAS MAVERICKS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(112.4, 43.3, 22.9, 4.3, 6.3, 000, '26');
INSERT INTO stats VALUES(27.7, 8.0, 8.6, 0.5, 1.0, 126, 'N/A');
INSERT INTO stats VALUES(9.8, 5.4, 1.7, 0.4, 0.9, 127, 'N/A');
INSERT INTO stats VALUES(7.1, 5.2, 1.4, 0.7, 0.5, 128, 'N/A');
INSERT INTO stats VALUES(20.1, 8.9, 1.6, 1.3, 0.5, 129, 'N/A');
INSERT INTO stats VALUES(12.1, 3.3, 2.6, 0.4, 1.0, 130, 'N/A');
-- HOUSTON ROCKETS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(108.8, 42.6, 23.6, 5.0, 7.6, 000, '27');
INSERT INTO stats VALUES(13.5, 7.0, 2.9, 0.6, 1.1, 131, 'N/A');
INSERT INTO stats VALUES(16.6, 3.8, 6.3, 0.3, 0.7, 132, 'N/A');
INSERT INTO stats VALUES(11.3, 5.3, 2.5, 0.5, 1.2, 133, 'N/A');
INSERT INTO stats VALUES(20.6, 3.2, 6.9, 0.8, 1.1, 134, 'N/A');
INSERT INTO stats VALUES(21.0, 9.6, 1.7, 1.2, 0.8, 135, 'N/A');
-- MEMPHIS GRIZZLIES PLAYERS/TEAM STATS
INSERT INTO stats VALUES(113.3, 46.5, 26.9, 5.1, 9.1, 000, '28');
INSERT INTO stats VALUES(10.6, 3.2, 2.2, 0.2, 0.9, 136, 'N/A');
INSERT INTO stats VALUES(12.4, 5.7, 3.6, 0.8, 1.2, 137, 'N/A');
INSERT INTO stats VALUES(17.2, 2.9, 2.3, 0.4, 1.2, 138, 'N/A');
INSERT INTO stats VALUES(19.1, 4.0, 7.4, 0.2, 0.9, 139, 'N/A');
INSERT INTO stats VALUES(17.1, 12.5, 1.8, 0.9, 0.6, 140, 'N/A');
-- NEW ORLEANS PELICANS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(114.6, 47.4, 26.0, 4.4, 7.6, 000, '29');
INSERT INTO stats VALUES(7.6, 8.9, 1.9, 0.7, 0.9, 141, 'N/A');
INSERT INTO stats VALUES(14.6, 4.8, 5.7, 0.6, 1.5, 142, 'N/A');
INSERT INTO stats VALUES(12.2, 3.4, 3.8, 0.8, 0.3, 143, 'N/A');
INSERT INTO stats VALUES(23.8, 4.9, 4.9, 0.6, 0.7, 144, 'N/A');
INSERT INTO stats VALUES(27.0, 7.2, 3.7, 0.6, 0.9, 145, 'N/A');
-- SAN ANTONIO SPURS PLAYERS/TEAM STATS
INSERT INTO stats VALUES(111.1, 43.9, 24.4, 5.1, 7.0, 000, '30');
INSERT INTO stats VALUES(21.6, 4.2, 6.9, 0.2, 0.9, 146, 'N/A');
INSERT INTO stats VALUES(12.8, 6.0, 1.8, 0.3, 0.6, 147, 'N/A');
INSERT INTO stats VALUES(15.7, 7.1, 5.4, 0.1, 1.5, 148, 'N/A');
INSERT INTO stats VALUES(8.6, 7.9, 1.9, 1.8, 0.7, 149, 'N/A');
INSERT INTO stats VALUES(15.4, 3.0, 3.5, 1.0, 0.7, 150, 'N/A');

.headers off

SELECT "1------------------------";
/*
    For the Miami Heat, find and print the player with the highest points per game along with the actual stat. 
*/
.headers on

SELECT p_name, max(s_ppg)
FROM stats, teams, players
WHERE t_name = 'Miami Heat'
AND p_playerkey = s_playerkey
AND t_teamkey = p_current_teamkey;

.headers off

SELECT "2------------------------";
/*
    For every nba team, find and print each of the team's point per game avg in descenfing order. 
    Print the team name and the team's points per game stat. 
*/
.headers on 

SELECT t_name, s_ppg
FROM stats, teams
WHERE s_teamkey = t_teamkey
AND s_playerkey = 000
GROUP BY t_teamkey
ORDER BY s_ppg DESC;

.headers off

SELECT "3------------------------";
/*
    Delete every NBA team that is the Atlantic Division
*/
.headers on

-- DELETE FROM teams
-- WHERE t_name IN (
--     SELECT t_name
--     FROM teams, divisions
--     WHERE d_name = 'ATLANTIC' 
--     AND t_divisionkey = d_divisionkey
--     GROUP BY t_name
-- );

.headers off

SELECT "4------------------------";
/*
    Add the following data to the database: All teams that have less than 105 points points per game. Insert a player a shooting guard 
    that has an age of 28, a height of 1.98 m, a weight of 99.0 kg, and name them 'BUCKET'. 
*/
.headers on

-- INSERT INTO players
-- SELECT 151, 'BUCKET', 28, '1.98', 99.0, 'SG', t_teamkey, 'NULL'
-- FROM (
--     SELECT t_teamkey, t_name, max(s_ppg)
--     FROM stats, teams
--     WHERE s_teamkey = t_teamkey
--     AND s_ppg < 105
--     GROUP BY t_teamkey
--     ORDER BY s_ppg DESC
-- );

.headers off

SELECT "5------------------------";
/* 
    Add the following to the database: All players named 'BUCKET' give them same stats as the Bradley Beal, who was the NBA's 2020-2021 
    runner-up for the scoring title. This will help each of those teams that need more scoring.
*/
.headers on

-- INSERT INTO stats
-- SELECT s_ppg, s_rpg, s_apg, s_spg, s_bpg, 151, s_teamkey
-- FROM (SELECT s_ppg, s_rpg, s_apg, s_spg, s_bpg, s_playerkey, s_teamkey
-- FROM stats, players
-- WHERE p_name = 'Bradley Beal'
-- AND p_playerkey = s_playerkey
-- );

.headers off

SELECT "6------------------------";
/*
    Update the following to the database: The Detroit Pistsons have decided to make a franchise change. 
    They want to move Las Vegas, Nevada and re-brand their name to the 'Las Vegas Varmints'. You will
    also need to change them to the appropraite division since they will no longer be CENTRAL divison, 
    now they will be in the PACIFIC divison.
*/
.headers on

-- UPDATE teams
-- SET t_name = 'Las Vegas Varmints', t_divisionkey = 5
-- WHERE t_teamkey IN (
--     SELECT t_teamkey
--     FROM teams
--     WHERE t_name = 'Detroit Pistons'
-- );

.headers off

SELECT "7------------------------";
/*
    Update the following to the database: Clear each players stats to 0 because it the beginning a new season.
    However, don't do this for the team's stats.
*/
.headers on

-- UPDATE stats
-- SET s_ppg = 0, s_rpg = 0, s_apg = 0, s_spg = 0, s_bpg = 0 
-- WHERE s_playerkey IN (
--     SELECT s_playerkey
--     FROM players, stats
--     WHERE s_playerkey = p_playerkey
-- );

.headers off

SELECT "8------------------------";
/*
    Delete teams with less than the average of all teams points per game. So add all teams points per game stat
    then compare each team's ppg to the that number. Then delete all those teams
*/
.headers on

-- DELETE FROM teams
-- WHERE t_teamkey IN (
-- SELECT t_teamkey
-- FROM (
--     SELECT AVG(s_ppg) as avg_team_ppg
--     FROM stats, teams
--     WHERE s_teamkey = t_teamkey
--     AND s_playerkey = 000), stats, teams
-- WHERE s_ppg < avg_team_ppg
-- AND s_teamkey = t_teamkey
-- AND s_playerkey = 000
-- ORDER BY s_ppg DESC);

.headers off

SELECT "9------------------------";
/*
   Find all leading rebounders per game for each team. Print the team name, player name, and the stat.
   Group it by teams in alphabetical order.
*/
.headers on

SELECT DISTINCT t_name, p_name, MAX(s_rpg)
FROM stats, players, teams 
WHERE p_playerkey = s_playerkey
AND s_teamkey = 'N/A' -- denotes that this is a player stat
AND p_current_teamkey = t_teamkey
GROUP BY t_name;

.headers off

SELECT "10------------------------";
/*
   Find all lowest points per game for each team. Print the team name, player name, and the stat.
   Group it by teams in alphabetical order.
*/
.headers on

SELECT DISTINCT t_name, p_name, MIN(s_ppg)
FROM stats, players, teams 
WHERE p_playerkey = s_playerkey
AND s_teamkey = 'N/A' -- denotes that this is a player stat
AND p_current_teamkey = t_teamkey
GROUP BY t_name;

.headers off

SELECT "11------------------------";
--1: Finding the Names of player who have a PPG greater than 10.0
select p_name
from players, stats
WHERE s_playerkey = p_playerkey
GROUP BY p_name
HAVING s_ppg > 10.0;

SELECT "12------------------------";
--2: Finding a Particular Player and the Team they play on and the division:
select p_name as Player, t_name as Team, d_name as Division
from players
INNER JOIN teams on p_current_teamkey = t_teamkey 
INNER JOIN divisions on t_divisionkey = d_divisionkey
WHERE p_name = 'LeBron James';

SELECT "13------------------------";
--3: For the Miami Heat, find and print the player with the highest points per game along with the actual stat:
SELECT p_name, max(s_ppg)
FROM stats, teams, players
WHERE t_name = 'Miami Heat'
AND p_playerkey = s_playerkey
AND t_teamkey = p_current_teamkey;

SELECT "14------------------------";
--4: For every nba team, find and print each of the team's point per game avg in descenfing order. 
--   Print the team name and the team's points per game stat. 
SELECT t_name, max(s_ppg)
FROM stats, teams
WHERE s_teamkey = t_teamkey
GROUP BY t_teamkey
ORDER BY s_ppg DESC;

SELECT "15------------------------";
--5: Finding a player who has played for more than one team:
select p_name as Player, t_name as Team, d_name as Division
from players
INNER JOIN teams on p_current_teamkey = t_teamkey 
INNER JOIN divisions on t_divisionkey = d_divisionkey
WHERE p_old_teamkey not LIKE "%N/A%";

SELECT "16------------------------";
--6: Find players that are older than 21 that have a point per game greater than 12:
select Distinct(p_name) as Player, t_name as Team, d_name as Division, s_ppg as Point_Per_Game
from players
INNER JOIN stats ON p_playerkey = s_playerkey
INNER JOIN teams on p_current_teamkey = t_teamkey
INNER JOIN divisions ON t_divisionkey = d_divisionkey
Where p_age = (SELECT p_age 
from players
GROUP BY p_name
HAVING p_age < 21) And s_ppg > '12.0'
Order BY p_age;

SELECT "17------------------------";
--7: Fine the entire Line up for a given team 
select p_name as Player, pos_name as Position, t_name as Team, d_name as Division
from players, positions
INNER JOIN stats ON p_playerkey = s_playerkey
INNER JOIN teams on p_current_teamkey = t_teamkey
INNER JOIN divisions ON t_divisionkey = d_divisionkey
--INNER JOIN positions ON p_positionkey = pos_abbr
Where t_name = (SELECT t_name 
from teams
WHERE t_name = "Los Angeles Lakers")
Order BY p_name;

SELECT "18------------------------";
--8: Find all the Teams that have a ppg > 110 and a rpg > 43
select DISTINCT t_name as Team, d_name as Division, s_ppg, s_rpg
from players
INNER JOIN stats ON p_current_teamkey = s_teamkey
INNER JOIN teams on p_current_teamkey = t_teamkey
INNER JOIN divisions ON t_divisionkey = d_divisionkey
Where s_ppg > 110.0 and s_rpg > 43.0
order by t_name; 

SELECT "19------------------------";
--9 Select the players who play PG and SF that have a points per game greater than 10.0
SELECT p_name as Player, pos_name as Position
from players
INNER JOIN stats ON p_playerkey = s_playerkey
INNER JOIN positions ON p_positionkey = pos_abbr
Where p_positionkey = 'PG' or p_positionkey = "SF" and s_ppg > 10.0
ORDER BY p_name;

SELECT "20------------------------";
--10 Select all the point guards that have a block per game greater than 1
select p_name as Player, pos_name as Position, t_name as Team, d_name as Division
from players
INNER JOIN stats ON p_playerkey = s_playerkey
INNER JOIN teams on p_current_teamkey = t_teamkey
INNER JOIN divisions ON t_divisionkey = d_divisionkey
INNER JOIN positions ON p_positionkey = pos_abbr
WHERE p_positionkey = "PG" and s_bpg > 1.0
Group BY p_name
HAVING p_age > 18;

/*
Select s_ppg, s_rpg, s_apg, s_spg, s_bpg
FROM stats, players, user
WHERE p_playerkey = s_playerkey
AND p_name = u_player
AND u_id = 'Richard Parker';
*/



