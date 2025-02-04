# Moving Microservices on .NET to AKS using GitHub Copilot

## Pre-requisites

1. Azure Subscription
2. GitHub Copilot enabled for repository
3. Azure SPN or Managed Identity with Federated Credentials setup for your repository
4. VSCode 
5. VSCode GitHub Copilot for Azure Extension

## Demo Scenario

We have customer Contoso who has a .NET 5 application with a frontend client, an API backend and a MongoDB. They're currently running on-premises and need assistance with migrating to Azure. They've decided they'd like to use AKS for all three services. You think that they should use an external MongoDB hosted on CosmosDB, but they're adamant they want to use AKS for it. They have also indicated that they want to use GitHub over Azure DevOps to handle code management and deployment. You help them set up some basic Iac using Bicep to do a POC of the platform. You then identify the pieces you need to do the migration: Dockerfiles (1 for the client, 1 for the API), a GitHub Actions workflow, and K8s manifest for the Kubernetes deployment. You're knowledgable about the process and technology, but you need to speed up the process. You decide to use GitHub Copilot for Azure to help you generate the deployment files. 

## Demo Steps

For this example, the infrastructure has been developed in Bicep and added to the repository already. You will follow Copilot prompts for assisting with containerization and deployment using GitHub Actions. 

### Pre-Demo Tasks
1. Infrastructure developed in Bicep.
2. Empty Dockerfiles, GitHub Actions and K8s manifests files created in their respective locations. 

### Introduction
1. Open VSCode and install GitHub Copilot for Azure extension
2. Login to Azure and GitHub in VSCode
3. Open the GitHub Copilot chat window
4. Use the following prompt: `@azure Tell me about my application`

### Containerization
1. Use the following prompt: `@azure Help me write Dockerfiles for my application.`
2. Use the following prompt: `@azure Use dotnet 5 for the images`
3. Open the respective Dockerfiles. Click the *Apply in Editor* button in Copilot and save the content in each respective file. 

### Deployment (Kubernetes Manifests)
1. Use the following prompt: `@azure Help me write manifests for my application.`
2. Use the following prompt: `@azure Can you add resource limits to the containers?`
3. Use the following prompt: `@azure Add node tolerations with a key app and value being the name of the app.`
4. Use the following prompt: `@azure I need a deployment for my mongodb.`
5. Open the respective manifests. Click the *Apply in Editor* button in Copilot and save the content in each respective file. 

### Deployment (GitHub Actions)
1. Use the following prompt: `@Help me write a GitHub Actions to deploy this application including a Bicep deployment.`
2. Use the following prompt: `@azure Use OIDC for Azure login.`
3. Use the following prompt: `@azure Use the Bicep-deploy action to deploy the Bicep infra.`
4. Use the following prompt: `@azure Can you deploy the AKS manifests using the deploy action?`
5. Use the following prompt: `@azure Split the workflow into three stages: deploy-infra, build-and-push and deploy.`
6. Use the following prompt: `@azure For deploy-infra stage, make the resource group and acr outputs for subsequent jobs.`
7. Use the following prompt: `@azure Deploy all manifests in the manifests folder in the k8s-deploy action`
8. Use the following prompt: `@azure Change the folder from k8s to manifests/ and remove the step to deploy a resource group.`
9.  Open the workflow file. Click the *Apply in Editor* button in Copilot and save the content in the file. s

### Edits

After using Copilot to generate the structure and some of the functionality for each of these components, edits had to be made to support a successful deployment including:
- Updating resource limits on manifests 
- Adding environment variables to the manifests 
- Update name of placeholder for ACR name 
- Add Docker login to GitHub Actions
- Add install of Kubectl and Kube login to GitHub Actions
- Add a step in GitHub Actions to replace the name of the ACR placeholder dynamically in the manifest. 

## Activities

### Activity One: GitHub Actions

Let's try to generate the GitHub Actions workflow ourselves. We showed some basic steps in the demo, but we had to make a few edits to the workflow and additional commands to make it work. Given the following information, try to use your knowledge and Copilot to generate the GitHub Actions workflow.

1. We have IaC we need to deploy that's written in Bicep using [Azure Verified Modules](https://aka.ms/avm). 
2. Cluster is AAD enabled
3. We need to build and push our container images using Docker and ACR. 

Sample Commands:

`@azure Add a step for replacing <ACR Name> placeholder in the AKS manifests.`

`@azure Add a step to install Kubectl and Kubelogin before the K8s deploy.`

`@azure Can you write a Dependabot workflow for me? `

`@azure Can you setup X as an output for X stage?`

`@azure What is the most secure method for logging into ACR in a GitHub Actions workflow?`

### Activity Two: K8s Deployment

Let's try to generate the AKS deployment files using Helm charts. We showed how to use Copilot to generate K8s manifests and deploy them using Kubectl. Using your knowledge and the information below try to generate the Helm charts to accomplish the same task. 

1. You need these environment variables:
   1. Shopping API
      1. ASPNETCORE_ENVIRONMENT
      2. DatabaseSettings__ConnectionString
   2. Shopping Client
      1. ShoppingAPIUrl

Sample Commands:

`@azure How can I use Helm to deploy my application?`

`@azure Can you add these <Insert environment variables> into my chart template?`

`@azure How do I manage secrets with Helm?`

`@azure How can I use Kustomize to manage my deployment?`
