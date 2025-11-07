import ballerina/graphql;

listener graphql:Listener graphqlListener = new (8080);

service /graphql on graphqlListener {
    remote function task(string query) returns string|error {
        do {
            string response = check aiAgent.run(query);
            return response;
        } on fail error err {
            // handle error
            return error("unhandled error", err);
        }
    }

    resource function get greet() returns string {
        return "Hello There";
    }

}
