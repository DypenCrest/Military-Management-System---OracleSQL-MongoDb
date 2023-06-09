--Drop Types
DROP TYPE geolocationtype FORCE;

DROP TYPE nestedmission_geolocationtype FORCE;

DROP TYPE addresstype FORCE;

DROP TYPE headquartertype FORCE;

DROP TYPE divisiontype FORCE;

DROP TYPE vehicletype FORCE;

DROP TYPE vaulttype FORCE;

DROP TYPE weapontype FORCE;

DROP TYPE geartype FORCE;

DROP TYPE explosivetype FORCE;

DROP TYPE missiontype FORCE;

DROP TYPE missionlogtype FORCE;
--------------------------------------------------------------------------------
--Drop Tables
DROP TABLE headquarter CASCADE CONSTRAINTS;

DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE division CASCADE CONSTRAINTS;

DROP TABLE personnel CASCADE CONSTRAINTS;

DROP TABLE vault CASCADE CONSTRAINTS;

DROP TABLE weapon CASCADE CONSTRAINTS;

DROP TABLE gear CASCADE CONSTRAINTS;

DROP TABLE explosive CASCADE CONSTRAINTS;

DROP TABLE vehicle CASCADE CONSTRAINTS;

DROP TABLE mission CASCADE CONSTRAINTS;

DROP TABLE missionlog CASCADE CONSTRAINTS;
--------------------------------------------------------------------------------
--Create Types
CREATE OR REPLACE TYPE geolocationtype AS OBJECT (
    location_name VARCHAR2(30),
    location_type VARCHAR2(30),
    latitude      FLOAT(10),
    longitude     FLOAT(10)
) NOT FINAL;
/

CREATE TYPE nestedmission_geolocationtype AS
    TABLE OF geolocationtype;
/

CREATE OR REPLACE TYPE addresstype AS OBJECT (
    zipcode NUMBER(5),
    city    VARCHAR2(30)
) NOT FINAL;
/

CREATE OR REPLACE TYPE headquartertype AS OBJECT (
    hq_id     VARCHAR(10),
    hq_name   VARCHAR(50),
    address   REF addresstype,
    commander VARCHAR(30)
) NOT FINAL;
/

CREATE OR REPLACE TYPE divisiontype AS OBJECT (
    division_id   NUMBER(3),
    division_name VARCHAR2(25),
    division_size NUMBER(3),
    division_type VARCHAR(20)
) NOT FINAL;
/

CREATE OR REPLACE TYPE vehicletype AS OBJECT (
    vehicle_id   NUMBER(4),
    vehicle_name VARCHAR2(25),
    headquarter  REF headquartertype,
    vehicle_type VARCHAR2(15),
    division     REF divisiontype
) NOT FINAL;
/

CREATE OR REPLACE TYPE vaulttype AS OBJECT (
    equipment_id   NUMBER(4),
    equipment_name VARCHAR2(25),
    headquarter    REF headquartertype,
    quantity       NUMBER(3)
) NOT FINAL;
/

CREATE OR REPLACE TYPE weapontype UNDER vaulttype (
    weapon_type VARCHAR(30)
) NOT FINAL;
/

CREATE OR REPLACE TYPE geartype UNDER vaulttype (
    gear_type VARCHAR(30)
) NOT FINAL;
/

CREATE OR REPLACE TYPE explosivetype UNDER vaulttype (
    explosive_type VARCHAR(30)
) NOT FINAL;
/

CREATE OR REPLACE TYPE missiontype AS OBJECT (
    mission_id          NUMBER(3),
    mission_type        VARCHAR2(15),
    mission_geolocation nestedmission_geolocationtype,
    start_date          DATE,
    end_date            DATE,
    mission_duration    INTERVAL DAY TO SECOND,
    division            REF divisiontype,
    status              VARCHAR2(15)
) NOT FINAL;
/

CREATE OR REPLACE TYPE missionlogtype AS OBJECT (
    mission_id REF missiontype,
    log_id     NUMBER(3),
    outcome    VARCHAR2(25),
    casualties NUMBER(3)
) NOT FINAL;
/
--------------------------------------------------------------------------------
--Create Tables
CREATE TABLE address OF addresstype (
    zipcode NOT NULL PRIMARY KEY
);

CREATE TABLE headquarter OF headquartertype (
    hq_id NOT NULL PRIMARY KEY,
    hq_name NOT NULL,
    commander NOT NULL
);

CREATE TABLE division OF divisiontype (
    division_id NOT NULL PRIMARY KEY
);

CREATE TABLE personnel (
    per_id      NUMBER(4) NOT NULL PRIMARY KEY,
    per_name    VARCHAR2(30) NOT NULL,
    per_rank    VARCHAR2(25) NOT NULL,
    headquarter REF headquartertype,
    division    REF divisiontype,
    kills       NUMBER(3)
);

