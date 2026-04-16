import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get .() returns string|http:InternalServerError|error {
        do {
            return "Hello, World V3! Greeting: " + greeting;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
