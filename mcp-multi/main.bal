
import ballerina/mcp;

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

    @mcp:Tool
    remote function multiply(int a, int b) returns int {
        return a * b;
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
