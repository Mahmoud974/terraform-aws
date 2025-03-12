const AWS = require("aws-sdk");
const s3 = new AWS.S3();

exports.handler = async (event) => {
  const bucketName = "votre-bucket-s3";
  const fileName = "example.txt";
  const fileContent = "Hello, this is a test file uploaded to S3!";

  const params = {
    Bucket: bucketName,
    Key: fileName,
    Body: fileContent,
    ContentType: "text/plain",
  };

  try {
    const result = await s3.putObject(params).promise();
    console.log("Fichier téléchargé avec succès", result);
    return {
      statusCode: 200,
      body: JSON.stringify("Fichier téléchargé avec succès"),
    };
  } catch (error) {
    console.error("Erreur lors du téléchargement du fichier", error);
    return {
      statusCode: 500,
      body: JSON.stringify("Erreur lors du téléchargement du fichier"),
    };
  }
};
