import ballerina/ai;
import ballerina/http;

listener ai:Listener mathTutorListener = new (listenOn = check new http:Listener(8080));
listener ai:Listener mathTutor2Listener = new (listenOn= check new http:Listener(9090));
listener http:Listener myListener = new (7070);

service /MathTutor on mathTutorListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check mathTutorAgent.run(request.message, request.sessionId);
        return {message: stringResult};
    }
}

service /MathTutor on mathTutor2Listener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {
        string stringResult = check mathTutorAgent.run(request.message, request.sessionId);
        return {message: stringResult + "\n - This is from listener 2"};
    }
}

service /http on myListener {
    resource function get hello() returns string {
        return "Hello";
    }
}
