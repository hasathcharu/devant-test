import ballerina/http;
import ballerina/log;

// listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on new http:Listener(9090) {
    resource function get data() returns error|json|http:InternalServerError {
        do {
            log:printInfo("Main Deployment Track");
            return "Main Deployment Track";
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
