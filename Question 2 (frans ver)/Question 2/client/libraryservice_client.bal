import ballerina/io;


function displayStudentMenuOptions() {
    io:println("Please select an option:");
    io:println("1. get list of books");
    io:println("2. borrow book");
    io:println("3. search for a book");
    io:println("4. return a book");

}
function displayLibrarianMenuOptions() {
    io:println("Please select an option:");
    io:println("1. add book");
    io:println("2. update book");
    io:println("3. remove a book");
    io:println("4. list borrowed books");
}
LibraryServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {

    io:println("Welcome to the Library Service");
    

    while (true) {
        io:println("Are you a student or a librarian?");
        string userType = io:readln();

        match userType {
            "student" => {


            }
            "librarian" => {

            }

    }}
    
    AddBookRequest addBookRequest = {book: {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", available: true}};
    AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
    io:println(addBookResponse);

    CreateUserRequest createUsersRequest = {users: [{user_id: "ballerina", profile: "ballerina", 'type: "ballerina"}]};
    check ep->CreateUsers(createUsersRequest);

    UpdateBookRequest updateBookRequest = {isbn: "ballerina", book: {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", available: true}};
    check ep->UpdateBook(updateBookRequest);

    RemoveBookRequest removeBookRequest = {isbn: "ballerina"};
    RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
    io:println(removeBookResponse);

    ListAvailableBooksRequest listAvailableBooksRequest = {};
    ListAvailableBooksResponse listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);
    io:println(listAvailableBooksResponse);

    LocateBookRequest locateBookRequest = {isbn: "ballerina"};
    LocateBookResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowBookRequest borrowBookRequest = {user_id: "ballerina", isbn: "ballerina"};
    BorrowBookResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
    io:println(borrowBookResponse);
}

