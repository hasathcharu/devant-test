import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service / on httpDefaultListener {
    resource function get hi(http:Request req) returns json {
        logRequest(req);
        return {message: "Hi"};
    }

    resource function post hi(http:Request req) returns json {
        logRequest(req);
        return {message: "Hi"};
    }

    resource function get hello(http:Request req) returns json {
        logRequest(req);
        return {message: "Hello"};
    }

    resource function put bye(http:Request req) returns json {
        logRequest(req);
        return {message: "Bye"};
    }

    resource function get bye(http:Request req) returns json {
        logRequest(req);
        return {message: "Bye"};
    }
}
