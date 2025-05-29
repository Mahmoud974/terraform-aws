const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");
const { unmarshall } = require("@aws-sdk/util-dynamodb");

const client = new DynamoDBClient({ region: "eu-west-3" });

exports.handler = async (event) => {
  const tableName = process.env.DYNAMO_TABLE;

  try {
    const data = await client.send(
      new ScanCommand({
        TableName: tableName,
      })
    );

    const items = data.Items.map((item) => unmarshall(item));

    return {
      statusCode: 200,
      headers: {
        "Access-Control-Allow-Origin": "*", // CORS
        "Access-Control-Allow-Methods": "OPTIONS, GET, POST",
        "Access-Control-Allow-Headers": "Content-Type",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        success: true,
        count: items.length,
        data: items,
      }),
    };
  } catch (error) {
    console.error("Erreur DynamoDB:", error);
    return {
      statusCode: 500,
      headers: {
        "Access-Control-Allow-Origin": "*", // CORS
        "Access-Control-Allow-Methods": "OPTIONS, GET, POST",
        "Access-Control-Allow-Headers": "Content-Type",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        success: false,
        message: "Erreur serveur",
        error: error.message,
      }),
    };
  }
};
