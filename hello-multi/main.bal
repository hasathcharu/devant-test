import ballerina/http;

listener http:Listener httpListener1 = new (9090);

service / on httpListener1 {
    resource function get .() returns string|http:InternalServerError|error {
        do {
            return "Hello from 9090";
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}

listener http:Listener httpListener2 = new (9092);

service / on httpListener2 {
    resource function get .() returns string|http:InternalServerError|error {
        do {
            return "Hello from 9092";
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }
}