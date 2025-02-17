
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

# create directory with repo name in cloud shell and download app from storage bucket
cd ~
gsutil cp -r gs://spls/gsp330/sample-app/* sample-app

export REGION="REGION"
export ZONE="ZONE"
for file in sample-app/cloudbuild-dev.yaml sample-app/cloudbuild.yaml; do
    sed -i "s/<your-region>/${REGION}/g" "$file"
    sed -i "s/<your-zone>/${ZONE}/g" "$file"
done

# commit & push to repo
git add .
git commit -m "initial commit"
git push orign main

# create a branch Dev
git checkout -b dev
