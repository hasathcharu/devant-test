import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get .() returns string|http:InternalServerError|error {
        do {
            log:printInfo("Configured Color: " + color);
            log:printInfo("Demo Config: " + demoConfig.toString());
            return "Configured Color: " + color;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
