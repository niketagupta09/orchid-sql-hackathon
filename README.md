# orchid-sql-hackathon
Organ Donation Data Analysis

ORCHID Dataset – Analysis Overview
1. Dataset Purpose
Focuses on the organ procurement process in the United States.
Designed to improve understanding of how potential organ donors move through the system.
Helps identify inefficiencies, delays, and disparities in organ donation.
Supports research, policy evaluation, and predictive modeling.

2. Data Coverage
~133,000 potential organ donors.
Data collected from 6 U.S. Organ Procurement Organizations (OPOs).
Time period: 2015–2021.
Real-world, multi-center dataset.

3. Main Data Tables
A. OPO Referrals
One record per referred patient.
Includes:
Demographics (age, sex)
Cause of death
Key timestamps (referral, consent request, authorization, procurement)
Donation outcome (organs recovered or not)
Useful for:
Studying conversion rates
Time interval analysis
Outcome prediction

B. OPO Events
Time-stamped clinical measurements.
Includes:
Lab values (blood tests, chemistry)
Blood gas results
Vital signs (heart rate, blood pressure)
Infection results
Fluid balance
Useful for:
Clinical stability analysis
Predicting donor suitability
Time-series modeling

C. OPO Deaths (CalcDeaths)
Estimated total deaths in OPO service areas.
Used as a denominator to calculate:
Donation rates
OPO performance metrics
Useful for:
Regional comparison
Performance benchmarking

4. Organ Procurement Process Stages (Key Analysis Flow)
Referral (Hospital notifies OPO)
Evaluation (Donor suitability assessed)
Approach (Family contacted for consent)
Authorization (Consent obtained)
Procurement (Organs recovered)
Allocation/Transplant coordination
These stages allow:
Drop-off analysis between steps
Time delay measurement
Bottleneck identification

5. Data Characteristics
De-identified for privacy.
Dates are shifted but time intervals remain valid.
Ages > 89 are grouped for anonymity.
Structured in CSV format.

6. Possible Analysis Areas
A. Performance Analysis
Referral-to-procurement conversion rate
Time taken at each stage
OPO-level performance comparison
B. Disparity Analysis
Donation rates by age, sex
Regional variation
Differences in consent rates
C. Clinical Predictive Modeling
Predict likelihood of procurement
Identify clinical factors affecting organ recovery
Time-series modeling using event data
D. Process Optimization
Identify delays in consent or evaluation
Measure impact of clinical instability
Improve decision support tools

7. Key Metrics to Calculate
Authorization rate = Authorized / Approached
Procurement rate = Procured / Authorized
Overall conversion rate = Procured / Referred
Median time between process stages
Organs recovered per donor

