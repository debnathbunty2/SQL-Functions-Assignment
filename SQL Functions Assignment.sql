CREATE TABLE Student_Performance (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) not null,
    course VARCHAR(30),
    score INT not null,
    attendance INT,
    mentor VARCHAR(50),
    join_date DATE not null,
    city VARCHAR(50) not null
);

INSERT INTO Student_Performance (student_id, name, course, score, attendance, mentor, join_date, city)
VALUES
(101, 'Aarav Mehta', 'Data Science', 85, 92, 'Dr. Sharma', '2023-06-11', 'Mumbai'),
(102, 'Riya Singh', 'Data Science', 78, 89, 'Dr. Sharma', '2023-07-01', 'Delhi'),
(103, 'Kabir Khanna', 'Python', 91, 90, 'Ms. Nair', '2023-06-28', 'Mumbai'),
(104, 'Tanvi Patel', 'SQL', 88, 85, 'Mr. Iyer', '2023-06-29', 'Bengaluru'),
(105, 'Ayesha Khan', 'Python', 87, 91, 'Ms. Nair', '2023-07-10', 'Hyderabad'),
(106, 'Dev Sharma', 'SQL', 73, 78, 'Mr. Iyer', '2023-06-30', 'Pune'),
(107, 'Arjun Verma', 'Tableau', 90, 88, 'Ms. Kapoor', '2023-06-25', 'Delhi'),
(108, 'Meera Pillai', 'Tableau', 87, 87, 'Ms. Kapoor', '2023-06-18', 'Kochi'),
(109, 'Nikhil Rao', 'Data Science', 79, 82, 'Dr. Sharma', '2023-07-05', 'Chennai'),
(110, 'Priya Desai', 'SQL', 92, 94, 'Mr. Iyer', '2023-05-27', 'Bengaluru'),
(111, 'Siddharth Jain', 'Python', 85, 90, 'Ms. Nair', '2023-07-03', 'Mumbai'),
(112, 'Sneha Kulkarni', 'Tableau', 84, 89, 'Ms. Kapoor', '2023-06-30', 'Pune'),
(113, 'Rohan Gupta', 'SQL', 87, 91, 'Mr. Iyer', '2023-06-25', 'Delhi'),
(114, 'Ishita Joshi', 'Data Science', 93, 92, 'Dr. Sharma', '2023-06-21', 'Bengaluru'),
(115, 'Yuvraj Rao', 'Python', 71, 86, 'Ms. Nair', '2023-07-12', 'Hyderabad');

select * from Student_Performance;

#Create a ranking of students based on score (highest first).
select student_id,name,score,
dense_rank() over(order by score desc) as Rank_
from Student_Performance;

# Show each student's score and the previous student’s score (based on score order).
select student_id,name,score,
lag(score,1) over(order 
by score desc) as prev_std_score
from Student_Performance;

#Convert all student names to uppercase and extract the month name from join_date.
select upper(name) as Up_name,monthname(join_date) as join_month from Student_Performance;

#Show each student's name and the next student’s attendance (ordered by attendance).
select student_id,name,
lead(attendance,1) over(order by attendance desc) as nxt_std_attd
from Student_Performance;

#Assign students into 4 performance groups using NTILE().
select student_id,name,score,
ntile(4) over(order by score desc) as ntile_grp
from Student_Performance;

#For each course, assign a row number based on attendance (highest first).
select student_id,name,course,
row_number() over( partition by course order by score desc) as row_num
from Student_Performance;

#Calculate the number of days each student has been enrolled (from join_date to today).(Assume current date = '2025-01-01')
select student_id,name,course,
datediff(now(),join_date) as no_of_enroll_date
from Student_Performance;

#Format join_date as “Month Year” (e.g., “June 2023”).
select student_id,name,course,
date_format(join_date,"%M-%Y") as join_date
from Student_Performance;

#Replace the city ‘Mumbai’ with ‘MUM’ for display purposes.
select student_id,name,city,
replace(city,"Mumbai","MUM") as rep_city
from Student_Performance;

#For each course, find the highest score using FIRST_VALUE().
select student_id,name,course,score,
first_value(score) over(partition by course order by score desc) as first_score_val
from Student_Performance;