import ballerinax/rabbitmq;

type Order readonly & record {
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
};

configurable string host = ?;
configurable int port = ?;
configurable string username = ?;
configurable string password = ?;


public function main() returns error? {
    rabbitmq:Client orderClient = check new (host, port, {username: username, password: password, virtualHost: username});
    Order newOrder = {
        orderId: 1,
        productName: "Laptop",
        price: 1200.50,
        isValid: true
    };
    check orderClient->publishMessage({
        content: newOrder,
        routingKey: "Test",
        exchange: ""
    });
}


