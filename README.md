# Moving Microservices on .NET to AKS using GitHub Copilot

## Pre-requisites

1. Azure Subscription
2. GitHub Copilot enabled for repository
3. Azure SPN or Managed Identity with Federated Credentials setup for your repository
4. VSCode 
5. VSCode GitHub Copilot for Azure Extension

## Demo Steps

For this example, the infrastructure has been developed in Bicep and added to the repository already. You will follow Copilot prompts for assisting with containerization and deployment using GitHub Actions. 

### Introduction
1. Open VSCode and install GitHub Copilot for Azure extension
2. Login to Azure and GitHub in VSCode
3. Open the GitHub Copilot chat window
4. Use the following prompt: `@azure Tell me about my application`

### Containerization
1. Use the following prompt: `@azure Help me write Dockerfiles for my application.`
2. Use the following prompt: `@azure Change the image version dotnet 5.`
3. Create a Dockerfile in the `Shopping/Shopping.API` and in the `Shopping/Shopping.Client` folder.
4. Click the *Apply in Editor* button in Copilot and save the content in each respective file. 

### Deployment (Kubernetes Manifests)
1. Use the following prompt: `@azure Help me write manifests for my application.`
2. Use the following prompt: `@azure Can you add resource limits to the containers? Requests: 64MI, 0.1 cpu. Limits: 256MI, 0.5 cpu.`
3. Save the manifest files from Copilot to the manifests folder. 
4. Use the following prompt: `@azure I need a secret for my shopping service url.`
5. Use the following prompt: `@azure I need a config map mapping my mongodb connection string.`

### Deployment (GitHub Actions)
1. Use the following prompt: `@Help me write a GitHub Actions workflow for this application.`
2. Use the following prompt: `@azure Add the Bicep subscription deployment to the workflow.`
3. Use the following prompt: `@azure Use OIDC for Azure login.`
4. Use the following prompt: `@azure Can you make the resource group, AKS cluster, and registry name job outputs from the Bicep deployment?`
5. Use the following prompt: `@azure Can you add a step to replace the <ACR Name> in the aks manifests to the name of the acr?`
5. Use the following prompt: `@azure Can you combine the AKS deployments into one?`
6. Use the following prompt: `@azure Use the bicep-deploy action to deploy the Bicep`
7. Inspect the file and create a workflow file in `./.github/workflows/` and save the content to the file. 
8. Inspect the file and make changes including

## Activity Steps
