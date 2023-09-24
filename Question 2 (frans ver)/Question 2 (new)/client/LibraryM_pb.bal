import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string LIBRARYM_DESC = "0A0E4C6962726172794D2E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22A0010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A046973626E18052001280952046973626E121C0A09617661696C61626C651806200128085209617661696C61626C65222B0A0E416464426F6F6B5265717565737412190A04626F6F6B18012001280B32052E426F6F6B5204626F6F6B22250A0F416464426F6F6B526573706F6E736512120A046973626E18012001280952046973626E22300A114372656174655573657252657175657374121B0A05757365727318012003280B32052E5573657252057573657273224D0A045573657212170A07757365725F6964180120012809520675736572496412180A0770726F66696C65180220012809520770726F66696C6512120A047479706518032001280952047479706522420A11557064617465426F6F6B5265717565737412120A046973626E18012001280952046973626E12190A04626F6F6B18022001280B32052E426F6F6B5204626F6F6B22270A1152656D6F7665426F6F6B5265717565737412120A046973626E18012001280952046973626E22310A1252656D6F7665426F6F6B526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B73221B0A194C697374417661696C61626C65426F6F6B735265717565737422390A1A4C697374417661696C61626C65426F6F6B73526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322270A114C6F63617465426F6F6B5265717565737412120A046973626E18012001280952046973626E224E0A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E121C0A09617661696C61626C651802200128085209617661696C61626C6522400A11426F72726F77426F6F6B5265717565737412170A07757365725F6964180120012809520675736572496412120A046973626E18022001280952046973626E22140A12426F72726F77426F6F6B526573706F6E736522400A1152657475726E426F6F6B5265717565737412170A07757365725F6964180120012809520675736572496412120A046973626E18022001280952046973626E22280A1252657475726E426F6F6B526573706F6E736512120A046973626E18012001280952046973626E22390A1E4C697374426F72726F776564426F6F6B734279557365725265717565737412170A07757365725F69641801200128095206757365724964223E0A1F4C697374426F72726F776564426F6F6B73427955736572526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B73221D0A1B4C697374416C6C426F72726F776564426F6F6B7352657175657374223B0A1C4C697374416C6C426F72726F776564426F6F6B73526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B733291050A0E4C69627261727953657276696365122C0A07416464426F6F6B120F2E416464426F6F6B526571756573741A102E416464426F6F6B526573706F6E736512390A0B437265617465557365727312122E43726561746555736572526571756573741A162E676F6F676C652E70726F746F6275662E456D70747912380A0A557064617465426F6F6B12122E557064617465426F6F6B526571756573741A162E676F6F676C652E70726F746F6275662E456D70747912350A0A52656D6F7665426F6F6B12122E52656D6F7665426F6F6B526571756573741A132E52656D6F7665426F6F6B526573706F6E7365124D0A124C697374417661696C61626C65426F6F6B73121A2E4C697374417661696C61626C65426F6F6B73526571756573741A1B2E4C697374417661696C61626C65426F6F6B73526573706F6E736512350A0A4C6F63617465426F6F6B12122E4C6F63617465426F6F6B526571756573741A132E4C6F63617465426F6F6B526573706F6E736512350A0A426F72726F77426F6F6B12122E426F72726F77426F6F6B526571756573741A132E426F72726F77426F6F6B526573706F6E736512350A0A52657475726E426F6F6B12122E52657475726E426F6F6B526571756573741A132E52657475726E426F6F6B526573706F6E7365125C0A174C697374426F72726F776564426F6F6B73427955736572121F2E4C697374426F72726F776564426F6F6B73427955736572526571756573741A202E4C697374426F72726F776564426F6F6B73427955736572526573706F6E736512530A144C697374416C6C426F72726F776564426F6F6B73121C2E4C697374416C6C426F72726F776564426F6F6B73526571756573741A1D2E4C697374416C6C426F72726F776564426F6F6B73526573706F6E7365620670726F746F33";

