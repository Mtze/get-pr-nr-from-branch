#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of arguments"
    echo "Usage: ./pr_number.sh REPOSITORY_USER REPOSITORY_NAME"
    echo "Example: ./pr_number.sh ls1intum Artemis"
    exit 1
fi


REPOSITORY_NAME=$2
PROJECT_NAME=$1


apt update
apt install jq httpie -y


# Store branch name in variable
echo "Get current branch"
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $BRANCH_NAME"


if [[ $BRANCH_NAME == "develop" ]]
then
	# The develop branch is tagged with "latest"
	IMAGE_TAG="latest" 

else
	# This must be a custom branch, and should be associated with an PR 
	# Query Github API and search for the current branch. Get the PR number to the branch 
	echo "Query Github API for branch associated PR number"
	PR_NUMBER=$(http GET https://api.github.com/repos/$PROJECT_NAME/$REPOSITORY_NAME/pulls?head=ls1intum:$BRANCH_NAME | jq ".[].number")

	echo "API RESULT: $PR_NUMBER"

	# Check if result is a valid PR number
	re='^[0-9]+$'
	if ! [[ $PR_NUMBER =~ $re ]]
	then
   		echo "error: Result is not a valid PR number" >&2
   		IMAGE_TAG="unkown"
	else 
		IMAGE_TAG=$PR_NUMBER
	fi 

fi


echo "Storing computed image tag: "
echo "$IMAGE_TAG"
echo $IMAGE_TAG > pr_number.txt