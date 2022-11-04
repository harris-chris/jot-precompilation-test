# Financial Math Library

This repository uses [Jot.jl](https://github.com/harris-chris/Jot.jl) to allow us to run Julia on Lambda through Docker.

## Setup

1. [Install Docker](https://docs.docker.com/get-docker/)
2. Install the dependencies using `npm install`
3. Set up the `.env` file from `.env.example`

## Structure

`src/` contains a primary Julia script called `deploy-functions.jl`. This script instantiates the dependencies and runs 
Jot.jl to:
 - turn a Julia function into a "responder" for Lambda;
 - create a Docker image with the responder and it's dependencies;
 - push the Docker image to ECR;
 - create a Lambda function using the Docker image;

Each function that we want to deploy to Lambda needs to follow execute these steps. Future improvement will provide 
some automation for this process.

## Deploying

1. Run `npm run build` to build the wrapper Docker image that sets up the environment with Julia and AWS
2. Run `npm start` to run the Docker image, executing `deploy-functions.jl`, and deploying the Lambda functions