CREATE TABLE vault OF vaulttype (
    equipment_id NOT NULL PRIMARY KEY
);

CREATE TABLE weapon OF weapontype (
    weapon_type NOT NULL
);

CREATE TABLE gear OF geartype (
    gear_type NOT NULL
);

CREATE TABLE explosive OF explosivetype (
    explosive_type NOT NULL
);

CREATE TABLE vehicle OF vehicletype (
    vehicle_id NOT NULL PRIMARY KEY,
    vehicle_name NOT NULL,
    vehicle_type NOT NULL
);

CREATE TABLE mission OF missiontype (
    mission_id NOT NULL PRIMARY KEY,
    mission_type NOT NULL,
    status NOT NULL
)
NESTED TABLE mission_geolocation STORE AS nestedmission_geolocationtable;

CREATE TABLE missionlog OF missionlogtype (
    log_id PRIMARY KEY NOT NULL
);

--------------------------------------------------------------------------------
--Insertions
--------------------------------------------------------------------------------
--Address Table Insertion
INSERT INTO address VALUES (
    44700,
    'Lalitpur'
);
--------------------------------------------

-- Insert into Headquarter Table
INSERT INTO headquarter VALUES (
    'LMHQ',
    'Lalitpur Metropolitan Headquater',
    (
        SELECT
            ref(b)
        FROM
            address b
        WHERE
            zipcode = '44700'
    ),
    'Dipen Shrestha'
);
-------------------------------------------------

--Insert into Division
INSERT INTO division ( division_id, division_name, division_size,division_type)
    SELECT
        001,
        'Alpha',
        100,
        'Infantry'
    FROM
        dual
    UNION ALL
    SELECT
        002,
        'Bravo',
        150,
        'Armored'
    FROM
        dual
    UNION ALL
    SELECT
        003,
        'Charlie',
        120,
        'Artillery'
    FROM
        dual
    UNION ALL
    SELECT
        004,
        'Delta',
        80,
        'Special Forces'
    FROM
        dual
    UNION ALL
    SELECT
        005,
        'Foxtrot',
        110,
        'Airborne'
    FROM
        dual;
-----------------------------------------------------

--Vechile Table Insertions
INSERT INTO vehicle (
    vehicle_id,
    vehicle_name,
    headquarter,
    vehicle_type,
    division
)
    SELECT
        1,
        'Tank',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Heavy',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 002
        )
    FROM
        dual
    UNION ALL
    SELECT
        2,
        'Chopper',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Air Attack',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 002
        )
    FROM
        dual
    UNION ALL
    SELECT
        3,
        'Transport truck',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Heavy',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 001
        )
    FROM
        dual
    UNION ALL
    SELECT
        4,
        'Fighter Jet',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Interceptor',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 003
        )
    FROM
        dual
    UNION ALL
    SELECT
        5,
        'APC',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Armoured',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 002
        )
    FROM
        dual
    UNION ALL
    SELECT
        6,
        'Missile Launcher',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Artillery',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 003
        )
    FROM
        dual
    UNION ALL
    SELECT
        7,
        'Scout Vehicle',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Light',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 004
        )
    FROM
        dual
    UNION ALL
    SELECT
        8,
        'Transport aircraft',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        'Utility',
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 005
        )
    FROM
        dual;
-----------------------------------------------------

--Personnnel Table Insertion
INSERT INTO personnel (
    per_id,
    per_name,
    per_rank,
    headquarter,
    division,
    kills
)
    SELECT
        1001,
        'Ram Shrestha',
        'Captain',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 001
        ),
        73
    FROM
        dual
    UNION ALL
    SELECT
        1002,
        'Sam Shrestha',
        'private',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 003
        ),
        15
    FROM
        dual
    UNION ALL
    SELECT
        1003,
        'Hari Shrestha',
        'Commander',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 002
        ),
        72
    FROM
        dual
    UNION ALL
    SELECT
        1004,
        'Dipen Shrestha',
        'Lieutenant',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 004
        ),
        51
    FROM
        dual
    UNION ALL
    SELECT
        1005,
        'Dypen Crest',
        'Sergeant',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 004
        ),
        49
    FROM
        dual
    UNION ALL
    SELECT
        1006,
        'Tom Crest',
        'Staff Sergeant',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 004
        ),
        36
    FROM
        dual
    UNION ALL
    SELECT
        1007,
        'Leon Kennedy',
        'Corporal',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 001
        ),
        23
    FROM
        dual
    UNION ALL
    SELECT
        1008,
        'Jill Valentine',
        'Private',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 002
        ),
        10
    FROM
        dual
    UNION ALL
    SELECT
        1009,
        'Claire Redfield',
        'Private',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 003
        ),
        6
    FROM
        dual
    UNION ALL
    SELECT
        1010,
        'Arthur Morgan',
        'Sergeant',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        (
            SELECT
                ref(d)
            FROM
                division d
            WHERE
                d.division_id = 005
        ),
        53
    FROM
        dual;
