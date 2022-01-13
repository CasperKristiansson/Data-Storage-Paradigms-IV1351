# SQL

## Introduction
Task 3 involved creating different types of queries which would be performed on the database. To solve this task the author watched the lecture on “SQL - The Structured Query Language” which covered basic SQL commands. But to get enough information to solve the task the author also read the chapters 6 and 7 in the book Fundamentals of Database Systems which covered a range of basic to advanced SQL commands.

## Method
The next task of the project was to create SQL queries to manage different tasks that will be performed on the data in the database. Those queries include:
•	Number of lessons per month during a specific year
•	Number of different lesson types per month
•	Average number of lessons for each month
•	Count the number of lessons different instructors has given
•	List ensembles that will be held upcoming week and mark them if they have 1-2 seats left, or more seats left

When designing the database, the author chooses to use PostgreSQL as the database management system. The author uses pgAdmin which is develop for PostgreSQL to run the different queries and to view the different tables and views. Before the author was running the different queries in the database, they were developed in the code editor visual studio code.

The goal of the task is to create a view for each of the different queries which can be done using either a materialized or a normal view. When running a query using a view command will result in a logical view being created which “looks” like a normal table. The view will consist of the commands specifications and therefore can be used to verify that the command performs the right action on the data. For example, if the goal is to verify that the first command “number of lessons per month during a specific year” works, the author needed to manually check the number of lessons that were given a couple of months during the year. It can later be verified that both the manual check and the view will consist of the same data and therefore the query is valid.

## Result
Each solution for the queries will be shown below in the different figures.

The first query that was created was the view for counting the number of lessons given per month during a year. As seen in figure 3.3 the author creates a view called “lesson_count_month” which selects all the different month from time and count the number of lessons that fulfills the requirement of the year and month. By using the group command is used to arrange the data into groups by its month to match the EXTRACT (month FROM time), otherwise the count command would only return a number for the entire year. In the first extract command we also specify that the month column name should be named month.

```SQL
CREATE VIEW lesson_count_month AS
    SELECT
    EXTRACT(month FROM time) AS month,
    count(*) FROM lesson WHERE EXTRACT(YEAR FROM time) = '2021' GROUP BY EXTRACT(month FROM time)
    ORDER BY EXTRACT(month FROM time) ASC;
```
*Figure 3.3: The SQL query for creating a view and counting the number of lessons given per month during a specific year.*

The next goal is to create a view for the number of different lessons that exists each month during a specific year which can be seen in figure 3.5. This can be achieved using the COUNT(*) command and group them using MONTH by using the EXTRACT command. The view that gets created can be seen in figure 3.6.
```SQL
CREATE VIEW lesson_count_type_month AS
    SELECT lesson_type ,COUNT(*) as amount ,EXTRACT(MONTH FROM time) as month from lesson
    WHERE EXTRACT(YEAR FROM time) = '2021'
    GROUP BY month, lesson_type;
```
*Figure 3.5: The SQL query for creating a view and counting the number of lessons for each lesson type*

By using the EXTRACT command from the query in figure 3.9 it is possible to check whenever a lesson fulfills the requirement of a specific year. Then its only necessary to divide the count by 12.0 to get an average number of lessons given that year per month. The view that gets created can be seen in figure 3.10 which consist of a float number to be the average number of lessons.
```SQL
CREATE VIEW lesson_average_year AS
    SELECT count(CASE WHEN EXTRACT(YEAR FROM time) = '2021' THEN 1 ELSE NULL END)/12.0 as average FROM lesson
```
*Figure 3.7: The SQL query for creating a view and counting the number of lessons given a year and dividing it by the amount of months*
```SQL
CREATE VIEW lesson_average_type AS
    SELECT lesson_type, COUNT(*)/12.0 as amount from lesson
    WHERE EXTRACT(YEAR FROM time) = '2021'
    GROUP BY lesson_type;
```
*Figure 3.9: The SQL query for creating a view and counting the number of lessons given in a year for the different types of lesson*

The next SQL query is to count the number of lessons a teacher has given and if that count is bigger than a specific number it should be shown. The view can be used to figure out what teachers might be overworking themselves. The query uses as before EXTRACT to figure out that the lesson is during the year 2021 and the month three. Then the result is grouped by instructor id but only instructor ids which has a count bigger than three. In the view it can be seen that the teacher with the id 2 has given seven lessons during 2021.
```SQL
CREATE VIEW lesson_average_instructor AS
    SELECT instructor_id, count(*) FROM lesson WHERE EXTRACT(YEAR FROM time) = '2021' AND EXTRACT(MONTH FROM time) = '3' GROUP BY instructor_id HAVING COUNT(*) > 0
    ORDER BY count(*) DESC;
```
*Figure 3.11: The SQL query for creating a view and counting the number of lessons given a year and dividing it by the amount of months*

The last query that was needed to be solved was to figure out what the next weeks ensemble lessons and mark them with a specific number of seats left. For example, if only one seat remains the column should state that. This can be completed using CASES. In the materialized view below the data is sorted by genre and then the weekday. It is possible to automatically determine what lessons are given next week using data_trunc which can add weeks to a certain date.
```SQL
CREATE MATERIALIZED VIEW lesson_next_week AS
    SELECT lesson_type, to_char(time, 'Day') as weekday, genre, time,
    CASE
        WHEN amount_students = max_students THEN 'full'
        WHEN amount_students = max_students - 1 THEN '1 seats left'
        WHEN amount_students = max_students - 2 THEN '2 seats left'
        ELSE 'More than 2 seats left'
    END as seats_left
    FROM lesson WHERE date_trunc('week', time) = date_trunc('week', now()) + interval '1 week' AND lesson_type = 'ensemble' ORDER BY genre, weekday;
```
*Figure 3.13: The SQL query for creating a materialized view and checking which ensembles lessons are given the next week and the number of seats left.*

## Discussion
The main reason to either use views (virtual table) or materialized views in SQL is because it is a great way to optimize a database. For example, if the task is to execute queries on three different tables, rather than having to join them together multiple times it might be a better idea to create a temporary view of them which than is used to execute queries on, Fundamentals of Database Systems Chapter 7.

The substantial difference between a view and a materialized view is that a view is a logical virtual copy of a table while a materialized view is stored on the disk, it is a physical copy of a table. Because of this a “normal” view will have slower processing speed while a materialized view will have faster processing speed. A downside to materialized view is that it requires memory space while a view does not.

When creating the different views for the queries the author chooses to use materialized view for the query that would be executed weekly to get the different ensembles the upcoming week. This is because that schedule will be used by multiple students often. Therefore, it might be better to save it as a materialized view due to the faster processing speed. But for the rest of the views the author chooses to use a normal view because those queries would not be executed often because they were mainly focused on the lesson data for an entire year. Because of that it would be unnecessary to save it as a materialized view which would require memory space.

Therefore, it is important to be mindful when choosing to implement either a view or a materialized view on different queries.
