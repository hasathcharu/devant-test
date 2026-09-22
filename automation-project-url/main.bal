import ballerina/io;

public function main() returns error? {
    string response = check clientEp->get("");
    io:println(response);
}
