CREATE TABLE MEMBERSHIP_PLAN (
    Plan_ID SERIAL PRIMARY KEY,
    Plan_Name VARCHAR(50) NOT NULL UNIQUE,
    Plan_Type VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Duration INT NOT NULL, -- Duration in months
    Features TEXT
);

-- 2. TRAINER Table
CREATE TABLE TRAINER (
    Trainer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(100) UNIQUE,
    Salary DECIMAL(10, 2),
    Certifications TEXT,
    Availability VARCHAR(255),
    Member_Ratings DECIMAL(2, 1)
);

-- 3. EXERCISE_CLASS Table (Renamed from CLASS to avoid reserved word conflict)
CREATE TABLE EXERCISE_CLASS (
    Class_ID SERIAL PRIMARY KEY,
    Trainer_ID INT REFERENCES TRAINER(Trainer_ID),
    Class_Type VARCHAR(50) NOT NULL,
    Studio_Location VARCHAR(100) NOT NULL,
    Equipment_Inventory TEXT,
    Attendance_Rate DECIMAL(4, 3)
);

-- 4. MEMBER Table (Includes CHECK Constraint for Data Integrity)
CREATE TABLE MEMBER (
    Member_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Contact VARCHAR(100) UNIQUE,
    Membership_Status VARCHAR(50) NOT NULL,
    Billing_Info VARCHAR(255),
    Goals TEXT,
    Injuries TEXT,
    Preferred_Styles VARCHAR(255),
    Plan_ID INT REFERENCES MEMBERSHIP_PLAN(Plan_ID),
    -- CHECK Constraint: Ensures Membership_Status is one of the valid states
    CHECK (Membership_Status IN ('Active', 'Frozen', 'Cancelled', 'Trial'))
);

-- 5. TRANSACTION Table (Includes CHECK Constraint for Financial Integrity)
CREATE TABLE TRANSACTION_Table (
    Transaction_ID SERIAL PRIMARY KEY,
    Member_ID INT REFERENCES MEMBER(Member_ID),
    Transaction_Details VARCHAR(255),
    Total_Revenue DECIMAL(10, 2) NOT NULL,
    Taxes_Collected DECIMAL(10, 2),
    Revenue_Stream VARCHAR(50) NOT NULL,
    -- CHECK Constraint: Ensures revenue and taxes are non-negative
    CHECK (Total_Revenue >= 0 AND Taxes_Collected >= 0)
);

-- 6. WORKOUT_SESSION Table
CREATE TABLE WORKOUT_SESSION (
    Session_ID BIGSERIAL PRIMARY KEY,
    Member_ID INT REFERENCES MEMBER(Member_ID) NOT NULL,
    Trainer_ID INT REFERENCES TRAINER(Trainer_ID),
    Class_ID INT REFERENCES EXERCISE_CLASS(Class_ID), -- Nullable for personal training
    Date DATE NOT NULL,
    Duration INT NOT NULL, -- Duration in minutes
    Check_In_Time TIME,
    Check_Out_Time TIME,
    Personal_Bests_Achieved BOOLEAN DEFAULT FALSE
);

-- 7. WEARABLE_DATA Table
CREATE TABLE WEARABLE_DATA (
    Data_Point_ID BIGSERIAL PRIMARY KEY,
    Session_ID BIGINT REFERENCES WORKOUT_SESSION(Session_ID) NOT NULL,
    Heart_Rate INT,
    Calories_Burned DECIMAL(7, 2),
    Power_Output DECIMAL(7, 2),
    Time_in_Target_Zones INT, -- Time in minutes
    Timestamp TIMESTAMP NOT NULL
);

-- *** Data for MEMBERSHIP_PLAN (4 entries) ***
INSERT INTO MEMBERSHIP_PLAN (Plan_Name, Plan_Type, Price, Duration, Features) VALUES
('Standard Monthly', 'Monthly', 99.99, 1, 'Access to 4 classes/month'),
('Gold Annual', 'Annual', 999.00, 12, 'Unlimited classes, 2 free PT sessions'),
('Trial Pass', 'Trial', 0.00, 0, 'One week unlimited access'),
('Elite PT Package', 'Package', 300.00, 3, '5 Personal Training sessions');

