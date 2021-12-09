import sqlite3
from sqlite3 import Error

# Allows us to open a connection to  the database file
def openConnection(_dbFile):

    connection = None
    try:
        connection = sqlite3.connect(_dbFile)
    except Error as e:
        print(e)

    return connection

def closeConnection(_connection, _dbFile):

    try:
        _connection.close()
    except Error as e:
        print(e)

# We want to create a table for the user:
def createTable(_connection):

    #create a user table to comb through sql data:
    try:
        #pre_sql_statement = """DROP TABLE IF EXISTS User"""
        sql =   """ CREATE table if not exists user(
                    u_id char(25),
                    u_division char(25) not null,
                    u_team char(25) not null,
                    u_player char(25) not null,
                    u_position char(25) not null)   
                """
        #_connection.execute(pre_sql_statement)
        _connection.execute(sql)
        _connection.commit()

    except Error as e:
        _connection.rollback()
        print(e)

# To ask for Admin input (need to add pre selected input to work):
def adminHandler(_connection):

    print("\nWelcome to the login page!\n")

    user_check = False

    while user_check == False:  # while loop while user_check is False
        print("Are you a User or Admin?\n")
        user_input = input("Enter either User or Admin or enter Stop to end the program: ")

        if user_input == "User" or user_input == "user":
            print("Now sending you to the Selection Page....\n")
            #exit this page and go directly to user handler:
            return False

        elif user_input == "Admin" or user_input == "admin":
            #continue with admin login 
            break

        else:
            #when user enters anything other than user and admin
            print("Have a nice day!")
            return True

    admin_user = input('Enter your username: ')
    admin_pass = input('Enter your password: ')

    cursor_object = _connection.cursor()

    #checking if the imput matches any value pair in the table:
    cursor_object.execute("""   SELECT a_username, a_pass
                                FROM Admin 
                                WHERE a_username = '{userid}' 
                                AND a_pass = '{passid}' 
                          """.\
                                format(userid=admin_user, passid=admin_pass))    

    #comparing the input to the value pairs in the database
    if not cursor_object.fetchone():  # An empty result evaluates to False.
        print("Login failed, for questions contact administration.")
        print("Will now be directed to User Selection\n")

        #goes straight to user UI
        return False

    else:
        # as admins we want to view all User data:
        sql =   """ SELECT *
                    FROM user """

        print("\nWelcome Admins")

        cursor_object.execute(sql)
        records = cursor_object.fetchall()

        #to display all data in the database:
        print("Printing all user data: \n ")
        for row in records:
            print("User Name: ", row[0])
            print("User Division: ", row[1])
            print("User Team: ", row[2])
            print("User Player: ", row[3])
            print("User Position: ", row[4] + "\n")

        print("Would you like to enter User Selection Mode, Modify the User Table or End the Program?")
        admin_input = input("Please enter User or Modify or End: ")

        if admin_input == "User" or admin_input == "user":
            #go to user input 
            return False
        elif admin_input == "Modify" or admin_input == "modify":
            # ends program 
            print("Taking you to Modification Menu...\n")
            #would place new function call exclusive for Admin Modification here:
            adminModify(_connection, admin_user)

        else: #ends program
            print("Ending Program")
            quit()
            

