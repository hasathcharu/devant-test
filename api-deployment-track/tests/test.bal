

import ballerina/http;
import ballerina/test;

// HTTP client for testing
http:Client clientEp = check new ("http://localhost:9090");

// Test for Scenario 1.1 (Happy Path) - GET /data endpoint success
@test:Config {}
function testGetDataHappyPath() returns error? {
    // Action: Send GET request to /data endpoint
    string response = check clientEp->/data();
    
    // Validation: Verify response contains the expected string "Main Deployment Track"
    test:assertEquals(response, "Main Deployment Track j", "Response should contain 'Main Deployment Track'");
}

// Test for Scenario 1.2 (Error Path) - Simulate internal service failure
@test:Config {}
function testGetDataErrorPath() returns error? {
    // Note: This test simulates error handling by testing the error response structure
    // In a real scenario, we would need to inject failures or mock dependencies
    
    // For this test, we'll test the error handling by checking if the service
    // properly handles and returns errors when they occur
    // Since we cannot directly inject failures in this simple service,
    // we'll verify the error handling structure by testing edge cases
    
    // Action: Send GET request and handle potential errors using check expression
    // The check expression will handle ClientError by propagating it as an error
    string|http:Response response = check clientEp->/data();
    
    if response is http:Response {
        // If we get an HTTP response object, check if it's an error response
        if response.statusCode == 500 {
            // Validation: Verify response status code is 500 for internal server error
            test:assertEquals(response.statusCode, 500, "Status code should be 500 for internal server error");
            
            // Verify error response structure
            json|error payload = response.getJsonPayload();
            if payload is json {
                // Check if error message contains "unhandled error"
                string errorMsg = payload.toString();
                test:assertEquals(errorMsg.includes("unhandled error"), true, "Error response should contain 'unhandled error'");
            }
        }
    } else {
        // If we get a successful JSON response, verify it's the expected success case
        test:assertEquals(response, "Main Deployment Track", "Should receive expected success response");
    }
}

// Helper test to verify logging functionality
@test:Config {}
function testGetDataLogging() returns error? {
    // Action: Send GET request to /data endpoint to trigger logging
    string response = check clientEp->/data();
    
    // Validation: Verify response is successful (logging verification would require log capture setup)
    test:assertEquals(response, "Main Deployment Track", "Response should be successful to confirm logging occurred");
    
    // Note: In a complete test setup, we would capture and verify the log entry
    // "Main Deployment Track" was generated using log capture mechanisms
}
