exports.handler = async (event) => {
    console.log("Lambda function is triggered");
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Hello from Lambda!" }),
    };
};