-- *** Data for TRAINER (10 entries) ***
INSERT INTO TRAINER (Name, Contact, Salary, Certifications, Availability, Member_Ratings) VALUES
('Alex Smith', 'alex.s@zenith.com', 75000.00, 'CPT, Yoga RYT-200', 'M-F 8am-4pm', 4.8),
('Ben Carter', 'ben.c@zenith.com', 82000.00, 'CPT, HIIT Specialist', 'T-Th 5pm-8pm, Sat 9am-1pm', 4.5),
('Carly Diaz', 'carly.d@zenith.com', 68000.00, 'Spin Certified, Group Fitness', 'M/W/F 6am-10am', 4.9),
('David Lee', 'david.l@zenith.com', 70000.00, 'Physio, Injury Recovery', 'W-F 1pm-5pm', 4.7),
('Ella Fox', 'ella.f@zenith.com', 78000.00, 'Marathon Prep, Nutrition', 'M-Th 7am-11am', 4.6),
('Frank Green', 'frank.g@zenith.com', 65000.00, 'General CPT', 'Sat-Sun 10am-4pm', 4.4),
('Grace Hall', 'grace.h@zenith.com', 85000.00, 'Advanced CPT, Powerlifting', 'M/T/Th 5pm-9pm', 5.0),
('Henry Ivy', 'henry.i@zenith.com', 72000.00, 'Yoga Master', 'T/Th 10am-2pm', 4.9),
('Ivy Jones', 'ivy.j@zenith.com', 69000.00, 'Zumba, Dance Fitness', 'F 4pm-8pm', 4.3),
('Jack King', 'jack.k@zenith.com', 71000.00, 'Boxing, Kettlebell', 'M/W 11am-3pm', 4.7);

-- *** Data for EXERCISE_CLASS (15 entries) ***
INSERT INTO EXERCISE_CLASS (Trainer_ID, Class_Type, Studio_Location, Equipment_Inventory, Attendance_Rate) VALUES
(3, 'Spin 45', 'Studio A', 'Spin Bikes, Towels', 0.95),
(2, 'HIIT Blast', 'Gym Floor', 'Kettlebells, Mats', 0.88),
(1, 'Vinyasa Flow', 'Studio B', 'Yoga Mats, Blocks', 0.75),
(6, 'Powerlifting 101', 'Weight Room', 'Barbells, Racks', 0.65),
(7, 'Advanced Strength', 'Weight Room', 'Barbells, Racks', 0.92),
(3, 'Spin 60 Endurance', 'Studio A', 'Spin Bikes, Towels', 0.85),
(10, 'Boxing Fundamentals', 'Studio C', 'Punching Bags, Gloves', 0.79),
(9, 'Zumba Party', 'Studio B', 'Sound System', 0.98),
(8, 'Yin Yoga', 'Studio B', 'Bolsters, Blankets', 0.80),
(4, 'Rehab Core', 'Studio C', 'Resistance Bands, Balls', 0.55),
(5, 'Marathon T-Minus 8', 'Track Area', 'Treadmills', 0.70),
(2, 'Morning HIIT', 'Gym Floor', 'Kettlebells, Mats', 0.90),
(1, 'Lunch Vinyasa', 'Studio B', 'Yoga Mats, Blocks', 0.60),
(7, 'Evening Strength', 'Weight Room', 'Barbells, Racks', 0.95),
(10, 'Kettlebell Core', 'Studio C', 'Kettlebells', 0.82);

-- MEMBER inserts (same as your original)
INSERT INTO MEMBER (Name, Address, Contact, Membership_Status, Billing_Info, Goals, Injuries, Preferred_Styles, Plan_ID)
SELECT
    'Member ' || generate_series,
    '123 Main St, City ' || generate_series,
    'member' || generate_series || '@email.com',
    CASE (generate_series % 4)
        WHEN 0 THEN 'Active'
        WHEN 1 THEN 'Active'
        WHEN 2 THEN 'Frozen'
        ELSE 'Trial'
    END,
    'Visa **** ' || (1000 + generate_series),
    CASE (generate_series % 5)
        WHEN 0 THEN 'Weight Loss'
        WHEN 1 THEN 'Muscle Gain'
        WHEN 2 THEN 'Endurance'
        WHEN 3 THEN 'Flexibility'
        ELSE 'General Fitness'
    END,
    CASE (generate_series % 10)
        WHEN 0 THEN 'Knee Pain'
        WHEN 5 THEN 'None'
        ELSE 'None'
    END,
    CASE (generate_series % 3)
        WHEN 0 THEN 'Spin, HIIT'
        WHEN 1 THEN 'Yoga, Pilates'
        ELSE 'Strength Training'
    END,
    (generate_series % 4) + 1
FROM generate_series(1, 55);

INSERT INTO MEMBER (
    Name, Address, Contact, Membership_Status, Billing_Info, Goals, Injuries, Preferred_Styles, Plan_ID
)
SELECT
    'Member_' || g.series,
    (g.series * 10) || ' Fitness Blvd, Apt ' || (g.series % 50 + 1) || ', Zenith City',
    'new_member_' || g.series || '@zenithlabs.com',
    CASE (g.series % 5)
        WHEN 0 THEN 'Frozen'
        WHEN 4 THEN 'Trial'
        ELSE 'Active'
    END AS Membership_Status,
    'Mastercard **** ' || (9000 + g.series),
    CASE (g.series % 5)
        WHEN 0 THEN 'Weight Loss'
        WHEN 1 THEN 'Muscle Gain'
        WHEN 2 THEN 'Endurance'
        WHEN 3 THEN 'Flexibility'
        ELSE 'General Wellness'
    END AS Goals,
    CASE (g.series % 10)
        WHEN 1 THEN 'Chronic Knee Pain'
        WHEN 2 THEN 'Shoulder Injury History'
        ELSE 'None'
    END AS Injuries,
    CASE (g.series % 4)
        WHEN 0 THEN 'HIIT, Spin'
        WHEN 1 THEN 'Yoga, Pilates'
        WHEN 2 THEN 'Strength Training'
        ELSE 'Cardio, Dance'
    END AS Preferred_Styles,
    (g.series % 4) + 1 AS Plan_ID
