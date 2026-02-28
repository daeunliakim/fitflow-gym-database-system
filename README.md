# FitFlow: Gym Membership Relational Database System

## Overview

FitFlow is a relational database system designed to support operations, revenue tracking, and performance analytics for a fitness membership platform.

The system models:

- Membership plans and billing
- Trainers and exercise classes
- Member activity and workout sessions
- Transaction revenue streams
- Wearable fitness data integration

This project demonstrates database design, data integrity enforcement, synthetic data generation, and analytics-ready schema architecture.

---

## System Architecture

The database includes 7 core tables:

- MEMBERSHIP_PLAN
- MEMBER
- TRAINER
- EXERCISE_CLASS
- WORKOUT_SESSION
- WEARABLE_DATA
- TRANSACTION_Table

### Key Design Features

- Primary & Foreign Key relationships
- CHECK constraints for data integrity
- Revenue validation constraints
- Support for nullable relationships (e.g., personal training vs class sessions)
- Time-series wearable fitness data integration

---

## Data Generation

Synthetic data was generated using PostgreSQL `generate_series` for:

- 150+ members
- 10 trainers
- 15 class types
- 160+ financial transactions
- 70 workout sessions
- 350+ wearable sensor records

This enables realistic testing of operational and analytics queries.

---

## Analytics Capabilities

The schema supports:

- Revenue analysis by membership type
- Trainer performance and attendance tracking
- Member engagement analysis
- Workout frequency trends
- Wearable data performance tracking (heart rate, calories, power output)
- Transaction stream segmentation (membership vs retail vs training packages)

A dashboard visualization report is included to demonstrate business insights.

---

## Example Queries

- Monthly revenue by revenue stream
- Trainer class attendance rates
- Active vs frozen membership distribution
- High-performing members by personal best achievements
- Average heart rate per session

---

## Technologies

- PostgreSQL
- Relational Schema Design
- SQL Constraints & Data Validation
- Synthetic Data Generation
- BI Dashboard Visualizations

---

## Key Takeaways

This project demonstrates:

- End-to-end relational modeling
- Operational transaction system design
- Data integrity enforcement
- Integration of structured and time-series wearable data
- Business analytics readiness

FitFlow illustrates how transactional databases can directly support downstream analytics and decision-making systems.
