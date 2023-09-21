import ballerina/grpc;

type BookRecord record {|
    string title;
    string author_1;
    string author_2;
    string location;
    readonly string isbn;
    boolean available;
|};

//name == profile
type UserRecord record {|
    readonly string userid;
    string profile;
    string typeUser;
|};

table< BookRecord> key(isbn) books=table[
    {title:"The Cat in the Hat" ,author_1: "Dr. Seuss",author_2: " ",location:"2nd level,L3" ,isbn:"9780008202347" ,available:true},
    {title: "The 48 Laws of Power",author_1:"Robert Greene" ,author_2: "Joost Elffers",location: "2nd level,L3",isbn: "9781101042458",available: false }
];

table<UserRecord> key(userid) users=table[
    {userid:"1",profile:"John",typeUser:"Librarian"},
    {userid:"2",profile:"Ruusa",typeUser:"student"},
    {userid:"3",profile:"Nashandi",typeUser:"Librarian"}
];

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARYM_DESC}

service "LibraryService" on ep {


    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
        // Retrieve the book details from the request
        BookRecord book = {
            title: value.book.title,
            author_1: value.book.author_1,
            author_2: value.book.author_2,
            location: value.book.location,
            isbn: value.book.isbn,
            available: value.book.available
        };

        // Add the book to the books table
        //books[book.isbn] = book;
        books.add(book);


        // Prepare the response
        AddBookResponse response = { isbn: book.isbn };

        // Return the response
        return response;
    }
    remote function CreateUsers(CreateUserRequest value) returns error? {
    // Retrieve the user details from the request 
    UserRecord user = { userid: value.users[0].user_id,
                         profile: value.users[0].profile,
                          typeUser: value.users[0].'type };
     // Add the user to the users table 
     users.add(user);
      // Return success 
      return ();
    }
    remote function UpdateBook(UpdateBookRequest value) returns error? {
    // Retrieve the book details from the request 
    BookRecord book = { title: value.book.title,
                         author_1: value.book.author_1,
                          author_2: value.book.author_2, 
                          location: value.book.location, 
                          isbn: value.book.isbn,
                           available: value.book.available }; 
    // Update the book in the books table 
    books.add(book); 
    // Return success 
    return ();
    }
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    // Retrieve the book details from the request 
    string isbn = value.isbn; 
    // Remove the book from the books table 
    _= books.remove(isbn); 
    // Prepare the response 
    RemoveBookResponse response = { books: []}; 
    // Return the response 
    return response;
    }
    remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
    // Filter the books that are available 
    var  availableBooks = books.filter(book => book.available==true); 
    // Prepare the response 
    ListAvailableBooksResponse response = { books: availableBooks.toArray() }; 
    // Return the response 
    return response;
    }
    remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
    // Retrieve the book details from the request 
    string isbn = value.isbn; 
    // Check if the book exists in the books table 
    if (books.hasKey(isbn)) { 
        // Retrieve the book location 
        string? location = books[isbn]?.location; 

        //for status available
        boolean val;
        string valble= books[isbn]?.available.toString();
        if valble == "true" {
            val = true;
        } else {
            val = false;
        }
        // Prepare the response 
        LocateBookResponse response = { location: location.toString(),available: val }; 
        // Return the response 
        return response; } else { 
            // Book not found 
            return error("Book not found"); }
    }
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
     // Retrieve the book details from the request
      string isbn = value.isbn;
       // Check if the book exists in the books table
        if (books.hasKey(isbn)) { 
            // Check if the book is available
             if (books[isbn]?.available==true) {

                // Update the availability status of the book 
                books[isbn].available = false; 
                 // Prepare the response 
                 BorrowBookResponse response = { status: true }; 
                 // Return the response 
                 return response; } else { 
                    // Book is not available
                     return error("Book is not available"); } }
                      else { // Book not found 
                      return error("Book not found"); }
    }
}

