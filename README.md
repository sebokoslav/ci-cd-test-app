# ci-cd-test-app

## Overview
This is a repo for my own study and tinkering with: 
* GitHub's Ci/CD pipelines 
* Local Kubernetes using Minikube
* ArgoCD
* Helm charts

## Repos
Repos for this solution are:
* [ci-cd-test-app](https://github.com/sebokoslav/ci-cd-test-app) - this is where the actual code resides
* [ci-cd-test-app-config](https://github.com/sebokoslav/ci-cd-test-app-config) - config repo for Kubernets/ArgoCD
* [web-app-chart](https://github.com/sebokoslav/web-app-chart) - chart repo for the k8s config

The basic idea of what I want to achieve with this solution is:
1. Have a basic skeleton .NET app ready to build as a Docker image 
2. Have a separate ci.yaml which builds and versions (using [GitVersion](https://gitversion.net/)) the app
3. Have a cd.yaml that deploys the app to docker registry and updates the image in [ci-cd-test-app-config](https://github.com/sebokoslav/ci-cd-test-app-config)
4. Set up [web-app-chart](https://github.com/sebokoslav/web-app-chart) as a Helm chart repository
5. [ci-cd-test-app-config](https://github.com/sebokoslav/ci-cd-test-app-config) will contain 3 environments for the app (dev, test, prod) and will use a helm chart from [web-app-chart](https://github.com/sebokoslav/web-app-chart) for the config