import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get .() returns json|error {
        do {
            return {message: "Hello"};
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

}
