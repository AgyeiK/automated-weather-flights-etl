# automated-weather-flights-etl
Gans Data Pipeline: An Automated ETL Journey
# 📖 Project Overview
This project was developed for "Gans," a fictional e-scooter startup. The goal was to build a robust data infrastructure to help the operations team predict scooter demand.

The project evolved through three distinct phases:

Data Seeding (Scraping): Manually gathering foundational city and population data.

API Integration: Enriching city data with real-time weather and flight information.

Cloud Automation: Moving the entire logic into a serverless environment for 24/7 data collection.

# 🏗️ The Three Pillars of the Pipeline
1. Web Scraping (The Foundation)
Before I could track weather or flights, I needed a reliable list of cities.

Tool: BeautifulSoup & Requests

Source: Wikipedia

Process: I scraped demographic data for major German cities. This involved cleaning messy HTML tables, handling Wikipedia citation markers (e.g., converting 3,769,495 [1] to a clean integer), and structuring the data into a "Seed" table.

2. API Data Extraction (The Enrichment)
Once the cities were in the database, I built two distinct extractors:

OpenWeatherMap API: Fetches 24-hour weather forecasts.

Aerodatabox API: Fetches arrival flight data for the following day (tomorrow).

Transformation: Used Pandas to normalize JSON responses into relational tables, ensuring timezone consistency using pytz.

3. Cloud Infrastructure (The Automation)
To move away from manual script execution, I deployed the logic to Google Cloud Platform (GCP):

Cloud SQL: Hosted a MySQL instance to store the data.

Cloud Functions: Re-engineered the Python logic into serverless, event-driven functions.

Cloud Scheduler: Set up Cron Jobs (0 * * * * for weather and flights) to ensure the database stays fresh automatically.

# 🛠️ Engineering Challenges & Troubleshooting
Web Scraping Edge Cases: Wikipedia tables are inconsistent. I had to write robust error handling to skip non-city rows and clean non-numeric characters from population counts.

Schema Mismatches: Debugged OperationalError by aligning Python dictionary keys with MySQL column names (e.g., mapping weather_description to weather).

Transactional Reliability: Solved the "Phantom Insert" problem (where the table would TRUNCATE but not INSERT) by implementing explicit conn.commit() logic in the SQLAlchemy connection.

# 📊 Tech Stack
Language: Python 3.10

Libraries: Pandas, BeautifulSoup, SQLAlchemy, Pymysql, Requests, Pytz

Infrastructure: Google Cloud Platform (Cloud Functions, Cloud SQL, Cloud Scheduler)

# API Sources: OpenWeatherMap, RapidAPI (Aerodatabox)

