-- Top 10 Paying Jobs for Data Analysts
SELECT 
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM 
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'  -- You can adjust this to include other related job titles if needed
    AND job_location = 'Anywhere'     -- You can adjust this to filter by specific locations if needed
    AND salary_year_avg is NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10