pipeline {
    agent any

    environment {
        // Define Docker image name and container name
        DOCKER_IMAGE = 'django-docker'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_REPO = 'yourusername'  // Replace with your Docker Hub username or registry
        CONTAINER_NAME = 'django-container'
        DOCKERFILE_PATH = '.'  // Path to Dockerfile (if it's in the root, otherwise adjust)
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from the repository
                git 'https://github.com/ArchiChaudhari/django.git'  // Replace with your repo URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile
                    sh "docker build -t ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKERFILE_PATH}"
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Run tests if needed
                    // Example: Run a Django test suite
                    // sh "docker run ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:${DOCKER_TAG} python manage.py test"
                    
                    // For now, we just check if the container runs
                    sh "docker run --rm ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:${DOCKER_TAG} python manage.py --version"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub (you need to set up credentials in Jenkins)
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credential', usernameVariable: 'archichaudhari'

, passwordVariable: '9561289589@aA')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin'
                    }

                    // Push the Docker image to Docker Hub
                    sh "docker push ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }

        stage('Deploy to Production') {
            steps {
                script {
                    // Stop and remove the old container (if exists)
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    // Run the new Docker container with the deployed image
                    sh """
                        docker run -d --name ${CONTAINER_NAME} -p 8000:8000 ${DOCKER_REGISTRY}/${DOCKER_REPO}/${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker resources
            sh 'docker system prune -f'
        }
    }
}
