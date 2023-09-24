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
    io:println("4. list All borrowed books");
    io:println("5. list borrowed books by user");
}

LibraryServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {

        io:println("Welcome to the Library Service");
    

   while (true) {
    //crate login or create new uaser function here remeber
    string lType =io:readln("1. to login , 2. to create new user");


while (true){
        if (lType == "1") {
        io:println("Are you a student or a librarian?");
        string userType = io:readln();

        match userType {
            "student" => {
                displayStudentMenuOptions();
                //add the reqs and all
                string stdntA = io:readln();

                match stdntA {
                    "1"=>{
                        //"1. get list of books"
                         ListAvailableBooksRequest listAvailableBooksRequest = {};
                         ListAvailableBooksResponse listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);
                         io:println(listAvailableBooksResponse);

                    }
                    "2"=>{
                        //"2. borrow book"

                        string uSRID =io:readln("Enter user id");
                        string bISBN =io:readln("Enter Book isbn");

                         BorrowBookRequest borrowBookRequest = {user_id: uSRID, isbn: bISBN};
                         BorrowBookResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
                         io:println(borrowBookResponse);
                    }
                    "3"=>{
                        //"3. search for a book"
                        //add inputs  
                        string bISBN =io:readln("Enter Book isbn");

                        LocateBookRequest locateBookRequest = {isbn: bISBN};
                        LocateBookResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
                        io:println(locateBookResponse);

                    }
                    "4"=>{
                        //"4. return a book"
                        string uSRID =io:readln("Enter user id");
                        string bISBN =io:readln("Enter Book isbn");

                        ReturnBookRequest returnBookRequest = {user_id: uSRID, isbn: bISBN};
                        ReturnBookResponse returnBookResponse = check ep->ReturnBook(returnBookRequest);
                        io:println(returnBookResponse);    
                    }
                }

            }
            "librarian" => {
                displayLibrarianMenuOptions();
                //add the reqs and all
                string libA = io:readln();

                match libA {
                    "1"=>{
                        //"1. add book"
                        string bTitle =io:readln("Enter Book title");
                        string bAuthor1 =io:readln("Enter Book author_1");
                        string bAuthor2 =io:readln("Enter Book author_2");
                        string bLocation =io:readln("Enter Book location");
                        string bISBN =io:readln("Enter Book isbn");

                        AddBookRequest addBookRequest = {book: {title: bTitle, author_1: bAuthor1, author_2: bAuthor2, location: bLocation, isbn: bISBN, available: true}};
                        AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
                        io:println(addBookResponse);
                    }
                    "2"=>{
                        //"2. update book"
                        
                        string bISBN =io:readln("Enter Book isbn of book to be updated");

                        string bTitle =io:readln("Enter Book title");
                        string bAuthor1 =io:readln("Enter Book author_1");
                        string bAuthor2 =io:readln("Enter Book author_2");
                        string bLocation =io:readln("Enter Book location");
                        string bISBN2 =io:readln("Enter Book isbn");

                        if (bISBN2==""){
                            bISBN2 = bISBN;
                        }

                        //add error for if bAuthor2 is empty then add " "

                        UpdateBookRequest updateBookRequest = {isbn: bISBN, book: {title: bTitle, author_1: bAuthor1, author_2: bAuthor2, location: bLocation, isbn: bISBN2, available: true}};
                        UpdateBookResponse updateBookResponse = check ep->UpdateBook(updateBookRequest);
                         io:println(updateBookResponse);
                    }
                    "3"=>{
                        //"3. remove a book"
                        string bISBN =io:readln("Enter Book isbn");

                        RemoveBookRequest removeBookRequest = {isbn: bISBN};
                        RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
                        io:println(removeBookResponse);

                    }
                    "4"=>{
                        //"4. list All borrowed books"

                        ListAllBorrowedBooksRequest listAllBorrowedBooksRequest = {};
                        ListAllBorrowedBooksResponse listAllBorrowedBooksResponse = check ep->ListAllBorrowedBooks(listAllBorrowedBooksRequest);
                        io:println(listAllBorrowedBooksResponse);
                    }
                    "5"=>{
                        //"5. list borrowed books by user"
                        string uSRID =io:readln("Enter user id");

                        ListBorrowedBooksByUserRequest listBorrowedBooksByUserRequest = {user_id: uSRID};
                        ListBorrowedBooksByUserResponse listBorrowedBooksByUserResponse = check ep->ListBorrowedBooksByUser(listBorrowedBooksByUserRequest);
                        io:println(listBorrowedBooksByUserResponse);
                    }
                }
            }

    }   
}else if (lType =="2") {
    string uSRID =io:readln("Enter user id");
    string uPrfl =io:readln("Enter user profile");
    string uType =io:readln("Enter user type");
    
    CreateUserRequest createUsersRequest = {users: [{user_id: uSRID, profile: uPrfl, 'type: uType}]};
    CreateUserResponse createUsersResponse = check ep->CreateUsers(createUsersRequest);
    io:println(createUsersResponse);
            }
        }
    }    
}

