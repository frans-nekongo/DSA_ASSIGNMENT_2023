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
    //crate login or create new uaser function here remeber


        while (true) {
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

                        //dont forget to change this code to return book and not update
                          UpdateBookRequest updateBookRequest = {isbn: "ballerina", book: {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", available: true}};
                          check ep->UpdateBook(updateBookRequest);    
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
                         AddBookRequest addBookRequest = {book: {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", available: true}};
                         AddBookResponse addBookResponse = check ep->AddBook(addBookRequest);
                         io:println(addBookResponse);
                    }
                    "2"=>{
                        //"2. update book"
                        UpdateBookRequest updateBookRequest = {isbn: "ballerina", book: {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", available: true}};
                         check ep->UpdateBook(updateBookRequest);

                    }
                    "3"=>{
                        //"3. remove a book"
                        string bISBN =io:readln("Enter Book isbn");

                         RemoveBookRequest removeBookRequest = {isbn: bISBN};
                         RemoveBookResponse removeBookResponse = check ep->RemoveBook(removeBookRequest);
                         io:println(removeBookResponse);

                    }
                    "4"=>{
                        //"4. list borrowed books"

                        //make for listing borrowed books function
                    }
                }
            }

    }
    
    //add this to appropriate fields 
   
///this for making a user 
    CreateUserRequest createUsersRequest = {users: [{user_id: "ballerina", profile: "ballerina", 'type: "ballerina"}]};
    check ep->CreateUsers(createUsersRequest);

    
   
   
    
    
}
}
}