public isolated client class LibraryServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARYM_DESC);
    }

    isolated remote function AddBook(AddBookRequest|ContextAddBookRequest req) returns AddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddBookResponse>result;
    }

    isolated remote function AddBookContext(AddBookRequest|ContextAddBookRequest req) returns ContextAddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddBookResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers(CreateUserRequest|ContextCreateUserRequest req) returns grpc:Error? {
        map<string|string[]> headers = {};
        CreateUserRequest message;
        if req is ContextCreateUserRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("LibraryService/CreateUsers", message, headers);
    }

    isolated remote function CreateUsersContext(CreateUserRequest|ContextCreateUserRequest req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        CreateUserRequest message;
        if req is ContextCreateUserRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/CreateUsers", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function UpdateBook(UpdateBookRequest|ContextUpdateBookRequest req) returns grpc:Error? {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("LibraryService/UpdateBook", message, headers);
    }

    isolated remote function UpdateBookContext(UpdateBookRequest|ContextUpdateBookRequest req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function RemoveBook(RemoveBookRequest|ContextRemoveBookRequest req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function RemoveBookContext(RemoveBookRequest|ContextRemoveBookRequest req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableBooks(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableBooksResponse>result;
    }

    isolated remote function ListAvailableBooksContext(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ContextListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableBooksResponse>result, headers: respHeaders};
    }

    isolated remote function LocateBook(LocateBookRequest|ContextLocateBookRequest req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function LocateBookContext(LocateBookRequest|ContextLocateBookRequest req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function BorrowBook(BorrowBookRequest|ContextBorrowBookRequest req) returns BorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowBookResponse>result;
    }

    isolated remote function BorrowBookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns ContextBorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowBookResponse>result, headers: respHeaders};
    }

    isolated remote function ReturnBook(ReturnBookRequest|ContextReturnBookRequest req) returns ReturnBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        ReturnBookRequest message;
        if req is ContextReturnBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ReturnBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ReturnBookResponse>result;
    }

    isolated remote function ReturnBookContext(ReturnBookRequest|ContextReturnBookRequest req) returns ContextReturnBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        ReturnBookRequest message;
        if req is ContextReturnBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ReturnBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ReturnBookResponse>result, headers: respHeaders};
    }

    isolated remote function ListBorrowedBooksByUser(ListBorrowedBooksByUserRequest|ContextListBorrowedBooksByUserRequest req) returns ListBorrowedBooksByUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListBorrowedBooksByUserRequest message;
        if req is ContextListBorrowedBooksByUserRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListBorrowedBooksByUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListBorrowedBooksByUserResponse>result;
    }

    isolated remote function ListBorrowedBooksByUserContext(ListBorrowedBooksByUserRequest|ContextListBorrowedBooksByUserRequest req) returns ContextListBorrowedBooksByUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListBorrowedBooksByUserRequest message;
        if req is ContextListBorrowedBooksByUserRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListBorrowedBooksByUser", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListBorrowedBooksByUserResponse>result, headers: respHeaders};
    }

    isolated remote function ListAllBorrowedBooks(ListAllBorrowedBooksRequest|ContextListAllBorrowedBooksRequest req) returns ListAllBorrowedBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAllBorrowedBooksRequest message;
        if req is ContextListAllBorrowedBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListAllBorrowedBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAllBorrowedBooksResponse>result;
    }

    isolated remote function ListAllBorrowedBooksContext(ListAllBorrowedBooksRequest|ContextListAllBorrowedBooksRequest req) returns ContextListAllBorrowedBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAllBorrowedBooksRequest message;
        if req is ContextListAllBorrowedBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryService/ListAllBorrowedBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAllBorrowedBooksResponse>result, headers: respHeaders};
    }
}

public type ContextListAllBorrowedBooksRequest record {|
    ListAllBorrowedBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookRequest record {|
    RemoveBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookResponse record {|
    BorrowBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksRequest record {|
    ListAvailableBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookRequest record {|
    AddBookRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookResponse record {|
    AddBookResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListBorrowedBooksByUserResponse record {|
    ListBorrowedBooksByUserResponse content;
    map<string|string[]> headers;
|};

public type ContextListBorrowedBooksByUserRequest record {|
    ListBorrowedBooksByUserRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookRequest record {|
    LocateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextReturnBookResponse record {|
    ReturnBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksResponse record {|
    ListAvailableBooksResponse content;
    map<string|string[]> headers;
|};

public type ContextListAllBorrowedBooksResponse record {|
    ListAllBorrowedBooksResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookRequest record {|
    UpdateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextReturnBookRequest record {|
    ReturnBookRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateUserRequest record {|
    CreateUserRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ListAllBorrowedBooksRequest record {|
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type User record {|
    string user_id = "";
    string profile = "";
    string 'type = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type RemoveBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type BorrowBookResponse record {|
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ListAvailableBooksRequest record {|
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type AddBookRequest record {|
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type AddBookResponse record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type RemoveBookResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ListBorrowedBooksByUserResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ListBorrowedBooksByUserRequest record {|
    string user_id = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type LocateBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type LocateBookResponse record {|
    string location = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ReturnBookResponse record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ListAvailableBooksResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ListAllBorrowedBooksResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string isbn = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type UpdateBookRequest record {|
    string isbn = "";
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type BorrowBookRequest record {|
    string user_id = "";
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type ReturnBookRequest record {|
    string user_id = "";
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARYM_DESC}
public type CreateUserRequest record {|
    User[] users = [];
|};

