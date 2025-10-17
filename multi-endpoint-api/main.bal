import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get hello() returns error|json|http:InternalServerError {
        do {
            log:printInfo("Hello World");
            return {message: "Hello World"};
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

    resource function get hi() returns error|json {
        do {
            log:printInfo("Hi there");
            return {message: "Hi there"};
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

    resource function get morning() returns error|json {
        do {
            log:printInfo("Good Morning");
            return {message: "Good Morning"};
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}
