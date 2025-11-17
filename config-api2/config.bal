configurable string color = "red";
configurable record {
    string host;
    int port;
    string username;
    string password;
    string another;
    record {|
        string nestedKey;
        int nestedValue;
    |} nestedRecord;
} demoConfig = ?;

