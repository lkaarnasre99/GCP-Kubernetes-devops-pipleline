
curl -sS https://webi.sh/gh | sh
gh auth login
gh api user -q ".login"
GITHUB_USERNAME=$(gh api user -q ".login")
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"
echo ${GITHUB_USERNAME}
echo ${USER_EMAIL}

# create Github repo
gh repo create  sample-app --private 

# create directory for the app & add repo using git remote  
mkdir sample-app
cd sample-app
git init
git remote add origin https://github.com/lkaarnasre99/sample-app.git
git remote -v

# create directory with repo name in cloud shell and download app from storage bucket
cd ~
gsutil cp -r gs://spls/gsp330/sample-app/* sample-app

cd ~

export REGION="us-central1"
export ZONE="us-central1-c"
for file in sample-app/cloudbuild-dev.yaml sample-app/cloudbuild.yaml; do
    sed -i "s/<your-region>/${REGION}/g" "$file"
    sed -i "s/<your-zone>/${ZONE}/g" "$file"
done

cd sample-app 

# commit & push to repo
git add .
git commit -m "initial commit"
git push origin master

# create a branch Dev
git checkout -b dev
git branch
git status