------------------------------------------------------------    

--Vault(Weapon, Gear, Explosive) Table Insertion
--Weapon Table
-------------------------------------------------------------
INSERT INTO weapon (
    equipment_id,
    equipment_name,
    weapon_type,
    headquarter,
    quantity
)
    SELECT
        001,
        'AK-47',
        'Assualt Rifle',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        33
    FROM
        dual
    UNION ALL
    SELECT
        002,
        'M4 Carbine',
        'Assualt Rifle',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        127
    FROM
        dual
    UNION ALL
    SELECT
        003,
        'M9 pistol',
        'Hand Gun',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        308
    FROM
        dual
    UNION ALL
    SELECT
        004,
        'M240B',
        'Machine Gun',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        26
    FROM
        dual
    UNION ALL
    SELECT
        005,
        'M107',
        'Sniper Rifle',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        23
    FROM
        dual
    UNION ALL
    SELECT
        006,
        'RPG-7',
        'Rocket launcher',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        12
    FROM
        dual
    UNION ALL
    SELECT
        007,
        'Khukuri',
        'Melee',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        217
    FROM
        dual;
---------------------------------------------------------

--Gear Table
----------------------------------------------------
INSERT INTO gear (
    equipment_id,
    equipment_name,
    gear_type,
    headquarter,
    quantity
)
    SELECT
        010,
        'Helmet',
        'Ballistic',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        363
    FROM
        dual
    UNION ALL
    SELECT
        011,
        'Tactical Vest',
        'Ballistic',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        379
    FROM
        dual
    UNION ALL
    SELECT
        012,
        'Night Vision Goggles',
        'Goggles',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        66
    FROM
        dual
    UNION ALL
    SELECT
        013,
        'Radios',
        'Communication',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        263
    FROM
        dual
    UNION ALL
    SELECT
        014,
        'First aid Kits',
        'Medical',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        256
    FROM
        dual;
-------------------------------------------------------------

--Explosive Table
--------------------------------------
INSERT INTO explosive (
    equipment_id,
    equipment_name,
    explosive_type,
    headquarter,
    quantity
)
    SELECT
        100,
        'C4',
        'Plastic explosive',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        50
    FROM
        dual
    UNION ALL
    SELECT
        200,
        'M18 Claymore',
        'Antipersonnel mine',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        20
    FROM
        dual
    UNION ALL
    SELECT
        300,
        'M67 Frag',
        'Hand grenade',
        (
            SELECT
                ref(h)
            FROM
                headquarter h
            WHERE
                h.hq_id = 'LMHQ'
        ),
        100
    FROM
        dual;
--------------------------------------------

--Mission Table Insertion
------------------------------
INSERT INTO mission VALUES (
    1,
    'Assassination',
    nestedmission_geolocationtype(),
    TO_DATE('2023-04-1', 'YYYY-MM-DD'),
    TO_DATE('2023-04-04', 'YYYY-MM-DD'),
    INTERVAL '3 04:00:00' DAY TO SECOND,
    (
        SELECT
            ref(d)
        FROM
            division d
        WHERE
            d.division_id = 004
    ),
    'Ended'
);
--Nested mission(1)--
INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '1'
) VALUES (
    'Chitwan',
    'City',
    51.5074,
    - 0.1278
);

INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '1'
) VALUES (
    'Hetauda',
    'Jungle',
    48.8566,
    2.3522
);

--------------------------------------------
INSERT INTO mission VALUES (
    2,
    'Sabotage',
    nestedmission_geolocationtype(),
    TO_DATE('2023-04-15', 'YYYY-MM-DD'),
    TO_DATE('2023-04-17', 'YYYY-MM-DD'),
    INTERVAL '2 04:00:00' DAY TO SECOND,
    (
        SELECT
            ref(d)
        FROM
            division d
        WHERE
            d.division_id = 004
    ),
    'Ended'
);
--Nested mission(2)--
INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '2'
) VALUES (
    'Redzone',
    'Landmark',
    27.6810,
    85.3139
);

INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '2'
) VALUES (
    'Firebase',
    'Landmark',
    27.6841,
    85.3197
);

-------------------------------------------
INSERT INTO mission VALUES (
    3,
    'Reconnaissance',
    nestedmission_geolocationtype(),
    TO_DATE('2023-05-01', 'YYYY-MM-DD'),
    TO_DATE('2023-05-04', 'YYYY-MM-DD'),
    INTERVAL '4 08:00:00' DAY TO SECOND,
    (
        SELECT
            ref(d)
        FROM
            division d
        WHERE
            d.division_id = 001
    ),
    'In progress'
);
--Nested mission(3)--
INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '3'
) VALUES (
    'Biratchowk',
    'Town',
    33.3152,
    44.3661
);

INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '3'
) VALUES (
    'Biratnagar',
    'City',
    36.3350,
    43.1189
);

-----------------------------------------
INSERT INTO mission VALUES (
    4,
    'Convoy Escort',
    nestedmission_geolocationtype(),
    TO_DATE('2023-05-10', 'YYYY-MM-DD'),
    TO_DATE('2023-05-12', 'YYYY-MM-DD'),
    INTERVAL '2 00:00:00' DAY TO SECOND,
    (
        SELECT
            ref(d)
        FROM
            division d
        WHERE
            d.division_id = 002
    ),
    'Planning'
);
--NestedMission(4)--
INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '4'
) VALUES (
    'Newroad',
    'Route',
    27.6987,
    85.3171
);

INSERT INTO TABLE (
    SELECT
        b.mission_geolocation
    FROM
        mission b
    WHERE
        mission_id = '4'
) VALUES (
    'Putalisadak',
    'Route',
    27.6949,
    85.3232
);


--Mission Log Table Insertion--
INSERT INTO missionlog (
    log_id,
    mission_id,
    outcome,
    casualties
)
    SELECT
        001,
        (
            SELECT
                ref(m)
            FROM
                mission m
            WHERE
                m.mission_id = '1'
        ),
        'Accomplished',
        0
    FROM
        dual
    UNION ALL
    SELECT
        002,
        (
            SELECT
                ref(m)
            FROM
                mission m
            WHERE
                m.mission_id = '2'
        ),
        'Failed',
        3
    FROM
        dual
    UNION ALL
    SELECT
        003,
        (
            SELECT
                ref(m)
            FROM
                mission m
            WHERE
                m.mission_id = '3'
        ),
        'Pending',
        NULL
    FROM
        dual
    UNION ALL
    SELECT
        004,
        (
            SELECT
                ref(m)
            FROM
                mission m
            WHERE
                m.mission_id = '4'
        ),
        'Pending',
        NULL
    FROM
        dual;
--------------------------------------------------------------------------------        
----Join Table(Headquarter, Division, Personnel, Mission)----
SELECT
    h.hq_id         AS hq,
    d.division_name AS division,
    p.per_name      AS personnel,
    p.per_rank      AS rank,
    m.mission_type  AS mission
FROM
         headquarter h
    INNER JOIN personnel p ON h.hq_id = p.headquarter.hq_id
    INNER JOIN division  d ON p.division.division_id = d.division_id
    LEFT JOIN mission   m ON d.division_id = m.division.division_id
WHERE
    h.hq_id = 'LMHQ';
--------------------------------------------------------------------------------
----UNION and INTERSECTION ----
SELECT
    vehicle_name
FROM
    vehicle v
WHERE
    v.division.division_id = '001'
UNION
SELECT
    vehicle_name
FROM
    vehicle v
WHERE
    v.division.division_id = '002'
INTERSECT
SELECT
    vehicle_name
FROM
    vehicle
WHERE
    vehicle_type = 'Heavy';
--------------------------------------------------------------------------------
----Nested table----
SELECT
    m.mission_id,
    m.division.division_type AS division,
    m.mission_type           AS mission,
    l.location_name          AS location,
    l.location_type          AS type,
    l.latitude               AS latitude,
    l.longitude              AS longitude
FROM
    mission                         m,
    TABLE ( m.mission_geolocation ) l
WHERE
    m.division.division_id IN (
        SELECT
            d.division_id
        FROM
            division d
        WHERE
            m.division.division_type IN ( 'Special Forces' )
    );
--------------------------------------------------------------------------------
----Temporal and Interval------------------------
SELECT
    to_char(start_date, 'MONTH')          AS month,
    COUNT(EXTRACT(MONTH FROM start_date)) AS number_of_mission
FROM
    mission
WHERE
        start_date >= TIMESTAMP '2023-04-1 00:00:00.000'
    AND start_date <= TIMESTAMP '2023-05-10 23:59:59.999'
    AND mission_duration > INTERVAL '2' DAY
GROUP BY
    to_char(start_date, 'MONTH')
ORDER BY
    number_of_mission DESC;
--------------------------------------------------------------------------------
--Partition--------------------
SELECT
    per_name                                    AS personnel,
    p.division.division_type                    AS division,
    kills,
    AVG(kills)
    OVER(PARTITION BY p.division.division_type) average_kills,
    MIN(kills)
    OVER(PARTITION BY p.division.division_type) min_kills,
    MAX(kills)
    OVER(PARTITION BY p.division.division_type) max_kills
FROM
    personnel p
WHERE
    kills > 5;