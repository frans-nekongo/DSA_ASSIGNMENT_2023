import ballerina/io;

libraryServerClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book add_bookRequest = {Title: "ballerina", Author: "ballerina", Location: "ballerina", ISBN: "ballerina", available_status: true};
    boolean add_bookResponse = check ep->Add_book(add_bookRequest);
    io:println(add_bookResponse);

    string getbookInfoRequest = "ballerina";
    Book getbookInfoResponse = check ep->getbookInfo(getbookInfoRequest);
    io:println(getbookInfoResponse);

    Student createStudentRequest = {student_id: "ballerina", first_name: "ballerina", last_name: "ballerina", role: "ballerina"};
    boolean createStudentResponse = check ep->createStudent(createStudentRequest);
    io:println(createStudentResponse);

    string getStudentInfoRequest = "ballerina";
    Student getStudentInfoResponse = check ep->getStudentInfo(getStudentInfoRequest);
    io:println(getStudentInfoResponse);

    Librarian createLibrarianRequest = {librerian_id: "ballerina", first_name: "ballerina", last_name: "ballerina", role: "ballerina"};
    boolean createLibrarianResponse = check ep->createLibrarian(createLibrarianRequest);
    io:println(createLibrarianResponse);

    string getLibrarianInfoRequest = "ballerina";
    Librarian getLibrarianInfoResponse = check ep->getLibrarianInfo(getLibrarianInfoRequest);
    io:println(getLibrarianInfoResponse);

    borrowBook borrow_BookRequest = {ISBN: "ballerina"};
    Book borrow_BookResponse = check ep->Borrow_Book(borrow_BookRequest);
    io:println(borrow_BookResponse);

    updatebook update_bookRequest = {ISBN: "ballerina"};
    Book update_bookResponse = check ep->Update_book(update_bookRequest);
    io:println(update_bookResponse);

    list_avaiblable_books available_booksRequest = {ISBN: "ballerina"};
    Book available_booksResponse = check ep->Available_books(available_booksRequest);
    io:println(available_booksResponse);

    remove_book remove_bookRequest = {ISBN: "ballerina"};
    Book remove_bookResponse = check ep->Remove_book(remove_bookRequest);
    io:println(remove_bookResponse);
}

