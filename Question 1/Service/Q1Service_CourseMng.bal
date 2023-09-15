import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.

# storage of variables


type Lecturer record {|
    readonly int staffNumber;
    *officeN;
    string staffName;
    string title;
    *course;
    
|};

type officeN record {|
        int officeNumber;

|};

type course record {|
string courseName;
    string coursseCode;
    string nQFlevel;
    
|};

table<Lecturer> key(staffNumber) lecturerTable = table [
    {officeNumber: 0, staffNumber: 1, staffName: "John", title: "Lecturer",courseName: "Data Structures and algorithms", coursseCode: "DSA611",nQFlevel: "7"}
    ];


service / on new http:Listener(9090) {

   resource function post addLecturer(http:Caller caller, @http:Payload Lecturer lecture) returns error? {
    lecturerTable.add(lecture);
    http:Response response = new;
    response.statusCode = 200;
    response.setPayload("user added successfully");
    check caller->respond(response);
   }

   resource function get allLectures()returns Lecturer[] {
    return lecturerTable.toArray();
   }

   resource function get allLectures/[string staffNumber]() {
    
   }
   resource function put updateLec() {
    
   }

}
