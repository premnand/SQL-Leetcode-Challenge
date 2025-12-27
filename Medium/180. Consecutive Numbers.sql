-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- In SQL, id is the primary key for this table.
-- id is an autoincrement column starting from 1.
 

-- Find all numbers that appear at least three times consecutively.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.

-- Solution 1

SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num, 
           LEAD(num, 1) OVER (ORDER BY id) AS next_1,
           LEAD(num, 2) OVER (ORDER BY id) AS next_2
    FROM logs
) subquery
WHERE num = next_1 AND num = next_2;

-- Solution 2

SELECT DISTINCT l1.num AS ConsecutiveNums
FROM logs l1
JOIN logs l2
  ON l2.id = l1.id + 1
JOIN logs l3
  ON l3.id = l1.id + 2
WHERE l1.num = l2.num
  AND l2.num = l3.num;
