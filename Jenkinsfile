pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhubid')
        FRONTEND_IMAGE = "andervafla/frontend-image"
        BACKEND_IMAGE = "andervafla/backend-image"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/andervafla/java_deploy.git'
            }
        }

        stage('Print Directory Contents') {
            steps {
                script {
                    sh 'ls -la'
                    sh 'ls -la frontend'
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                script {
                    dockerImageBackend = docker.build("${BACKEND_IMAGE}:${env.BUILD_NUMBER}", ".")
                }
            }
        }

        stage('Build Frontend Image') {
            steps {
                script {
                    dockerImageFrontend = docker.build("${FRONTEND_IMAGE}:${env.BUILD_NUMBER}", "./frontend")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        dockerImageBackend.push("${env.BUILD_NUMBER}")
                        dockerImageBackend.push("latest")

                        dockerImageFrontend.push("${env.BUILD_NUMBER}")
                        dockerImageFrontend.push("latest")
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed. Check the logs.'
        }
    }
}
