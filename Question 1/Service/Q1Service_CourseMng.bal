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


service /lecturers on new http:Listener(9090) {

   resource function post addLecturer(http:Caller caller, @http:Payload Lecturer lecture) returns error? {
    lecturerTable.add(lecture);
    http:Response response = new;
    response.statusCode = 200;
    response.setPayload("user added successfully");
    check caller->respond(response);
   }

   resource function get allLectures(http:Caller caller)returns error? {
    var lecturers = lecturerTable.toArray();
    http:Response response = new;
    response.setJsonPayload(lecturers);
    checkpanic caller->respond(response);
   }

   resource function get lecturersByStaffNumber(http:Caller caller,int staffNumber)returns error? {
    var lecturer = lecturerTable[staffNumber];
    if (lecturer is Lecturer){
        http:Response response = new;
        response.setJsonPayload(lecturer);
        return  caller->respond(response);
    } else {
        http:Response response = new;
            response.statusCode = 404;
            response.setPayload("No lecturer found with staff number " + staffNumber.toString());
            check caller->respond(response);
    }

   }
   resource function put updateLecturer(http:Caller caller, http:Request req, int staffNumber) returns error? {
        var lecturerJson = req.getJsonPayload();
        if (lecturerJson is json) {
            Lecturer updatedLecturer = <Lecturer>lecturerJson;
            var lecturerToUpdate = lecturerTable[staffNumber];
            if (lecturerToUpdate is Lecturer) {
                lecturerToUpdate.officeN = updatedLecturer.officeN;
                lecturerToUpdate.staffName = updatedLecturer.staffName;
                lecturerToUpdate.title = updatedLecturer.title;
                lecturerToUpdate.course = updatedLecturer.course;
                http:Response response = new;
                response.setPayload("Lecturer updated successfully");
                check caller->respond(response);
            } else {
                http:Response response = new;
                response.statusCode = 404;
                response.setPayload("No lecturer found with staff number " + staffNumber.toString());
                check caller->respond(response);
            }
        } else {
            http:Response response = new;
            response.statusCode = 400;
            response.setPayload("Invalid JSON payload received");
            check caller->respond(response);
        }
    }
   resource function delete delLec(http:Caller caller, string staffNumber) returns error? {}
   resource function get getLecturersByCourse(http:Caller caller, string courseName) returns error? {}


}
