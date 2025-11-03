import ballerina/log;

public function main() returns error? {
    do {
        log:printInfo("The color is " + color);
    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
