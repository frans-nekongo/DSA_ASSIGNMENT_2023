import ballerina/io;

public function main() {
    io:println("Welcome to the API client!");
    io:println("Please select an option:");
    io:println("1. Add user");
    io:println("2. Get all users");
    io:println("3. Get user by ID");
    io:println("4. Update user");
    io:println("5. Delete user");

    string option = io:readln("Enter your option: ");

    match option {
        "1" => {addUser();}
        "2" => {getAllUsers();}
        "3" => {getUserById();}
        "4" => {updateUser();}
        "5" => {deleteUser();}
        _ => {io:println("Invalid option");}
    }
}

function addUser() {
    // Code for adding a user
    
}

function getAllUsers() {
    // Code for getting all users
}

function getUserById() {
    // Code for getting a user by ID
}

function updateUser() {
    // Code for updating a user
}

function deleteUser() {
    // Code for deleting a user
}
