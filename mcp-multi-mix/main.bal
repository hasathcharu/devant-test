
import ballerina/mcp;
import ballerina/http;

listener mcp:Listener mcpListener1 = new (9090);

configurable int baseValue = ?;

@mcp:ServiceConfig {
    info: {
        name: "Calculator Service",
        version: "1.0.0"
    },
    sessionMode: mcp:STATELESS
}
service mcp:Service /mcp on mcpListener1 {
    @mcp:Tool
    remote function add(int a, int b) returns int {
        return baseValue + a + b;
    }
}

listener mcp:Listener mcpListener2 = new (9092);

@mcp:ServiceConfig {
    info: {
        name: "Calculator Service",
        version: "1.0.0"
    },
    sessionMode: mcp:STATELESS
}
service mcp:Service /mcp on mcpListener2 {
    @mcp:Tool
    remote function subtract(int a, int b) returns int {
        return baseValue + a - b;
    }
}

listener http:Listener httpListener2 = new (9094);

service / on httpListener2 {
    resource function get .() returns string|http:InternalServerError|error {
        do {
            return "Hello from 9094";
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
