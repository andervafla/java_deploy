pipeline {
    agent { label 'jenks-node' }

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        FRONTEND_DIR = 'frontend'
    }

    stages {
        stage('Show files') {
            steps {
                sh 'ls'
            }
        }

        stage('List Files in Root Directory') {
            steps {
                sh 'ls -la'
            }
        }

        stage('Navigate to Frontend Directory') {
            steps {
                dir("${FRONTEND_DIR}") {
                    sh 'ls -la'  
                }
            }
        }   

        stage('Build Frontend') {
            steps {
                dir("${FRONTEND_DIR}") {
                    sh 'npm install'  
                    sh 'npm run build' 
                }
            }
        }

        stage('Build Backend') {
            steps {
                sh 'gradle build -x test --no-daemon' 
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
