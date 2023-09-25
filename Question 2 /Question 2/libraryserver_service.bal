import ballerina/grpc;
import ballerinax/mongodb;





type StudentBookRecord record{|
    Student studentName;
    Book bookOwned;
|};


type LibrarianBookStatus record{|
    Librarian librarianName;
    Book bookAddedOr;
    string statusDeleted= "";
    string statusAdded= "";
|};



map<LibrarianBookStatus>  librarianMap = {};
map<StudentBookRecord> studentBook = {};


mongodb:ConnectionConfig mongoConfig ={
    connection: {
      url: "mongodb+srv://dylanDA:Angry_monkey16@mydsaculster.nuxlxte.mongodb.net/"
    },
    databaseName: "LibrarySystemDsa"

};


mongodb:Client mongoClient= check new(mongoConfig);


listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: PROTOBU_DESC}
service "libraryServer" on ep {

    remote function Add_book(Book value) returns string|error {

        map<json> book = {
            "title": value.Title,
            "author_1":  value.Author_1,
            "author_2": value.Author_2,
            "location": value.Location,
            "ISBN": value.ISBN,
            "available_status": value.available_status
        };

        // Insert the book into the "books" collection
        var result = mongoClient->insert(book, "books");

        // Check if the insert operation was successful
        if (result is mongodb:DatabaseError) {
            return result;
        } else {
            // Return the ISBN of the added book
            return value.ISBN;
        }
    }

    
    remote function getbookInfo(string value) returns Book|error {

        // Define the query
        map<json> query = {"ISBN": value};

            // Execute the find operation
        var result = mongoClient->find("books", Books,  query);

            // Check if the find operation was successful
        if (result is mongodb:DatabaseError) {
            return result;
        } else {
                // Convert the result to a Book record
            json[] jsonResult = check result.toArray();
            if (jsonResult.length() > 0) {
                json bookJson = jsonResult[0];
                    Book book = {
                        Title: check bookJson.title.toString(),
                        Author_1: check bookJson.author_1.toString(),
                        Author_2: check bookJson.author_2.toString(),
                        Location: check bookJson.location.toString(),
                        ISBN: check bookJson.ISBN.toString(),
                        available_status: check bookJson.available_status.toBoolean()
                    };
                return book;
            } else {
                return error("Book not found");
            }
        }
        
    }
    remote function getStudentInfo(string value) returns Student|error {


    
    }
    remote function getLibrarianInfo(string value) returns Librarian|error {
    }
    remote function Borrow_Book(UserBookPair value) returns Book|error {
    }
    remote function Update_book(updatebook value) returns Book|error {
    }
    remote function Available_books(Book value) returns list_avaiblable_books|error {
    }
    remote function Remove_book(remove_book value) returns list_avaiblable_books|error {
    }
    remote function Locate_book(string value) returns string|error {
    }
    remote function CreateUsers(stream<CreateUserRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

