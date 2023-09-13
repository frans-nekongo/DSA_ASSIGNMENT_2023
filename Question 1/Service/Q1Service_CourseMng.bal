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

table<Lecturer> key(staffNumber) lecturers = table [
    {officeNumber: 0, staffNumber: 1, staffName: "John", title: "Lecturer",courseName: "Data Structures and algorithms", coursseCode: "DSA611",nQFlevel: "7"}
    //,
    //{officeNumber: 1, staffNumber: 2, staffName: "Jane", title: "Lecturer",courseName: "Data Structures and algorithms", coursseCode: "DSA611",nQFlevel: "7"},
    //{officeNumber: 2, staffNumber: 3, staffName: "Jack", title: "Lecturer",courseName: "Data Structures and algorithms", coursseCode: "DSA611",nQFlevel: "7"},
    //{officeNumber: 3, staffNumber: 4, staffName: "John", title: "Lecturer",courseName: "Data Structures and algorithms", coursseCode: "DSA611",nQFlevel: "7"},
    //{officeNumber: 4, staffNumber: 5, staffName: "Jane", title: "Lecturer",courseName: "Data Structures and algorithms", coursseCode: "DSA611",nQFlevel: "7"}
    ];


service / on new http:Listener(9090) {

   resource function accessor path() {
    
   }
}