FROM generate_series(56, 155) AS g(series);

-- TRANSACTION inserts (same as your original)
INSERT INTO TRANSACTION_Table (Member_ID, Transaction_Details, Total_Revenue, Taxes_Collected, Revenue_Stream)
SELECT
    (generate_series % 55) + 1,
    CASE (generate_series % 4)
        WHEN 0 THEN 'Monthly Membership Fee'
        WHEN 1 THEN 'Annual Membership Renewal'
        WHEN 2 THEN 'PT 5-Pack Purchase'
        ELSE 'Retail: Protein Bar'
    END,
    CASE (generate_series % 4)
        WHEN 0 THEN 99.99
        WHEN 1 THEN 999.00
        WHEN 2 THEN 300.00
        ELSE 4.50
    END,
    CASE (generate_series % 4)
        WHEN 0 THEN 5.00
        WHEN 1 THEN 50.00
        WHEN 2 THEN 15.00
        ELSE 0.25
    END,
    CASE (generate_series % 4)
        WHEN 0 THEN 'Membership'
        WHEN 1 THEN 'Membership'
        WHEN 2 THEN 'Training Package'
        ELSE 'Retail'
    END
FROM generate_series(1, 60);

INSERT INTO TRANSACTION_Table (Member_ID, Transaction_Details, Total_Revenue, Taxes_Collected, Revenue_Stream)
SELECT
    (generate_series % 155) + 1,
    CASE (generate_series % 4)
        WHEN 0 THEN 'Monthly Membership Fee'
        WHEN 1 THEN 'Annual Membership Renewal'
        WHEN 2 THEN 'PT 5-Pack Purchase'
        ELSE 'Retail: Protein Bar'
    END,
    CASE (generate_series % 4)
        WHEN 0 THEN 99.99
        WHEN 1 THEN 999.00
        WHEN 2 THEN 300.00
        ELSE 4.50
    END,
    CASE (generate_series % 4)
        WHEN 0 THEN 5.00
        WHEN 1 THEN 50.00
        WHEN 2 THEN 15.00
        ELSE 0.25
    END,
    CASE (generate_series % 4)
        WHEN 0 THEN 'Membership'
        WHEN 1 THEN 'Membership'
        WHEN 2 THEN 'Training Package'
        ELSE 'Retail'
    END
FROM generate_series(61, 160);

INSERT INTO WORKOUT_SESSION (Member_ID, Trainer_ID, Class_ID, Date, Duration, Check_In_Time, Check_Out_Time, Personal_Bests_Achieved)
SELECT
    (generate_series % 155) + 1,
    (generate_series % 10) + 1,
    CASE (generate_series % 5)
        WHEN 0 THEN (generate_series % 15) + 1
        ELSE NULL
    END,
    current_date - (generate_series || ' days')::interval,
    CASE (generate_series % 3)
        WHEN 0 THEN 60
        WHEN 1 THEN 45
        ELSE 90
    END,
    '09:00:00',
    '10:00:00',
    CASE WHEN (generate_series % 10) = 0 THEN TRUE ELSE FALSE END
FROM generate_series(1, 70);

DO $$
DECLARE
    session_cursor RECORD;
    data_point_counter INT := 1;
    records_per_session INT := 5;
BEGIN
    FOR session_cursor IN
        SELECT Session_ID FROM WORKOUT_SESSION ORDER BY Session_ID
    LOOP
        -- Insert 5 WEARABLE_DATA records for the current Session_ID
        FOR i IN 1..records_per_session LOOP
            INSERT INTO WEARABLE_DATA (
                Session_ID,
                Heart_Rate,
                Calories_Burned,
                Power_Output,
                Time_in_Target_Zones,
                Timestamp
            )
            VALUES (
                session_cursor.Session_ID,
                -- Simulate heart rate (120 - 170)
                120 + (i * 10) % 50,
                -- Simulate calories burned
                50.0 + (i * 15.5),
                -- Simulate power output
                10.0 + (i * 2.5),
                -- Simulate time in target zones
                30 + (i * 2),
                -- Simulate timestamp
                NOW() - (i || ' minutes')::interval
            );
            data_point_counter := data_point_counter + 1;
        END LOOP;
    END LOOP;
    RAISE NOTICE 'Successfully inserted % WEARABLE_DATA records.', data_point_counter - 1;
END $$;

select *
from Transaction_Table;