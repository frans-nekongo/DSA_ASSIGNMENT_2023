import ballerina/http;
import ballerina/io;

type Lecturer record {|
    readonly int staffNumber;
    string staffName;
    string courseCode?;
    int officeNumber?;
|};

table<Lecturer> key(staffNumber) lecturerTable = table [
    {staffNumber: 22101, staffName: "John", courseCode: "DSA612S", officeNumber: 206},
    {staffNumber: 22102, staffName: "Ruusa", courseCode: "DTA621S", officeNumber: 205},
    {staffNumber: 22103, staffName: "Nashandi", courseCode: "DSA612S", officeNumber: 206}
];

service /lecturers on new http:Listener(9090) {

    resource function post addLecturer(Lecturer lecturer) returns string {
        io:println(lecturer);

        // 01 Check if lecture exists
        if (lecturerTable.hasKey(lecturer.staffNumber)) {
            return string `ERROR: Lecturer with staff number ${lecturer.staffNumber.toString()}  already exists.`;
        }

        // 02 Add lecturer and check for errors
        error? result = lecturerTable.add(lecturer);
        if (result is error) {
            return string `ERROR: ${result.message()}`;
        } else {
            return string `${lecturer.staffName} successfully added.`;
        }
    }

    resource function get allLectures() returns Lecturer[] {
        return lecturerTable.toArray();
    }

    resource function get lecturersByStaffNumber(int staffNumber) returns Lecturer|string {
        Lecturer? lecturer = lecturerTable[staffNumber];
        if (lecturer is ()) {
            return string `ERROR: Lecturer with staff number ${staffNumber} does not exists`;
        } else {
            return lecturer;
        }
    }

    resource function get checkLecturer(int staffNumber) returns boolean {
        return lecturerTable.hasKey(staffNumber);
    }

    resource function put updateLecturer(Lecturer lecturer) returns string {
        // 02 Add lecturer and check for errors
        error? result = lecturerTable.put(lecturer);
        if (result is error) {
            return string `ERROR: ${result.message()}`;
        } else {
            return string `${lecturer.staffName} successfully updated.`;
        }
    }

    resource function delete deleteLecturer(int staffNumber) returns string {
        // 02 Add lecturer and check for errors
        Lecturer lecturer = lecturerTable.remove(staffNumber);
        return string `${lecturer.staffName} successfully deleted.`;
    }

    resource function get getLecturersByCourseCode(string courseCode) returns Lecturer[] {
        table<Lecturer> lecturerResults = from Lecturer lecturer in lecturerTable
            order by lecturer.staffName ascending
            where lecturer.courseCode === courseCode
            select lecturer;
        return lecturerResults.toArray();
    }

    resource function get getLecturersByOffice(int officeNumber) returns Lecturer[] {
        table<Lecturer> lecturerResults = from Lecturer lecturer in lecturerTable
            order by lecturer.staffName ascending
            where lecturer.officeNumber === officeNumber
            select lecturer;
        return lecturerResults.toArray();
    }

}

//http:Caller caller: This represents the remote HTTP client that initiated the HTTP request. This is used to send back the HTTP response to the client.
//check caller->respond(response); sends the response to the client. If there is an error when sending the response, the check keyword will cause the function to return the error
//The http:Request type represents an HTTP request received by the service.
//http://localhost:9090/lecturers/