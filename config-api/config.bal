configurable string color = ?;
configurable record {
    string host;
    int port;
    string username;
    string password;
} demoConfig = ?;

configurable record {
    string name;
} demoConfigDefaultable = {
    name: "defaultName"
};

configurable string name = "defaultUser";

configurable map<record { string id; string value; }> demoConfigMap = ?;

configurable map<record { string id; string value; }> demoConfigMapDefaultable = {
    key1: { id: "1", value: "value1" },
    key2: { id: "2", value: "value2" }
};
