# Migrate Repo from BitBucket to GitHub Enterprise
 
## Mapper
# BitBucket Workspace -> GitHub Enterprise
# BitBucket Project -> GitHub Organization
# BitBucket Repository -> GitHub Repository
 
BB_WORKSPACE=noicecurse
BB_PROJECT=org
BB_REPO=repo
#GITHUB_REMOTE_URL=https://x-access-token:$GHE_TOKEN@github.com/nishkarshraj/23-Dec-8
GITHUB_REMOTE_URL=https://X-ACCESS-TOKEN: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@github.com/Ayushsaini20/newtest_repo.git
GH_REPO="newtest_repo"
GH_USERNAME=Ayushsaini20
GH_EMAIL=ayushsaini963@gmail.com
 
echo "Cloning BitBucket Repository into GitHub Runner Context"
git clone https://x-token-auth:ATCTT3xFfGN0Ve3CQ6yEbGWRfiZ_Gq2bha6lTPQfAKlseqtlRYOSvTMArZTx5wUvab8uBly5ER_KolfsdyCYnJO7JYHORPgIIm8jQgIsmkM4oNWsXbFnvCJUj325QvQUFRok3AK1H4ptGl_6jVXXxhL0feKr7bb2lCQVd5XmbQ9_Gqs7sr5qG7c=C7638B80@bitbucket.org/bb_to_gh/test_repo1.git
cd test_repo1
 
echo "Creating GitHub Repository with GH APIs"
 
curl -X POST https://api.github.com/user/repos \
-H "Authorization: Bearer $GHE_TOKEN" \
-H "Accept: application/vnd.github+json" \
-d "{
  \"name\": \"$GH_REPO\",
  \"description\": \"Test Repo\",
  \"private\": true
}"
 
 
echo "Adding GitHub remote..."
git config user.name NishkarshRaj
git config user.email nishkarshraj000@gmail.com
git remote add github "$GITHUB_REMOTE_URL"
 
if [ $? -ne 0 ]; then
    echo "Failed to add GitHub remote. Exiting."
    exit 1
fi
 
# Step 3: Push all branches and tags to GitHub
echo "Pushing to GitHub..."
git push --mirror github
 
if [ $? -ne 0 ]; then
    echo "Failed to push to GitHub. Exiting."
    exit 1
fi
 
echo "Cleaning up Workspace"
cd ..
rm -rf $BB_REPO
