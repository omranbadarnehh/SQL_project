WITH Top_10_Paying_Jobs as (
    SELECT 
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg
    FROM 
        job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'  -- you can change this to any other job title you want to analyze
        AND job_location = 'Anywhere'     -- you can change this to any other location you want to analyze
        AND salary_year_avg is NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    Top_10_Paying_Jobs.*,
    skills_dim.skills
FROM 
    Top_10_Paying_Jobs
INNER JOIN skills_job_dim
    ON Top_10_Paying_Jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
     salary_year_avg DESC;