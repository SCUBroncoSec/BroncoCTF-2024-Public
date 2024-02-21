# GKE Provisioning Folder

This folder contains the Terraform configuration that provisions the BroncoCTF Kubernetes cluster, and installs ArgoCD (the tool we use to deploy infrastrure on Kubernetes)

## How To: Set up the cluster (from scratch)

### Setting up the GCP project

1. Create a project in GCP for the CTF (Should be named `bronco-ctf-CURRENTYEAR`)
2. Go to `IAM & Admin` in the GCP console
3. Click `GRANT ACCESS` and add your Gmail/SCU Email as a principal, with the `Owner` role
4. Go to your email and accept the invite

### Setting up your environment

1. Make sure you have the following homebrew packages installed: `google-cloud-sdk`, `terraform`, `kubernetes-cli`
2. Install the Google Cloud auth component with `gcloud components install gke-gcloud-auth-pluign`
3. Log in to Google Cloud with the command: `gcloud auth application-default login`
4. Set your project with `gcloud config set project bronco-ctf-CURRENTYEAR`

### Initialize Terraform & GKE Cluster

1. Comment out everything in `remotestate.tf` and the `backend` block in `provider.tf` (lines 2-5)
2. `cd` into this folder and run `terraform init`
3. Run `terraform apply`, don't worry if this command takes a long time (~10 minutes), we're making alot of resources
4. If everything applies sucessfully, uncomment everything from step 1, run `terraform init -reconfigure` and allow it to copy the state when it asks you to

## How To: Use Terraform when the cluster already exists

1. Make sure you have access to the GCP project (steps 2-4) in [Setting up the GCP project](#setting-up-the-gcp-project)
2. [Set up your environment](#setting-up-your-environment)
3. `cd` into this folder and run `terraform init`
