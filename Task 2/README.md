# Logical and Physical Model

## Introduction
The next task consisted of creating a logical or a physical model. First, the author watched the lecture on “Logical and physical models,” which covered all the steps from converting a conceptual model to a logical model. The lecture consisted of what steps is required to converting a conceptual model to a logical or physical model. Second, the author read chapter 14 in the book Fundamentals of Database Systems Seventh Edition, Pearson (Elmasri & Navathe, June 8th 2015) which was used to detect and learn whenever a relation database scheme was good or bad. Third, the author applied that knowledge and was able to improve the model. For the SQL commands such as create the database and create “fake” data, the author reviewed the lecture on “SQL - The Structured Query Language.”

## Method
The next task of the project is to create a logical or a Physical model from the conceptual model that was created in the previous task. The author chooses to create a logical model. Converting a conceptual model to a logical model consist of six steps:
1.	Deciding which relations should be kept
2.	Specifying column types
3.	Adding column constraints
4.	Making sure that the model is normalized and that all different database operations can be performed on the model
5.	Specifying the different attributes
6.	Relations (many-to-many, one-to-many)

The first step consists of deciding which relations should be kept in the model. The author started by creating a table for each entity from the conceptual model. The author then created the columns which consisted of a cardinality of 0..1 or 1..1. The attributes which consist of more than one cardinality will have their own table. For example, instrument, sibling, student phone, student email. These tables will be connected using either a one-to-many or many-to-many relations. For example, the author created a many-to-many relations between student and lesson. This is because there are multiple students on each lesson and each student can have multiple lessons. But for student email, student phone the author created a one-to-many relationship because it should be possible for each student to have registered multiple contact details.

The second step was to specify each column type. In PostgreSQL there is a SERIAL pseudo-type which is used on ids. Each table consists of a PK (primary key) which primarily is used to find specific rows in the table, to be consistent the author chooses to have the ids of each table as the primary key. Otherwise, the rest of the values in the table would either be a VARCHAR or a INT. The author also thoroughly decided which column should consist of NOT NULL elements, for example you cannot add a person or instructor without adding a person number.

In the third step, the author added column constraints to the model. It is important to add constraints to columns to decide what to do if certain actions are performed. For example, what should happen if someone removes an instructor id from a lesson or if someone removes a phone number from a student. Each of these specifications can be created using commands like ON DELETE CASCADE, ON DELETE SET NULL or ON DELETE NO ACTION. For the different ids in lesson the author decided to add SET NULL ON DELETE because if a lessons price type, instructor, or room for some reasons should be removed the entire lesson should not be removed from the database. But if someone decides to remove a phone number to a student it would be unnecessary to store just the student id and therefore the author uses ON DELETE CASCADE.

The fourth step is to make sure the model is normalized. The author followed to create the logical model was to make sure that the model follows all the different database operations. This required that the author needed to make sure that all the upcoming tasks like searching for lessons could be performed on the model. It was also important to try and reduce data redundancy and improve data integrity by making sure that we do not store unnecessary amount of data or that it exists unnecessary relations.

The fifth step was to add all the different attributes to the model. This could simply be done by moving the different attributes from the conceptual model to the logical model. But as mentioned in step one some of the attributes became their own many-to-many relation. The last step of the task was to add the different relations between the entities. Because some of the attributes became entities new relations was needed to be established.

The additional step of this task was to create a SQL script to create the database and a script to create “fake” data.

## Result
The solution to the logical model can be found in figure 3.2. In the figure it can be seen that it follows the same structure as task one where it focuses on the student and instructor. The author created the required many-to-many relations for example student_lesson for which consist of all the different lessons a student is signed up. To represent the 0..* cardinality it was added a one-to-many relationship between instructor and instrument. The author chose to replace the inheritance and merged them together to entity lesson.

![](/Project%20Images/Logical%20Model%20Task%202.jpg)
*Figure 3.2: The author solution to logical model.*

## Discussion
When designing the logical model, the author made sure to follow the guidelines for the UML notation correctly and the naming convention. The logical follows mostly the third normal form (3NF) except on two separate occasions. 3NF is used to avoid duplicate data, avoid data anomalies and simply management of data. But in the case of student and instructor where they can both be identified either using the id or their person number. The author’s motivation behind creating an id number is to not display a person’s person number which should remain private.

Because the author chooses to thoroughly design the database, it can run all the different operations (business transactions), no tables are missing, and no unnecessary tables exist in the database. Each table only consist of relevant columns and data. The author made sure that all column constraints and foreign key constraints are specified with either ON DELETE SET NULL, ON DELETE CASCADE or ON DELETE NO ACTION. All primary keys are well chosen so it can be easily understood and easy to use to select specific data.

When designing the logical model, the author noticed that the conceptual model consisted of couple of flaws. For example, the system for renting an instrument was reconstructed. This is because otherwise it would not follow the task four goal which is to keep track of past and current rentals. By using this system, the model has a table of all instruments and a table for renting instruments. If someone wants to rent an instrument it gets added to the renting instrument table which consist of all essential information about the rental. The author also decided to create a pricing scheme to easily check and update prices for different types of lessons.

The author’s solution to the logical model has one flaw which is the lesson table. Because the author decided to merge all the different lesson types, it is needed to store a bit of null values. For example, the individual lesson does not consist of max or min students and therefore its values become null. A better system would be to continue the design from task one and keep the inheritance between the lesson and lesson types. That way each table will not consist of null/empty values.
