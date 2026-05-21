import ballerina/graphql;

listener graphql:Listener graphqlListener = new (8080);

service /graphql on graphqlListener {
    # "This is a sample message."
    resource function get message() returns string {
        return "Hello World";
    }
}
