import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARYSYSTEM_DESC}
service "libraryServer" on ep {

    remote function Add_book(Book value) returns boolean|error {
    }
    remote function getbookInfo(string value) returns Book|error {
    }
    remote function createStudent(Student value) returns boolean|error {
    }
    remote function getStudentInfo(string value) returns Student|error {
    }
    remote function createLibrarian(Librarian value) returns boolean|error {
    }
    remote function getLibrarianInfo(string value) returns Librarian|error {
    }
    remote function Borrow_Book(borrowBook value) returns Book|error {
    }
    remote function Update_book(updatebook value) returns Book|error {
    }
    remote function Available_books(list_avaiblable_books value) returns Book|error {
    }
    remote function Remove_book(remove_book value) returns Book|error {
    }
}

