-- Table: RequestAccepted

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

-- Write a solution to find the people who have the most friends and the most friends number.

-- The test cases are generated so that only one person has the most friends.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- RequestAccepted table:
-- +--------------+-------------+-------------+
-- | requester_id | accepter_id | accept_date |
-- +--------------+-------------+-------------+
-- | 1            | 2           | 2016/06/03  |
-- | 1            | 3           | 2016/06/08  |
-- | 2            | 3           | 2016/06/08  |
-- | 3            | 4           | 2016/06/09  |
-- +--------------+-------------+-------------+
-- Output: 
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+
-- Explanation: 
-- The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
 

-- Follow up: In the real world, multiple people could have the same most number of friends. Could you find all these people in this case?

-- Solution 1

with cte1 as (
    select requester_id as id, count(accepter_id) as friends from requestaccepted
    group by requester_id
    union all
    select accepter_id as id, count(requester_id) as friends from requestaccepted
    group by accepter_id
)
    select id, sum(friends) as num from cte1
    group by id
    order by sum(friends) desc
    limit 1

-- Solution 2

WITH TotalFriends AS (
    SELECT id, COUNT(*) AS num
    FROM (
        SELECT requester_id AS id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS id FROM RequestAccepted
    ) AS all_ids
    GROUP BY id
)
SELECT id, num
FROM (
    SELECT id, num, RANK() OVER (ORDER BY num DESC) as rnk
    FROM TotalFriends
) ranked_table
WHERE rnk = 1;
