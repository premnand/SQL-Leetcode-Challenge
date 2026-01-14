-- Table: Stadium

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | visit_date    | date    |
-- | people        | int     |
-- +---------------+---------+
-- visit_date is the column with unique values for this table.
-- Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
-- As the id increases, the date increases as well.
 

-- Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

-- Return the result table ordered by visit_date in ascending order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Stadium table:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Output: 
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Explanation: 
-- The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
-- The rows with ids 2 and 3 are not included because we need at least three consecutive ids.

-- Solution 1

SELECT s1.*
FROM Stadium s1
LEFT JOIN Stadium s2
on s1.id + 1 = s2.id
left join stadium s3
ON s1.id + 2 = s3.id
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100

UNION 

SELECT s2.*
FROM Stadium s1
LEFT JOIN Stadium s2
on s1.id + 1 = s2.id
left join stadium s3
ON s1.id + 2 = s3.id
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100

UNION 

SELECT s3.*
FROM Stadium s1
LEFT JOIN Stadium s2
on s1.id + 1 = s2.id
left join stadium s3
ON s1.id + 2 = s3.id
where s1.people >= 100 and s2.people >= 100 and s3.people >= 100

ORDER BY visit_date ASC;

-- Solution 2

WITH ConsecutiveGroups AS (
    SELECT *, 
           -- Check the rows before and after to see if they meet the criteria
           LAG(people, 2) OVER (ORDER BY id) as prev2,
           LAG(people, 1) OVER (ORDER BY id) as prev1,
           LEAD(people, 1) OVER (ORDER BY id) as next1,
           LEAD(people, 2) OVER (ORDER BY id) as next2
    FROM Stadium
)
SELECT id, visit_date, people
FROM ConsecutiveGroups
WHERE (people >= 100 AND prev1 >= 100 AND prev2 >= 100) -- Current is 3rd in row
   OR (people >= 100 AND prev1 >= 100 AND next1 >= 100) -- Current is 2nd in row
   OR (people >= 100 AND next1 >= 100 AND next2 >= 100) -- Current is 1st in row
ORDER BY visit_date;
