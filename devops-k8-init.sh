# Initialize shell environment with following exports

export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
export REGION=us-west1
gcloud config set compute/region $REGION

# Enable GKE API
gcloud services enable container.googleapis.com \
    cloudbuild.googleapis.com \
    secretmanager.googleapis.com \
    containeranalysis.googleapis.com

# create artifact Registry
gcloud artifacts repositories create my-repository \
  --repository-format=docker \
  --location=$REGION

# create GKE cluster 
gcloud container clusters create hello-cloudbuild --num-nodes 1 --region $REGION

# configure Github and Git in cloud shell
curl -sS https://webi.sh/gh | sh 
gh auth login 
gh api user -q ".login"
GITHUB_USERNAME=$(gh api user -q ".login")
git config --global user.name "${GITHUB_USERNAME}"
git config --global user.email "${USER_EMAIL}"
echo ${GITHUB_USERNAME}
echo ${USER_EMAIL}
