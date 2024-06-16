# Load environment variables from the .env file
if [ -f .env ]; then
    export $(cat .env | xargs)
else
    echo ".env file not found!"
    exit 1
fi

# Check if bucket name and region are set
if [ -z "$BUCKET_NAME" ] || [ -z "$REGION" ]; then
    echo "BUCKET_NAME and REGION must be set in the .env file."
    exit 1
fi

# Create the S3 bucket
aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION"

# Check if the bucket was created successfully
if [ $? -eq 0 ]; then
    echo "Bucket '$BUCKET_NAME' created successfully in region '$REGION'."
else
    echo "Failed to create bucket '$BUCKET_NAME'."
    exit 1
fi