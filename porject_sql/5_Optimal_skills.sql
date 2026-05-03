-- Optimal Skills to learn for Data Analysts
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact   
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE  job_title_short = 'Data Analyst' -- you can change this to any other job title you want to analyze
    GROUP BY skills, skills_dim.skill_id
    ORDER BY demand_count DESC
)
, average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        Round(AVG(salary_year_avg), 0) AS average_salary
    FROM job_postings_fact   
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE  job_title_short = 'Data Analyst' -- you can change this to any other job title you want to analyze
        AND salary_year_avg IS NOT NULL
    GROUP BY skills, skills_dim.skill_id
)
SELECT  skills_demand.skill_id,
        skills_demand.skills,
        demand_count,
        average_salary
FROM skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 2000 -- you can change this threshold to filter out less in-demand skills
ORDER BY average_salary DESC,demand_count DESC -- you can change the order by clause to prioritize either demand or salary
LIMIT 25 