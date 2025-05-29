const AWS = require("aws-sdk");
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    const params = {
        TableName: "ticket-generator-dynamodb-prod",
        Item: {
            id: "1234",
            message: "Hello from Lambda and DynamoDB!"
        }
    };
    await dynamoDB.put(params).promise();
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Data inserted into DynamoDB" })
    };
};
