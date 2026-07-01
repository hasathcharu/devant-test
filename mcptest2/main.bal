
import ballerina/mcp;

listener mcp:Listener mcpListener = new (8090);

@mcp:ServiceConfig {
    info: {
        name: "Calculator Service",
        version: "1.0.0"
    },
    sessionMode: mcp:STATELESS
}
service mcp:Service /mcp2 on mcpListener {
    @mcp:Tool
    remote function add(int a, int b) returns int {
        return a + b;
    }
}
