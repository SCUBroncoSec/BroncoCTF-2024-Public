# ctfd-theme

This folder contains a (slightly modified) version of [ctfd-neon-theme](https://github.com/chainflag/ctfd-neon-theme), and a Dockerfile to build a container image of CTFd with the theme.

## How To: Build CTFd and upload to Artifact Registry

### Prerequisites

1. Someone has used Terraform to [set up the GCP/GKE environment](../gke/README.md)
2. Your Google account has permissions for the BroncoCTF project
3. You have `google-cloud-sdk` (`gcloud` command) installed and have logged in
4. You have Docker installed on your machine

### Authenticating with Artifact Registry

Run the command: `gcloud auth configure-docker us-west1-docker.pkg.dev`. You will only need to do this once

### Building CTFd

1. Make sure Docker is running. Most likely this means having Docker Desktop open (you can close the window after it opens)
2. `cd` into this directory and run `docker build -t us-west1-docker.pkg.dev/broncoctf-YEAR/broncoctf-YEAR/ctfd:latest .` (Make sure to replace YEAR with the current year)

### Uploading to Artifact Registry

Run `docker push` with the URL you used in `docker build` (without the `:latest` tag)
