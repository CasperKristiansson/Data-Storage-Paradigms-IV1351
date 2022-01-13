# Conceptual Model

## Introduction
Initially, the author went through course lectures on how to create a domain model and an example of a conceptual model. The author gained an understanding of the concept of a conceptual model and how to create one using various steps. This knowledge provided the author with the tools necessary to solve Task 1.

## Method
The goal of this task is to create a conceptual model for a music school. The author created the conceptual model by using the modelling program Astah. The model itself consist of an ER diagram (Entity-relationship model). Designing a conceptual model consist of five steps:
1.	Noun Identification
2.	Category lists
3.	Remove unnecessary entities
4.	Find attributes
5.	Find relations

The first step was to identify the nouns that consists in the description of the music school. The nouns that the author found would either become an entity or an attribute in the model. After the author finished that step, the second step was to identify more nouns using a categories list which can be found in the book “Object Oriented Development,” chapter 4. Using this method, the author can make sure that the model will consist of all the nous needed for the music school. The third step of the process was to remove unnecessary entities or rename them with better nouns.

The fourth step of the process is to find the attributes for each entity. Each entity that exists will either be a string, Boolean, number, or timestamp. It is also important to add the cardinality and if the attribute is allowed to be without value. The fifth and last step of designing the model is to declare and find relations between entities. The entities could either have an identifying, non-identifying, or many-to-many identifying relation.

## Result
The author solution to the conceptual model can be seen in figure 3.1. The conceptual model main structure is built around “Student” and “Instructor” entity. The “Lessons” entity is used for inheritance for each of the lesson types (“Ensembles”, “Individual Lessons”, “Group Lessons”). Each lesson is also given an instructor, room, and price scheme IDs. The author has added NOT NULL and the specific cardinality for all the different attributes.

A student can rent instruments from the renting instruments entity. The renting instruments entity keeps track of all the active rentals and a history of them. The model that the author designed is able perform all the required business transactions.

![Conceptual Model](/Project%20Images/Conceptual%20Model%20Task%201.png)
*Figure 3.1: The author solution to the conceptual model.*

## Discussion
When solving the task, the author made sure to punctually follow all the steps and guidelines when creating a conceptual model. The author made sure to follow the general naming convention for all the entities and attributes as well giving each a sufficient explaining name. During this step it was also important to have a reasonable number of entities and attributes which the author made sure to thoroughly examine if each needed to exist. For example, the author removed and remodeled the instrument entities because it had unnecessary data stored in both renting instrument and instruments.

When designing the conceptual model, the author made sure to follow the guidelines for the UML notation correctly. Each attribute in the diagram has a type and a cardinality specified. When solving the last step of the task the author made sure that the entities relations are relevant and follow the desired business rules.

The author chooses to use inheritance to represent the different lesson types. In figure 3.1, a main lesson table exists which holds the main attributes of a lesson such as lesson id, instructor id and classroom id. After that, the different lesson types, ensemble, group, and individual will inherit all the information from the lesson table. Using this method will avoid in redundant data rather than keeping all lesson data in one table. A disadvantage of using inheritance is that the solution might become excessively complex when it does not need to, that is why it is important to only use it when the relations between the child and parent are meaningful.
