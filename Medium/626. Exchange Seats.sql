-- Table: Seat

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key (unique value) column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- The ID sequence always starts from 1 and increments continuously.
 

-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Seat table:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |
-- +----+---------+
-- Output: 
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Doris   |
-- | 2  | Abbot   |
-- | 3  | Green   |
-- | 4  | Emerson |
-- | 5  | Jeames  |
-- +----+---------+
-- Explanation: 
-- Note that if the number of students is odd, there is no need to change the last one's seat.

-- Solution 1

WITH st_id AS (SELECT s1.id as id1, s1.student as std1, s2.id as id2, s2.student as std2
FROM Seat s1
LEFT JOIN Seat s2
ON s1.id + 1 = s2.id 
WHERE s1.id % 2 = 1)

SELECT id1 as id, std2 as student FROM st_id
WHERE id1 + 1 = id2
UNION 
SELECT id2 as id, std1 as student FROM st_id
WHERE id1 + 1 = id2
UNION 
SELECT id1 as id, std1 as student FROM st_id
WHERE std2 IS NULL

ORDER BY id;

-- Solution 2

SELECT 
    id,
    CASE 
        WHEN id % 2 = 1 THEN COALESCE(LEAD(student) OVER(ORDER BY id), student)
        ELSE LAG(student) OVER(ORDER BY id)
    END AS student
FROM Seat;
