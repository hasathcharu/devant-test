import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get hi() returns json {
        log:printInfo("GET /hi");
        return {message: "Hi"};
    }

    resource function post hi() returns json {
        log:printInfo("POST /hi");
        return {message: "Hi"};
    }

    resource function get hello() returns json {
        log:printInfo("GET /hello");
        return {message: "Hello"};
    }

    resource function put bye() returns json {
        log:printInfo("PUT /bye");
        return {message: "Bye"};
    }

    resource function get bye() returns json {
        log:printInfo("GET /bye");
        return {message: "Bye"};
    }
}
