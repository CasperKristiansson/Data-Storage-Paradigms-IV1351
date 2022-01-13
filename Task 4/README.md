# Programmatic Access
## Introduction
The last task consisted of creating a programmatic access to the database which would cover the renting instrument part of the database. The author solved the task by primarily watching the lectures on “Database Applications” which consisted of accessing the database using Java and performing various number of queries on the database. In the lecture about “Architecture and Design of a Database Application” the author was able to get sufficient knowledge on how to create a programmatic access program to the database using the MVC pattern.

## Method
The next task involved creating a command line user interface to oversee functionalities for renting instruments. Those functionalities include listing all available instruments, rent an instrument and terminate active rentals. The author decided to solve this task using the Model View Control (MVC) design pattern. The author followed these steps when solving the task:
1.	Creating a database connection
2.	Setting up SQL prepare statements (queries)
3.	Building the structure for the MVC design pattern

The first step of solving the task is to create a connection to the local Soundgood music school database. To complete this step, it was necessary to download the library PostgreSQL JDBC driver. After establishing a connection to the database, it was possible to execute different SQL queries. The second step is to create prepare statements which holds a SQL query and is precompiled, which than can efficiently be used to execute a query multiple times using the program (PreparedStatement Java Platform SE 7, 2021).

For the third and last step, the author continued solving the task by creating the different package for the MVC structure which followed the naming convention “main.java.se.kth.iv1351.soundGoodMusicSchool.” Additionally, the author divides the program into the different sections: controller, integration, model, startup, view. The integration layer would hold the methods which would execute SQL queries on the database. Several types of objects would be stored in the model layer such as instruments which holds the distinctive characteristics of an instrument such as price, brand, and type. The controller layer task would not be managing any logic but rather make the correct function calls from the other layers. The last layer, view, exists to represent the user with a command line interface, which the user could use to choose to either list, rent or terminate a rental of and instrument.

## Result
The author chose to represent the result of this task by selecting examples and important parts of the program.
In figure 3.15, the author developed a method called accessDB() which can establish a connection to the local Soundgood Music School database.
```java
private void accessDB() {
    try {
        Class.forName("org.postgresql.Driver");
        this.connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/SoundGoodMusicSchool", "postgres", Login.PASSWORD);
        connection.setAutoCommit(false);
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
}
```
*Figure 3.15: The method for establishing a connection to the database*

The figure 3.16 consist of one of the prepare statements which is used in the program. The example command performs the SQL query which selects the number of rows for a specific table which in this case is the rent_instrument table.
```java
getNumberOfRentals = connection.prepareStatement("SELECT COUNT(*) FROM " + RENT_INSTRUMENT_TABLE_NAME);
```
*Figure 3.16: Example of a prepare statement which is a precompiled SQL command*

The integration layer will consist of the methods which will execute queries. The figure 3.17 contains the method for renting an instrument. When renting an instrument two queries needs to be executed. The first one needs to mark an instrument as occupied and the other one needs to create a new rental. The method also consists of calling a method called validStudentRentalCount which checks if a student has already reached its maximum of number of active rentals.
```java
public void rentInstrument(int instrumentId, int studentId) throws InstrumentDBException {
        String errorMessage = "Could not rent instrument for: " + studentId;

        try {
            if (!validStudentRentalCount(studentId) || !validInstrumentAvailability(instrumentId)) {
                handleException(errorMessage, null);
            }

            rentInstrument.setInt(1, instrumentId);
            int updatedRows = rentInstrument.executeUpdate();

            if (updatedRows != 1) {
                handleException(errorMessage, null);
            }

            updateInstrument.setInt(1, rental_id());
            updateInstrument.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            updateInstrument.setInt(3, studentId);
            updateInstrument.setBoolean(4, false);
            updateInstrument.setInt(5, instrumentId);
            updatedRows = updateInstrument.executeUpdate();

            if (updatedRows != 1) {
                handleException(errorMessage, null);
            }

            connection.commit();

        } catch (SQLException e) {
            handleException(errorMessage, e);
        }
    }
```
*Figure 3.17: The method for renting an instrument*

To deal with the exception handling of the program and in the case that some queries might fail, the author tries to achieve good ACID transaction handling using queries rollback. In figure 3.19 the author tries to rollback the quires incase if something goes wrong.
```java
public void handleException(String errorMessage, Exception e) throws InstrumentDBException {
        String completeErrorMessage = errorMessage;

        try {
            connection.rollback();
        } catch (SQLException rollbackException) {
            completeErrorMessage += " Could not rollback transaction" + rollbackException.getMessage();
        }

        if (e != null) {
            throw new InstrumentDBException(completeErrorMessage, e);
        } else {
            throw new InstrumentDBException(completeErrorMessage);
        }
    }
```
*Figure 3.19: Exception handling using rollback*

In figure 3.18 a sample printout of the program can be seen. It shows all the different commands that can be executed. That includes listing all commands, listing all instruments, renting, and terminating a rental.

![](/Project%20Images/Sample%20printout%20Task%204.png)

## Discussion
Because the author made sure in previously tasks that the database can perform all the required functionalities, implementing the command line interface and its program was simple. A user can list all instruments that is available and with a specific instrument type, it can rent an instrument and terminate an ongoing rental.

Because of the database structure, some queries will be needed to be rolled back if the other one fails. For example, if a user rents an instrument, it requires to execute two queries. One to mark the instrument as occupied, and one to create a rental. If the second one fails, the first one will be able to be rolled back and therefore the instrument will not be marked as occupied. This also applies when a user is terminating a rental.

When the author designed the program, it was important to implement ACID transaction (atomicity, consistency, isolation, and durability). As discussed above the program has a good atomicity because if a request to rent an instrument fails at a certain part, the other queries will be rolled back. The program has consistency of data because if an instrument is being rented there will never be a point where the instrument will be occupied and not being rented at the same time, Fundamentals of Database Systems Chapter 20. Before a student can rent an instrument it is first checked that the instrument is availed. This is because first off you should not be able to rent an instrument if its already rented and this also helps for the isolation because if two rentals happen at the same time. What will happened is that one of them will fail because the other one will already have marked the instrument as occupied.

Because the author turned off auto commit for the atomicity its important to always commit after the different commands have been executed. After the commit command have taken place, the database will have stored that data and therefore the program will have good durability incase if for some reason the program just disconnects. All classes and packages follow the naming convention. The author also made sure that all different layers in the MVC pattern manages the correct logic.
