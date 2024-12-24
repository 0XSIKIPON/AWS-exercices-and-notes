# 1. Configure AWS CLI for the first user (login step)
aws configure
# Provide the Access Key, Secret Access Key, default region, and output format for the user.

# 2. List existing IAM users
echo "Listing IAM Users..."
aws iam list-users

# 3. List existing IAM groups
echo "Listing IAM Groups..."
aws iam list-groups

# 4. Inspect IAM policies attached to a specific group
GROUP_NAME="example-group-name" # Replace with your group name
echo "Listing policies attached to the group: $GROUP_NAME..."
aws iam list-attached-group-policies --group-name $GROUP_NAME

# Fetch detailed information for each policy attached to the group
POLICY_ARN="arn:aws:iam::aws:policy/example-policy" # Replace with your policy ARN
echo "Getting details for policy: $POLICY_ARN..."
aws iam get-policy --policy-arn $POLICY_ARN
aws iam get-policy-version --policy-arn $POLICY_ARN --version-id v1

# 5. Add a user to a specific group
USER_NAME="example-user-name" # Replace with your user name
echo "Adding user $USER_NAME to group $GROUP_NAME..."
aws iam add-user-to-group --group-name $GROUP_NAME --user-name $USER_NAME

# 6. Verify user's group membership
echo "Verifying group memberships for user $USER_NAME..."
aws iam list-groups-for-user --user-name $USER_NAME

# 7. Locate IAM sign-in URL
echo "Retrieving IAM account sign-in URL..."
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
SIGN_IN_URL="https://${ACCOUNT_ID}.signin.aws.amazon.com/console"
echo "IAM Sign-In URL: $SIGN_IN_URL"

# 8. Experiment with IAM policies - Simulate access for a user
ACTION_NAME="s3:ListBucket" # Replace with the action you want to test
RESOURCE_ARN="arn:aws:s3:::example-bucket" # Replace with the resource ARN
echo "Simulating access for user $USER_NAME..."
aws iam simulate-principal-policy --policy-source-arn "arn:aws:iam::${ACCOUNT_ID}:user/$USER_NAME" \
    --action-names $ACTION_NAME --resource-arns $RESOURCE_ARN

# 9. Switch to a different IAM user
# To switch users, reconfigure the AWS CLI with new credentials
echo "Switching to a different IAM user..."
aws configure
# Enter the credentials for the new user when prompted.

# Repeat the steps (as necessary) for the new user

