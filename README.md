# ci-cd-test-app

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

## The GOAL
The basic idea of what I want to achieve with this solution is:
1. Have a basic skeleton .NET app ready to build as a Docker image 
2. Have a separate ci.yaml which builds and versions (using [GitVersion](https://gitversion.net/)) the app
3. Have a cd.yaml that deploys the app to docker registry and updates the image in [ci-cd-test-app-config](https://github.com/sebokoslav/ci-cd-test-app-config)
4. Set up [web-app-chart](https://github.com/sebokoslav/web-app-chart) as a Helm chart repository
5. [ci-cd-test-app-config](https://github.com/sebokoslav/ci-cd-test-app-config) will contain 3 environments for the app (dev, test, prod) and will use a helm chart from [web-app-chart](https://github.com/sebokoslav/web-app-chart) for the config

## How to run this application

### Install minikube
Have a look at https://minikube.sigs.k8s.io/docs/start/. Install minikube including some container manager (I used Docker Desktop).

Go to your terminal and start minikube
```
minikube start
```

### Install ArgoCD
https://argo-cd.readthedocs.io/en/stable/getting_started/

In a separate terminal port forward your ArgoCD into localhost:8080

```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Create the application in ArgoCD

Go into the ArgoCD application (localhost:8080).

Click Create.

In the app creation window switch to yaml and paste this configuration:

```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cicdtest-application-dev
  namespace: argocd
spec:
  project: default

  source:
    repoURL: https://github.com/sebokoslav/ci-cd-test-app-config.git
    targetRevision: dev
    path: ci-cd-test
  destination: 
    server: https://kubernetes.default.svc
    namespace: cicdtest

  syncPolicy:
    syncOptions:
    - CreateNamespace=true

    automated:
      selfHeal: true
      prune: true
```

The app should sync and create an application for the dev environmet

In the separate terminal window run

```
minikube tunnel
```

Go to localhost:3000/WeatherForecast

You should get the response sucessfully