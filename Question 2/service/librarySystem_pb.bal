import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.wrappers;

public const string LIBRARYSYSTEM_DESC = "0A136C69627261727953797374656D2E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F228F010A04426F6F6B12140A055469746C6518012001280952055469746C6512160A06417574686F721802200128095206417574686F72121A0A084C6F636174696F6E18032001280952084C6F636174696F6E12120A044953424E18042001280952044953424E12290A10617661696C61626C655F737461747573180520012808520F617661696C61626C6553746174757322780A0753747564656E74121D0A0A73747564656E745F6964180120012809520973747564656E744964121D0A0A66697273745F6E616D65180220012809520966697273744E616D65121B0A096C6173745F6E616D6518032001280952086C6173744E616D6512120A04726F6C651804200128095204726F6C65227E0A094C696272617269616E12210A0C6C696272657269616E5F6964180120012809520B6C696272657269616E4964121D0A0A66697273745F6E616D65180220012809520966697273744E616D65121B0A096C6173745F6E616D6518032001280952086C6173744E616D6512120A04726F6C651804200128095204726F6C6522680A0C55736572426F6F6B5061697212170A07757365725F69641801200128095206757365724964121B0A09626F6F6B5F4953424E1802200128095208626F6F6B4953424E12220A0753747564656E7418032001280B32082E53747564656E74520753747564656E7422200A0A626F72726F77426F6F6B12120A044953424E18012001280952044953424E22220A0A6C6F63617465626F6F6B12140A05706C6163651801200128095205706C61636522200A0A757064617465626F6F6B12120A044953424E18012001280952044953424E222B0A156C6973745F61766169626C61626C655F626F6F6B7312120A044953424E18012001280952044953424E22210A0B72656D6F76655F626F6F6B12120A044953424E18012001280952044953424E3280040A0D6C696272617279536572766572122D0A084164645F626F6F6B12052E426F6F6B1A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C756512320A0B676574626F6F6B496E666F121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A052E426F6F6B12350A0D63726561746553747564656E7412082E53747564656E741A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C756512380A0E67657453747564656E74496E666F121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A082E53747564656E7412390A0F6372656174654C696272617269616E120A2E4C696272617269616E1A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565123C0A106765744C696272617269616E496E666F121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0A2E4C696272617269616E12230A0B426F72726F775F426F6F6B120B2E626F72726F77426F6F6B1A052E426F6F6B220012230A0B5570646174655F626F6F6B120B2E757064617465626F6F6B1A052E426F6F6B220012320A0F417661696C61626C655F626F6F6B7312162E6C6973745F61766169626C61626C655F626F6F6B731A052E426F6F6B220012240A0B52656D6F76655F626F6F6B120C2E72656D6F76655F626F6F6B1A052E426F6F6B2200620670726F746F33";

public isolated client class libraryServerClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARYSYSTEM_DESC);
    }

    isolated remote function Add_book(Book|ContextBook req) returns boolean|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Add_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <boolean>result;
    }

    isolated remote function Add_bookContext(Book|ContextBook req) returns wrappers:ContextBoolean|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Add_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <boolean>result, headers: respHeaders};
    }

    isolated remote function getbookInfo(string|wrappers:ContextString req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/getbookInfo", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function getbookInfoContext(string|wrappers:ContextString req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/getbookInfo", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function createStudent(Student|ContextStudent req) returns boolean|grpc:Error {
        map<string|string[]> headers = {};
        Student message;
        if req is ContextStudent {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/createStudent", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <boolean>result;
    }

    isolated remote function createStudentContext(Student|ContextStudent req) returns wrappers:ContextBoolean|grpc:Error {
        map<string|string[]> headers = {};
        Student message;
        if req is ContextStudent {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/createStudent", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <boolean>result, headers: respHeaders};
    }

    isolated remote function getStudentInfo(string|wrappers:ContextString req) returns Student|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/getStudentInfo", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Student>result;
    }

    isolated remote function getStudentInfoContext(string|wrappers:ContextString req) returns ContextStudent|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/getStudentInfo", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Student>result, headers: respHeaders};
    }

    isolated remote function createLibrarian(Librarian|ContextLibrarian req) returns boolean|grpc:Error {
        map<string|string[]> headers = {};
        Librarian message;
        if req is ContextLibrarian {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/createLibrarian", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <boolean>result;
    }

    isolated remote function createLibrarianContext(Librarian|ContextLibrarian req) returns wrappers:ContextBoolean|grpc:Error {
        map<string|string[]> headers = {};
        Librarian message;
        if req is ContextLibrarian {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/createLibrarian", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <boolean>result, headers: respHeaders};
    }

    isolated remote function getLibrarianInfo(string|wrappers:ContextString req) returns Librarian|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/getLibrarianInfo", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Librarian>result;
    }

    isolated remote function getLibrarianInfoContext(string|wrappers:ContextString req) returns ContextLibrarian|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/getLibrarianInfo", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Librarian>result, headers: respHeaders};
    }

    isolated remote function Borrow_Book(borrowBook|ContextBorrowBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        borrowBook message;
        if req is ContextBorrowBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Borrow_Book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function Borrow_BookContext(borrowBook|ContextBorrowBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        borrowBook message;
        if req is ContextBorrowBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Borrow_Book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function Update_book(updatebook|ContextUpdatebook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        updatebook message;
        if req is ContextUpdatebook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Update_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function Update_bookContext(updatebook|ContextUpdatebook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        updatebook message;
        if req is ContextUpdatebook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Update_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function Available_books(list_avaiblable_books|ContextList_avaiblable_books req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        list_avaiblable_books message;
        if req is ContextList_avaiblable_books {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Available_books", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function Available_booksContext(list_avaiblable_books|ContextList_avaiblable_books req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        list_avaiblable_books message;
        if req is ContextList_avaiblable_books {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Available_books", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function Remove_book(remove_book|ContextRemove_book req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        remove_book message;
        if req is ContextRemove_book {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Remove_book", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function Remove_bookContext(remove_book|ContextRemove_book req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        remove_book message;
        if req is ContextRemove_book {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("libraryServer/Remove_book", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }
}

public client class LibraryServerLibrarianCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendLibrarian(Librarian response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextLibrarian(ContextLibrarian response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServerStudentCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendStudent(Student response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextStudent(ContextStudent response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServerBooleanCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBoolean(boolean response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBoolean(wrappers:ContextBoolean response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServerBookCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBook(Book response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBook(ContextBook response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUpdatebook record {|
    updatebook content;
    map<string|string[]> headers;
|};

public type ContextBorrowBook record {|
    borrowBook content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextLibrarian record {|
    Librarian content;
    map<string|string[]> headers;
|};

public type ContextStudent record {|
    Student content;
    map<string|string[]> headers;
|};

public type ContextRemove_book record {|
    remove_book content;
    map<string|string[]> headers;
|};

public type ContextList_avaiblable_books record {|
    list_avaiblable_books content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type updatebook record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type borrowBook record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type locatebook record {|
    string place = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type Book record {|
    string Title = "";
    string Author = "";
    string Location = "";
    string ISBN = "";
    boolean available_status = false;
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type Librarian record {|
    string librerian_id = "";
    string first_name = "";
    string last_name = "";
    string role = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type Student record {|
    string student_id = "";
    string first_name = "";
    string last_name = "";
    string role = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type remove_book record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type UserBookPair record {|
    string user_id = "";
    string book_ISBN = "";
    Student Student = {};
|};

@protobuf:Descriptor {value: LIBRARYSYSTEM_DESC}
public type list_avaiblable_books record {|
    string ISBN = "";
|};

