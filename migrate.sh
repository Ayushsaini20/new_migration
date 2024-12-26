#!/bin/bash

# Mapper
# BitBucket Workspace -> GitHub Enterprise
# BitBucket Project -> GitHub Organization
# BitBucket Repository -> GitHub Repository

BB_WORKSPACE=bb_to_gh
BB_PROJECT=test
BB_REPO=test_repo1
GH_REPO=bbtest
GH_USERNAME=Ayushsaini20
GH_EMAIL=ayushsaini963@gmail.com

echo "Cloning BitBucket Repository into GitHub Runner Context"
git clone https://x-token-auth:$BB_TOKEN@bitbucket.org/$BB_WORKSPACE/$BB_REPO.git
cd $BB_REPO

echo "Creating GitHub Repository with GH APIs"

curl -X POST https://api.github.com/user/repos \
-H "Authorization: Bearer $GHE_TOKEN" \
-H "Accept: application/vnd.github+json" \
-d "{
  \"name\": \"$GH_REPO\",
  \"description\": \"Test Repo migrated from BitBucket\",
  \"private\": true
}"

echo "Adding GitHub remote..."
git config user.name $GH_USERNAME
git config user.email $GH_EMAIL
git remote add github "https://x-access-token:$GHE_TOKEN@github.com/$GH_USERNAME/$GH_REPO"

if [ $? -ne 0 ]; then
    echo "Failed to add GitHub remote. Exiting."
    exit 1
fi

echo "Pushing to GitHub..."
git push --mirror github

if [ $? -ne 0 ]; then
    echo "Failed to push to GitHub. Exiting."
    exit 1
fi

echo "Cleaning up Workspace"
cd ..
#rm -rf $BB_REPO

echo "Migration Completed Successfully!"
