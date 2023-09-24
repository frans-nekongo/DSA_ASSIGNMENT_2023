import ballerina/io;

LibraryServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
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

    ReturnBookRequest returnBookRequest = {user_id: "ballerina", isbn: "ballerina"};
    ReturnBookResponse returnBookResponse = check ep->ReturnBook(returnBookRequest);
    io:println(returnBookResponse);

    ListBorrowedBooksByUserRequest listBorrowedBooksByUserRequest = {user_id: "ballerina"};
    ListBorrowedBooksByUserResponse listBorrowedBooksByUserResponse = check ep->ListBorrowedBooksByUser(listBorrowedBooksByUserRequest);
    io:println(listBorrowedBooksByUserResponse);

    ListAllBorrowedBooksRequest listAllBorrowedBooksRequest = {};
    ListAllBorrowedBooksResponse listAllBorrowedBooksResponse = check ep->ListAllBorrowedBooks(listAllBorrowedBooksRequest);
    io:println(listAllBorrowedBooksResponse);
}

