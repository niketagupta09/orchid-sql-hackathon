/* =============================================================================
LAYER 2: STAGING (TYPE CASTING + BASIC STANDARDIZATION)
- staging schema holds “stage” tables
- Apply TRIM, NULLIF, type casts, and Y/N → boolean conversions
============================================================================= */

CREATE SCHEMA IF NOT EXISTS staging;
		-- Creates staging schema if it doesn’t exist (safe to re-run).

DROP TABLE IF EXISTS staging.referrals_stage;
		-- Drops the stage table if it already exists so you can rebuild it cleanly.
		
CREATE TABLE staging.referrals_stage AS
SELECT
    -- Identifiers
    TRIM(patientid) AS patientid,
    TRIM(hospitalid) AS hospitalid,
    TRIM(opo) AS opo,

    -- Demographics (raw → Silver will clean)
    NULLIF(TRIM(age::TEXT), '') AS age,
    NULLIF(TRIM(gender), '') AS gender,
    NULLIF(TRIM(race), '') AS race,

    -- Referral flags (Y/N → boolean)
    (tissue_referral = 'Y') AS tissue_referral,
    (eye_referral = 'Y') AS eye_referral,

    -- Cause of death fields
    TRIM(cause_of_death_opo) AS cause_of_death_opo,
    TRIM(cause_of_death_unos) AS cause_of_death_unos,
    TRIM(mechanism_of_death) AS mechanism_of_death,
    TRIM(circumstances_of_death) AS circumstances_of_death,

    -- Blood type
    TRIM(abo_bloodtype) AS abo_bloodtype,
    TRIM(abo_rh) AS abo_rh,

    -- Height & Weight (cast to NUMERIC to avoid integer errors)
    NULLIF(TRIM(heightin::TEXT), '')::NUMERIC AS heightin,
    NULLIF(TRIM(weightkg::TEXT), '')::NUMERIC AS weightkg,

    -- Process flags
    (brain_death = 'Y') AS brain_death,
    (approached = 'Y') AS approached,
    (authorized = 'Y') AS authorized,
    (procured = 'Y') AS procured,
    (transplanted = 'Y') AS transplanted,

    -- Timestamps (safe casting)
    CAST(NULLIF(time_brain_death, '') AS TIMESTAMP) AS time_brain_death,
    CAST(NULLIF(time_asystole, '') AS TIMESTAMP) AS time_asystole,
    CAST(NULLIF(time_referred, '') AS TIMESTAMP) AS time_referred,
    CAST(NULLIF(time_approached, '') AS TIMESTAMP) AS time_approached,
    CAST(NULLIF(time_authorized, '') AS TIMESTAMP) AS time_authorized,
    CAST(NULLIF(time_procured, '') AS TIMESTAMP) AS time_procured,

    -- Year fields (cast to NUMERIC to avoid decimal errors)
    NULLIF(referral_year::TEXT, '')::NUMERIC AS referral_year,
    TRIM(referral_dayofweek) AS referral_dayofweek,
    NULLIF(procured_year::TEXT, '')::NUMERIC AS procured_year,

    
    -- Organ outcomes (keep original values, convert to VARCHAR(100))
	NULLIF(TRIM(outcome_heart), '')::VARCHAR(100) AS outcome_heart,
	NULLIF(TRIM(outcome_liver), '')::VARCHAR(100) AS outcome_liver,
	NULLIF(TRIM(outcome_kidney_left), '')::VARCHAR(100) AS outcome_kidney_left,
	NULLIF(TRIM(outcome_kidney_right), '')::VARCHAR(100) AS outcome_kidney_right,
	NULLIF(TRIM(outcome_lung_left), '')::VARCHAR(100) AS outcome_lung_left,
	NULLIF(TRIM(outcome_lung_right), '')::VARCHAR(100) AS outcome_lung_right,
	NULLIF(TRIM(outcome_intestine), '')::VARCHAR(100) AS outcome_intestine,
	NULLIF(TRIM(outcome_pancreas), '')::VARCHAR(100) AS outcome_pancreas

FROM bronze.referrals_raw
WHERE patientid IS NOT NULL;
		-- Only keep rows where patientid exists (prevents unusable records).
		
-------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS staging.calc_deaths_stage;
		-- Drop old stage table if present.


CREATE TABLE staging.calc_deaths_stage AS
SELECT
    TRIM(opo) AS opo,
    CAST(NULLIF(year::TEXT, '') AS INT) AS year,
    NULLIF(calc_deaths::TEXT, '')::NUMERIC AS calc_deaths,
	NULLIF(calc_deaths_lb::TEXT, '')::NUMERIC AS calc_deaths_lb,
	NULLIF(calc_deaths_ub::TEXT, '')::NUMERIC AS calc_deaths_ub
FROM bronze.calc_deaths_raw
WHERE opo IS NOT NULL;
		-- Keep only rows with a valid OPO key.	
		
