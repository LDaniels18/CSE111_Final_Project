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
       
        sql =   """ CREATE table if not exists user(
                    u_id char(25),
                    u_division char(25) not null,
                    u_team char(25) not null,
                    u_player char(25) not null,
                    u_position char(25) not null)   
                """
       
        _connection.execute(sql)
        _connection.commit()

    except Error as e:
        _connection.rollback()
        print(e)

# To ask for Admin input (need to add pre selected input to work):
def adminHandler(_connection):

    print("Welcome to the login page!")

    user_check = False

    while user_check == False:  # while loop while user_check is False
        print("Are you a User or Admin? \n")
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
                                WHERE a_username = '{userid}' AND a_pass = '{passid}' 
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
                    From user """

        print("Welcome Admins")

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

        print("All Data from User Table Displayed: \n")

        print("Would you like to enter User Selection Mode, Modify the User Table or End the Program?")
        admin_input = input("Please enter User or Modify or End: ")

        if admin_input == "User" or admin_input == "user":
            #go to user input 
            return False
        elif admin_input == "Modify" or admin_input == "modify":
            # ends program 
            print("Taking you to Modification Menu")
            #would place new function call exclusive for Admin Modification here:
            adminModify(_connection, admin_user)

        else:
            #print("Thank you have a nice day")
            return True
            
#allowing the admin to delete and view user data:
def adminModify(_connection, id):
    admin_user = id
    cursor_object = _connection.cursor()

    print("Welcome " + admin_user + " to the Admin")

    #to Display all users and their data:
    print("Displaying all users and associated data")

    sql =   """ SELECT *
                    From user """

    print("Welcome Admins")

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

    print("All Data from User Table Displayed: \n")
    
    #ask if there is a user that the admin would like to delete:
    print("Is there a User you would like to delete?")
    admin_desicion = input("Enter Yes or No:")
    print("\n")
    
    while admin_desicion == "Yes" or admin_desicion == "yes": 
    
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

        print("User table has been printed\n")

        #to ensure the user can delete as many times as they would like:

       
        print("Would you like to delete another user?")
        userToDelete = input("Please enter Yes or No: \n")
        if  userToDelete == "No" or userToDelete == "no":

            #exits the while loop getting out do the delete menu:
            break


# Takes the user input and places selections into the table the first time
def userHandler(_connection):

    cursor_object = _connection.cursor()
    user_check = False

    print("Welcome to the User Selection Page!")
    #variable to account for the user inputs
    user_id = input('Enter your name: ')

    cursor_object.execute("""   SELECT u_id
                                FROM user
                                WHERE u_id = '{userid}'
                          """.\
                                format(userid=user_id,))    
    
    #if the user doesnt have data, we have them input data into the table:
    if not cursor_object.fetchone():  # An empty result evaluates to False.
        print("User doesn't exist")

        print("\n" + user_id + " please enter the following data!")

        user_division = input('Enter your Favorite Division: ')
        user_team = input('Enter your Favorite Team: ')
        user_player = input('Enter your Favorite Player: ')
        user_position = input('Enter your Favorite Position: ')

        print("\nWe will now begin to fill your list with your new picks\n")

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

        print("Your Profile Information: \n ")
        for row in records:
            print("Your Name: ", row[0] )
            print("Division: ", row[1])
            print("Team: ", row[2])
            print("Player: ", row[3])
            print("Position: ", row[4])
            print("")

    #if the user already has data in the table, we move on to modification
    else: 
        
        cursor_object.execute(""" 
                                SELECT *
                                FROM user
                                WHERE u_id = '{userId}'
                                """.\
                                format(userId = user_id))
        records = cursor_object.fetchall()

        print("\nUser Profile Already Exists")
        print("Your Profile Information: \n ")
        for row in records:
            print("Your Name: ", row[0])
            print("Division: ", row[1])
            print("Team: ", row[2])
            print("Player: ", row[3])
            print("Position: ", row[4])
            print("")

    # while user_check is False:
    #     print("Would you like to see the player's stats?")
    #     player_check = input("Enter yes or no: ")
    #     if player_check == "Yes" or player_check == "yes" or player_check == "y":  
    #         print("player is: " + row[3])

    #         player_sql = """    Select s_ppg, s_rpg, s_apg, s_spg, s_bpg
    #                                 FROM stats, players, user
    #                                 WHERE p_playerkey = s_playerkey
    #                                 AND p_name = u_player
    #                                 AND u_id = '{userID}' """.\
    #                                 format(userID = user_id)

    #             #data = ([user_player])
    #         cursor_object.execute(player_sql)
    #         records = cursor_object.fetchall()

    #          #displying the user data:
    #         print("Printing " + row[3] + "'s 2020-2021 season stats: \n")
    #         for s_row in records:
    #             print("Points Per Game: ", s_row[0])
    #             print("Rebounds Per Game: ", s_row[1])
    #             print("Assist Per Game: ", s_row[2])
    #             print("Blocks Per Game: ", s_row[3])
    #             print("Steals Per Game: ", s_row[4])

    #             print("All relevant Player Data has been Displayed:\n")

    #     break

    print("Would you like to Update your profile?")
    user_input = input("Enter Yes or No: ")
    
    #if the user doesnt want to Update their user profile:
    if user_input == "No" or user_input == "no":
        user_input = input("\nWould you like to continue? ")
        if user_input == "Yes" or user_input == "yes" or user_input == "y":
            sqlHandler(_connection, row[0], row[1], row[2], row[3], row[4])
        else: 
            #print("Thank you participating, Have a nice day")
            return True
    #if the user wants to update profile:
    else:
        print("Moving to the [UPDATE USER]...\n")
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

    print("Feel free to change your pics!")
    #user_id = input('Enter your name:\n ')

    print(new_user_id + " Please enter the following data!\n")

    user_decision = input('New Division? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_division = input('Enter your New Favorite Division: ')
    else:
        print("Did not change\n")

    user_decision = input('New Team? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_team = input('Enter your New Favorite Team: ')
    else:
       print("Did not change\n")
    
    user_decision = input('New Player? Yes or No: ')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_player = input('Enter your New Favorite Player: ')
    else:
        print("Did not change\n")

    user_decision = input('New Positon? Yes or No:')
    if user_decision == "Yes" or user_decision == "yes" or user_decision == "y":
        new_user_position = input('Enter your New Favorite Position: ')
    else:
        print("Did not change\n")


    print("\nWe will now begin to update your list with your new picks\n")

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

    print("Printing your new picks now: \n ")
    for row in records:
            print("Your Name: ", row[0] )
            print("Division: ", row[1])
            print("Team: ", row[2])
            print("Player: ", row[3])
            print("Position: ", row[4])
            print("")

    print("New list has been generated\n")

    #re ask for update:
    print("Would you like to update your profile again?")
    user_input = input("Enter Yes or No: ")
    #no more updating
    if user_input == "No":
        user_input = input("Would you like to continue to the program?")
        #They would like to continue the program:
        if user_input == "Yes" or user_input == "yes" or user_input == "y":
            sqlHandler(_connection, row[0], row[1], row[2], row[3], row[4])
        #we end the program:
        else: 
            print("Terminating Program")
    #re-enter update user:
    else:
        print("\nMoving back to User Update Selection Page...")
        updateUser(_connection, row[0], row[1], row[2], row[3], row[4])


    #the logic of where we will access the database and ask the user for various criteria to run sql statements:
def sqlHandler(_connection, current_id, current_division, current_team, current_player, current_position):
    cursor_object = _connection.cursor()

    user_id = current_id
    user_position = current_position
   # user_check = False
    print("Welcome, here you will be able to view data related to your favorite pics!\n")

    user_input = input("Continue with data viewing? Enter Yes or No ")
    user_check = ""
    
    #if the user wants to view more data, we display it with sql
    if user_input == "Yes" or user_input == "yes" or user_input == "y":

        #player stats:
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
                print("Blocks Per Game: ", s_row[3])
                print("Steals Per Game: ", s_row[4])

        #Divisions
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

                #displying the user data:  --- NEED TO FIGURE OUT WHY ERROR OCCURS HERE: IndexError: list index out of range
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
            print("This is the " + records2[0][1] + " Starting 5: \n")
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
                print("Blocks Per Game: ", t_row[3])
                print("Steals Per Game: ", t_row[4])

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
            
            #if we want the user to create another user profile (not necessarily needed):
        # print("\nWould you like to create a new user profile?")
        # user_check = input("Enter yes or no: ")
        # if user_check == "Yes" or user_check == "yes" or user_check == "y":  
        #     print("\nEntering Log In Phase...\n")
        #     userHandler(_connection)

    #the user no longer wants to view data
    if user_input == "No": 
        user_check = input("\nWould you like to continue with the program? \n")
        if user_check == "Yes" or user_check == "yes" or user_check == "y":  
            extraSql(_connection)
        #no
        else: 
            print("Terminating Program...\n")

    else:
        print("Terminating Program...")


#A function to perform extra Sql queries tuned for user input:
def extraSql(_connection):
    cursor_object = _connection.cursor()
    print("Welcome to the User Input Selection Page")

    user_input = input("\nAre you ready to continue, enter Yes or No: \n")
    user_check = False

    #as long as the user is ready to continue
    if user_input == "Yes" or user_input == "yes" or user_input == "y":

        #Accounts for player Related Queries, we dont want to stop asking:
        while user_check == False:
            print("\nWhich players stats would you like to see?")
            user_input = input("Enter player name: ")

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

            user_input = input("\nWould you like to view another players stats? Enter Yes or No: ")
            #goes back to the beginning of the loop:
            if (user_input == "Yes"):
                print("")
            else: 
                print("Moving to Team related inputs...")
                break
        
        #Accounts for Team Related Queries, we want to ask multiple times:
        while user_check == False:
            print("\nWhich team stats would you like to see?")
            user_input = input("Enter team name: ")

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

            print("Now printing teams MVP")

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


            user_input = input("\nWould you like to view another teams stats? Enter Yes or No: ")
            if (user_input == "Yes"):
                print("")
            else: 
                print("Moving to point related inputs...\n")
                break
        
        #For Points related queries:
        while user_check == False:
            user_input = input("Enter number of points scored in a game: ")

            higherppg_sql = """ SELECT p_name
                                FROM players, stats
                                WHERE s_playerkey = p_playerkey
                                GROUP BY p_name
                                HAVING s_ppg > {inputPoints};
                            """.\
                                format(inputPoints=user_input)

            cursor_object.execute(higherppg_sql)
            records3 = cursor_object.fetchall()

            print("\nThese are the players who avg more than " +  user_input + " points in a game: \n")
            for row in records3:
                print("Player Name: ", row[0])
            
            user_input = input("\n Would you like to view another set of players? Enter Yes or No: ")
            if (user_input == "Yes"):
                print("")
            else: 
                print("Terminating Program....\n")
                break



 #where the program begins:
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

            # if userHandler(connection):
            #     print("Terminating program")


        #terminate the program
        else:

            print("Program Terminated")
            #to close the connection:
            #exit()

            
        #closeConnection(connection, database) 

        print("Program Terminated")

    #runs main
if __name__ == '__main__':
    main()
