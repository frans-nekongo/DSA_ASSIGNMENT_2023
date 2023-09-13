import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.

# storage of variables

type office record {|
        int officeNumber;

|};
type Lecturer record {|
    readonly int staffNumber;
    string staffName;
    string title;
    
|};

type course record {|
string courseName;
    string coursseCode;
    string nQFlevel;
    
|};

table<Lecturer> key(staffNumber) lecturers = table [
    {title: "Bluee Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];


service / on new http:Listener(9090) {

   resource function accessor path() {
    
   }
}
