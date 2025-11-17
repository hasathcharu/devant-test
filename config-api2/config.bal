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

configurable map<string> demoConfigMap = ?;

configurable map<string> demoConfigMapDefaultable = {
    key1: "value1",
    key2: "value2"
};
