const AWS = require("aws-sdk");
const docClient = new AWS.DynamoDB.DocumentClient();
const table = process.env.DYNAMO_TABLE;

exports.handler = async (event) => {
  const params = {
    TableName: table,
    Item: {
      id: Date.now().toString(),
      message: "Hello from Lambda + DynamoDB",
    },
  };

  await docClient.put(params).promise();

  return {
    statusCode: 200,
    body: JSON.stringify({ success: true, message: "Item created!" }),
  };
};
