import ballerina/test;

@test:Config {}
function testDefaultMessage() returns error? {
    // Action: Send GET request to /data endpoint
    string returnValue = getDefaultMessage();
    
    // Validation: Verify response contains the expected string "Main Deployment Track"
    test:assertEquals(returnValue, "Hello World", "Return value should be 'Hello World'");
}
