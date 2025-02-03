# create Github repo 
gh repo create  hello-cloudbuild-app --private 

# create Github repo
gh repo create  hello-cloudbuild-env --private

# create directory with repo name in cloud shell and download app from storage bucket
cd ~
mkdir hello-cloudbuild-app
gcloud storage cp -r gs://spls/gsp1077/gke-gitops-tutorial-cloudbuild/* hello-cloudbuild-app

# configure github repo as remote
cd ~
mkdir hello-cloudbuild-app
