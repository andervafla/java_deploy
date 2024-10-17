pipeline {
    agent { label 'jenks-node' }

    environment {
        GRADLE_HOME = "${env.WORKSPACE}/gradle"  
        GRADLE_BIN = "${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin" 
        SSH_KEY_PATH = "${env.WORKSPACE}/key/my_ssh_key"
    }

    stages {
        stage('Initialize Terraform') {
            steps {
                dir("TerraformAWS") {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                dir("TerraformAWS") {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

         stage('Retrieve Terraform Outputs') {
            steps {
                dir("TerraformAWS") {
                    script {
                        def frontend_ip = sh(returnStdout: true, script: "terraform output -raw frontend_public_ip").trim()
                        def backend_ip = sh(returnStdout: true, script: "terraform output -raw backend_public_ip").trim()
                        def database_ip = sh(returnStdout: true, script: "terraform output -raw database_public_ip").trim()
                        def prometheus_ip = sh(returnStdout: true, script: "terraform output -raw prometheus_public_ip").trim()


                        env.FRONTEND_IP = frontend_ip
                        env.BACKEND_IP = backend_ip
                        env.DATABASE_IP = database_ip
                        env.PROMETHEUS_IP = prometheus_ip
                    }
                }
            }
        }

        stage('Update .env File') {
                    steps {
                        script {
                            def envFilePath = '/home/jenkins/workspace/java-pipeline/frontend/.env'
                            def newEnvContent = "REACT_APP_API_BASE_URL=http://${env.BACKEND_IP}:8080/\n"
                            writeFile(file: envFilePath, text: newEnvContent)
                            echo "Updated .env content: ${newEnvContent}" 
                        }
                    }
                }




        stage('Build Frontend') {
            steps {
                dir("frontend") {
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }


        stage('Build Backend') {
            steps {
                script {
                    env.PATH = "${GRADLE_BIN}:${env.PATH}"
                    sh 'gradle build -x test --no-daemon'
                }
            }
        }


        stage('Run Ansible Playbook') {
    steps {
        dir("TerraformAWS/Ansible") {
            script {
                sshagent (credentials: ['my_ssh_key']) {
                    sh """
                        ansible-playbook -i inventory.yml playbook.yml \
                        --extra-vars "database_ip=${DATABASE_IP} frontend_ip=${FRONTEND_IP} backend_ip=${BACKEND_IP}"
                    """
                }
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

    }
}