def adminModify(_connection, id):
    admin_user = id
    cursor_object = _connection.cursor()

    print("Welcome " + admin_user + " to the Admin Selection Menu")

    #to Display all users and their data:
    print("Displaying all users and associated data")

    sql =   """     SELECT *
                    FROM user """

    cursor_object.execute(sql)
    records = cursor_object.fetchall()

    #to display all data in the database:
    print("Printing all user data: \n ")
    for row in records:
        print("User Name: ", row[0])
        print("User Division: ", row[1])
        print("User Team: ", row[2])
        print("User Player: ", row[3])
        print("User Position: ", row[4])
        print("\n")

    #ask if there is a user that the admin would like to delete:
    print("Is there a User's data you would like to delete?")
    admin_desicion = input("Enter Yes or No: ")
    print("\n")

    if admin_desicion == "Yes" or admin_desicion == "yes":
        print("Who would you like to Delete from the Table?")
        userToDelete = input("Please enter the name as shown in the printed table above: ")

        #deleting the specified users from the user table:
        print("Deleting " + userToDelete + " From user table.")
        cursor_object.execute("""Delete FROM user
                         WHERE u_id = '{userName}' 
                      """.\
                            format(userName = userToDelete)) 
        #now to print the user table after deleting:
        sql =   """ SELECT *
                    From user """
        
        cursor_object.execute(sql)
        records = cursor_object.fetchall()

        #to display all data in the database:
        print("Printing all user data: \n ")
        for row in records:
            print("User Name: ", row[0])
            print("User Division: ", row[1])
            print("User Team: ", row[2])
            print("User Player: ", row[3])
            print("User Position: ", row[4])
            print("\n")

        print("User table has been printed")
    else:
        print("")

# Takes the user input and places selections into the table the first time
def userHandler(_connection):

    cursor_object = _connection.cursor()
    user_check = False

    print("Welcome to the User Selection Page!\n")
    #variable to account for the user inputs
    user_id = input('Enter your name: ')

    cursor_object.execute("""   SELECT u_id
                                FROM user
                                WHERE u_id = '{userid}'
                          """.\
                                format(userid=user_id,))    
    
    if not cursor_object.fetchone():  # An empty result evaluates to False.
        print("Welcome new User!")

        print("\n" + user_id + " please enter the following data")

        print('Enter your Favorite Division: ')
        user_division = input('Enter ATLANTIC, CENTRAL, SOUTHEAST, NORTHWEST, PACIFIC or SOUTHWEST: ')
        user_team = input('Enter your Favorite Team: ')
        user_player = input('Enter your Favorite Player: ')
        print('Enter your Favorite Position: ')
        user_position = input('Enter PG, SG, SF, PF or C: ')

        #enters user data into the user table
        cursor_object.execute(""" INSERT INTO user(u_id, u_division , u_team , u_player , u_position)
                            VAlUES('{userId}','{userDiv}','{userTeam}','{userPlay}','{userPos}')""".\
                            format(userId = user_id, userDiv = user_division, userTeam = user_team, userPlay = user_player, userPos = user_position))
       
        cursor_object.execute(""" 
                                SELECT *
                                FROM user
                                WHERE u_id = '{userId}'
                                """.\
                                    format(userId = user_id))
        records = cursor_object.fetchall()

        print("\nYour Profile Information: \n ")
        for row in records:
            print("Your Name: ", row[0] )
            print("Division: ", row[1])
            print("Team: ", row[2])
            print("Player: ", row[3])
            print("Position: ", row[4])
            print("")

    else: 
        
        cursor_object.execute(""" 
                                SELECT *
                                FROM user
                                WHERE u_id = '{userId}'
                                """.\
                                format(userId = user_id))
        records = cursor_object.fetchall()

        print("\nUser Already Exists")
        print("Your Profile Information: \n ")
        for row in records:
            print("Your Name: ", row[0])
            print("Division: ", row[1])
            print("Team: ", row[2])
            print("Player: ", row[3])
            print("Position: ", row[4])
            print("")

    print("Would you like to Update your profile?")
    user_input = input("Enter Yes or No: ")
    
    if user_input == "No" or user_input == "no" or user_input == "n":
        user_input = input("Would you like to continue with the program? ")
        if user_input == "Yes" or user_input == "yes" or user_input == "y":
            sqlHandler(_connection, row[0], row[1], row[2], row[3], row[4])
        else: 
            print("Ending Program")

    else:
        print("\nMoving to the updating user prefereces phase...")
        updateUser(_connection, row[0], row[1], row[2], row[3], row[4])

