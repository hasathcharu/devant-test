
import ballerina/mcp;
import ballerina/log;

listener mcp:Listener mcpListener = new (9090);

configurable string testValue = ?;

@mcp:ServiceConfig {
    info: {
        name: "Calculator Service",
        version: "1.0.0"
    },
    sessionMode: mcp:STATELESS
}
service mcp:Service /mcp on mcpListener {
    @mcp:Tool
    remote function add(int a, int b) returns int {
        log:printInfo(testValue);
        return a + b;
    }
}
