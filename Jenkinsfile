pipeline {
    agent any
    
    environment {
        DOTNET_IMAGE_TAG = "dotnet-app"
        DOTNET_CONTAINER_NAME = "dotnet-container"
        SERVER_IP = "74.235.239.120"
        SERVER_PORT = "80"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the repository
                git branch: 'main', url: 'https://github.com/abubakar1o/DotNet-cicd.git'
            }
        }
        
        stage('Build and Test') {
            steps {
                // Build and test the .NET application
                sh 'dotnet restore'
                sh 'dotnet build'
                sh 'dotnet test'
            }
            post {
                success {
                    echo "Build and Test succeeded"
                }
                failure {
                    echo "Build and Test failed"
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Build the Docker image for the .NET application
                script {
                    sh "docker build -t ${DOTNET_IMAGE_TAG} ."
                }
            }
            post {
                success {
                    echo "Docker image build succeeded"
                }
                failure {
                    echo "Docker image build failed"
                }
            }
        }
        
        stage('Deploy') {
            steps {
                // Deploy the Docker container on the server
                script {
                    sh "ssh your_username@${SERVER_IP} 'docker stop ${DOTNET_CONTAINER_NAME} || true'"
                    sh "ssh your_username@${SERVER_IP} 'docker rm ${DOTNET_CONTAINER_NAME} || true'"
                    sh "ssh your_username@${SERVER_IP} 'docker run -d --name ${DOTNET_CONTAINER_NAME} -p ${SERVER_PORT}:80 ${DOTNET_IMAGE_TAG}'"
                }
            }
            post {
                success {
                    echo "Deployment succeeded"
                }
                failure {
                    echo "Deployment failed"
                }
            }
        }
    }
}