# updating the User Table with new values except for the users name: (it gets passed)
def updateUser(_connection, current_id, current_division, current_team, current_player, current_position):
     #creating a cursor object to handle sql statements:
    cursor_object = _connection.cursor()
    #to ensure the user doesnt want to re-enter something:
    new_user_id = current_id
    new_user_division = current_division
    new_user_team = current_team
    new_user_player = current_player
    new_user_position = current_position

    user_decision = ""

    print(new_user_id + " feel free to change your preferences!\n")

    user_decision = input('New Division? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_division = input('Enter your New Favorite Division: ')

    user_decision = input('New Team? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_team = input('Enter your New Favorite Team: ')
    
    user_decision = input('New Player? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_player = input('Enter your New Favorite Player: ')

    user_decision = input('New Positon? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_position = input('Enter your New Favorite Position: ')


    #we would update insted of insert, MAYBE make user varibales available to ne NULL
    cursor_object.execute("""
                            UPDATE user
                            SET u_division = '{userDiv}', u_team = '{userTeam}', u_player = '{userPlay}', u_position = '{userPos}' 
                            WHERE u_id = '{userId}'
                        """.\
                            format(userDiv = new_user_division, userTeam = new_user_team, userPlay = new_user_player, userPos = new_user_position, userId = new_user_id))

    display_sql =   """ SELECT *
                        FROM user
                        WHERE u_id = '{userId}'
                    """.\
                        format(userId = new_user_id)
    cursor_object.execute(display_sql)
    records = cursor_object.fetchall()

    print("\nPrinting your updated picks now: \n ")
    for row in records:
            print("Your Name: ", row[0] )
            print("Division: ", row[1])
            print("Team: ", row[2])
            print("Player: ", row[3])
            print("Position: ", row[4])
            print("")

    print("Would you like to continue updating your profile?")
    user_input = input("Enter Yes or No: ")
    
    if user_input == "No" or user_input == "no" or user_input == "n":
        user_input = input("Would you like to continue to the program? ")
        if user_input == "Yes" or user_input == "yes" or user_input == "y":
            sqlHandler(_connection, row[0], row[1], row[2], row[3], row[4])
        else: 
            print("Ending Program")

    else:
        print("\nMoving to the updating user prefereces phase...")
        updateUser(_connection, row[0], row[1], row[2], row[3], row[4])

    #the logic of where we will access the database and ask the user for various criteria to run sql statements:
def sqlHandler(_connection, current_id, current_division, current_team, current_player, current_position):
    cursor_object = _connection.cursor()

    user_id = current_id
    user_position = current_position

    print("\nWelcome, here you will be able to see data related to your user Preferences!")

    user_input = input("\nContinue with the program? ")
    user_check = ""

    if user_input == "Yes" or user_input == "yes" or user_input == "y":
        print("\nWould you like to see the player's stats?")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  

            player_sql = """    SELECT s_ppg, s_rpg, s_apg, s_spg, s_bpg, p_name
                                FROM stats, players, user
                                WHERE p_playerkey = s_playerkey
                                AND p_name = u_player
                                AND u_id = '{userID}' 
                                """.\
                                format(userID = user_id)

            cursor_object.execute(player_sql)
            records = cursor_object.fetchall()

                #displying the user data:
            print("\nPrinting " + records[0][5] + "'s 2020-2021 season stats: \n")
            for s_row in records:
                print("Points Per Game: ", s_row[0])
                print("Rebounds Per Game: ", s_row[1])
                print("Assist Per Game: ", s_row[2])
                print("Steals Per Game: ", s_row[3])
                print("Blocks Per Game: ", s_row[4])

        print("\nWould you like to see the your favorite Divison's teams?")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  

            division_sql = """  SELECT t_name, d_name
                                FROM divisions, teams, user
                                WHERE d_divisionkey = t_divisionkey
                                AND d_name = u_division
                                AND u_id = '{userID}' 
                                """.\
                                format(userID = user_id)

            cursor_object.execute(division_sql)
            records1 = cursor_object.fetchall()

                #displying the user data:
            print("\nHere are the teams in the " + records1[0][1] + " Division: \n")
            for d_row in records1:
                print(d_row[0])

        print("\nWould you like to see the your Team's Starting 5?")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  

            starting5_sql = """  SELECT p_name, t_name
                                FROM players, teams, user
                                WHERE p_current_teamkey = t_teamkey
                                AND u_team = t_name
                                AND u_id = '{userID}' 
                                GROUP BY p_playerkey
                                """.\
                                format(userID = user_id)

            cursor_object.execute(starting5_sql)
            records2 = cursor_object.fetchall()

                #displying the user data:
            print("\nThis is the " + records2[0][1] + " Starting 5: \n")
            for t_row in records2:
                print(t_row[0])

        print("\nWould you like to see the your Team's Seasons Stats?")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  

            teamstats_sql = """ SELECT s_ppg, s_rpg, s_apg, s_spg, s_bpg, t_name
                                FROM teams, user, stats
                                WHERE s_teamkey = t_teamkey
                                AND u_team = t_name
                                AND u_id = '{userID}' 
                                """.\
                                format(userID = user_id)

            cursor_object.execute(teamstats_sql)
            records3 = cursor_object.fetchall()

                #displying the user data:
            print("\nThis is the " + records3[0][5] + " Season Stats: \n")
            for t_row in records3:
                print("Points Per Game: ", t_row[0])
                print("Rebounds Per Game: ", t_row[1])
                print("Assist Per Game: ", t_row[2])
                print("Steals Per Game: ", t_row[3])
                print("Blocks Per Game: ", t_row[4])

        print("\nWould you like to see all the players that play your favorite position?")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  

            playerspositions_sql = """  SELECT p_name, pos_name
                                        FROM players, positions, user
                                        WHERE pos_abbr = u_position
                                        AND p_positionkey LIKE '%{userPos}%'
                                        AND u_id = '{userID}'
                                        GROUP BY p_playerkey;
                                   """.\
                                format(userPos = user_position, userID = user_id)

            cursor_object.execute(playerspositions_sql)
            records4 = cursor_object.fetchall()

                #displying the user data:
            print("\nThis is All the Players who play " + records4[0][1] + " : \n")
            for pos_row in records4:
                print("Player Name: ", pos_row[0])
            
        print("\nWould you like to continue with the program?")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  
            print("\nEntering Next User Phase...")
            extraSql(_connection)
            
    if user_input == "No": 
        user_check = input("Would you like to continue with the program?")
        if user_check == "Yes" or user_check == "yes" or user_check == "y": 
            print("\nEntering Next User Phase...")
            extraSql(_connection)
        else: 
            print("")

    else:
        print("Ending Program")


def extraSql(_connection):
    cursor_object = _connection.cursor()

    user_input = input("\nReady for more? ")
    user_check = False

    if user_input == "Yes" or user_input == "yes" or user_input == "y":
        while user_check == False:
            print("Which player stats would you like to see?")
            user_input = input("Enter name: ")

            playerstats_sql = """  SELECT p_name, s_ppg, s_rpg, s_apg, s_spg, s_bpg
                                        FROM players, stats
                                        WHERE p_playerkey = s_playerkey
                                        AND p_name = '{playerName}' 
                                """.\
                                    format(playerName=user_input)

            cursor_object.execute(playerstats_sql)
            records = cursor_object.fetchall()

            print("\nThis is " + records[0][0] + "'s Season Stats: \n")
            for row in records:
                print("Points Per Game: ", row[1])
                print("Rebounds Per Game: ", row[2])
                print("Assist Per Game: ", row[3])
                print("Steals Per Game: ", row[4])                
                print("Blocks Per Game: ", row[5])

            user_input = input("\nAgain? ")
            if (user_input == "Yes"or user_input == "yes" or user_input == "y"):
                print("")
            else: 
                break

        while user_check == False:
            print("\nWhich team stats would you like to see?")
            user_input = input("Enter name: ")

            teamstats_sql = """  SELECT t_name, s_ppg, s_rpg, s_apg, s_spg, s_bpg
                                        FROM teams, stats
                                        WHERE s_teamkey = t_teamkey
                                        AND t_name = '{teamName}' 
                                """.\
                                    format(teamName=user_input)

            cursor_object.execute(teamstats_sql)
            records1 = cursor_object.fetchall()

            print("\nThis is the " + records1[0][0] + " Season Stats: \n")
            for row in records1:
                print("Points Per Game: ", row[1])
                print("Rebounds Per Game: ", row[2])
                print("Assist Per Game: ", row[3])
                print("Steals Per Game: ", row[4])                
                print("Blocks Per Game: ", row[5])

            print("Now printing Team's MVP")

            teamMVP_sql = """  SELECT p_name, max(s_ppg), s_rpg, s_apg, s_spg, s_bpg
                                FROM stats, teams, players
                                WHERE t_name = '{teamName}'
                                AND p_playerkey = s_playerkey
                                AND t_teamkey = p_current_teamkey;
                                """.\
                                    format(teamName=user_input)

            cursor_object.execute(teamMVP_sql)
            records2 = cursor_object.fetchall()

            print("\nThis is " + records1[0][0] + "'s MVP: \n")
            for row in records2:
                print("MVP: ", row[0])
                print("Points Per Game: ", row[1])
                print("Rebounds Per Game: ", row[2])
                print("Assist Per Game: ", row[3])
                print("Steals Per Game: ", row[4])                
                print("Blocks Per Game: ", row[5])


            user_input = input("\nAgain? ")
            if (user_input == "Yes" or user_input == "yes" or user_input == "y"):
                print("")
            else: 
                break
    
        while user_check == False:
            user_input = input("Enter number of points: ")

            higherppg_sql = """ SELECT p_name, s_ppg
                                FROM players, stats
                                WHERE s_playerkey = p_playerkey
                                GROUP BY p_name
                                HAVING s_ppg > {inputPoints};
                            """.\
                                format(inputPoints=user_input)

            cursor_object.execute(higherppg_sql)
            records3 = cursor_object.fetchall()

            print("\nThese are the players who average more than " + user_input +" points: \n")
            for row in records3:
                print("Player Name: ", row[0], "    |   Points Per Game: ", row[1])
            
            user_input = input("\nAgain? ")
            if (user_input == "Yes" or user_input == "yes" or user_input == "y"):
                print("")
            else: 
                break

        while user_check == False:
            user_input = input("Enter an age: ")

            playerage_sql = """ SELECT p_name, p_age
                                FROM players
                                GROUP BY p_name
                                HAVING p_age < {inputAge}
                            """.\
                                format(inputAge=user_input)

            cursor_object.execute(playerage_sql)
            records4 = cursor_object.fetchall()

            print("\nThese players are younger than " + user_input + " : \n")
            for row in records4:
                print("Player Name: ", row[0], "    |   Age: ", row[1])
            
            user_input = input("\nAgain? ")
            if (user_input == "Yes" or user_input == "yes" or user_input == "y"):
                print("")
            else: 
                break
        
        print("\nWould you like to go back to the Log In Page? ")
        user_check = input("Enter yes or no: ")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  
            print("\nEntering Log In Phase...\n")
            userHandler(_connection)

    if user_input == "No" or user_input == "no" or user_input == "n": 
        user_check = input("Would you like to go back to the Log In Page?")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  
            userHandler(_connection)
        else: 
            print("")

    else:
        print("Ending Program")

def main():
    #we are reading in the sqlite database that we created
    database = r"nba_stats.sqlite"

    print("++++++++++++++++++++++++++++++++++")
    print("NBA 2020-2021 Statisitcs Program")
    print("++++++++++++++++++++++++++++++++++")

    #connects to the database:
    connection = openConnection(database)

    with connection:
        #creating login(admin) and User tables
        createTable(connection)
        #making sure the login works for admin purposes:
        #will check if the user is an admin or not and log them in:
        if not adminHandler(connection):
            #non admin, gets to pick criteria
            userHandler(connection)

        #terminate the program
        else:
            print("Terminating program")


    #runs main
if __name__ == '__main__':
    main()
