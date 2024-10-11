pipeline {
    agent { label 'jenks-node' }

    environment {
        GITHUB_REPO = 'https://github.com/andervafla/java_deploy.git' 
        FRONTEND_DIR = 'frontend'
        TERRAFORM_DIR = 'TerraformAWS'
        ANSIBLE_DIR = 'TerraformAWS/Ansible' 
        GRADLE_VERSION = '7.2' 
        GRADLE_HOME = "${env.WORKSPACE}/gradle"  
        GRADLE_BIN = "${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin" 
    }

    stages {
        // stage('Initialize Terraform') {
        //     steps {
        //         dir("${TERRAFORM_DIR}") {
        //             script {
        //                 sh 'terraform init'
        //             }
        //         }
        //     }
        // }

        // stage('Apply Terraform') {
        //     steps {
        //         dir("${TERRAFORM_DIR}") {
        //             sh 'terraform apply -auto-approve'
        //         }
        //     }
        // }

        // stage('Save Terraform Outputs') {
        //     steps {
        //         dir("${TERRAFORM_DIR}") { 
        //             sh 'terraform output -json > outputs.json'
        //         }
        //     }
        // }

        // stage('Show Terraform Outputs') {
        //     steps {
        //         dir("${TERRAFORM_DIR}") {
        //             sh 'cat outputs.json'
        //         }
        //     }
        // }

        stage('Install Ansible') {
            steps {
                script {
                    sh '''
                    sudo apt update
                    sudo apt install software-properties-common -y
                    sudo add-apt-repository --yes --update ppa:ansible/ansible
                    sudo apt install ansible -y
                    '''
                }
            }
        }

        stage('Show Ansible Version') {
            steps {
                sh 'ansible --version'
            }
        }

        stage('List Files in Root Directory') {
            steps {
                sh 'ls -la'
            }
        }

        stage('Download Gradle') {
            steps {
                script {
                    if (!fileExists("${GRADLE_BIN}/gradle")) {
                        echo "Downloading Gradle ${GRADLE_VERSION}..."
                        sh """
                        mkdir -p ${GRADLE_HOME}
                        wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P ${GRADLE_HOME}
                        unzip ${GRADLE_HOME}/gradle-${GRADLE_VERSION}-bin.zip -d ${GRADLE_HOME}
                        rm ${GRADLE_HOME}/gradle-${GRADLE_VERSION}-bin.zip
                        """
                    } else {
                        echo "Gradle ${GRADLE_VERSION} is already downloaded."
                    }
                }
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
                script {
                    env.PATH = "${GRADLE_BIN}:${env.PATH}"
                    sh 'gradle build -x test --no-daemon'
                }
            }
        }

//         stage('Create Ansible Vars') { 
//             steps {
//                 dir("${ANSIBLE_DIR}") {
//                     script {
//                         def outputFile = "${TERRAFORM_DIR}/outputs.json"
                        
//                         if (!fileExists(outputFile)) {
//                             error "File outputs.json does not exist!"
//                         }
                        
//                         def output = readJSON file: outputFile
//                         def varsContent = """
// ssh_key_path: /home/jenkins/workspace/java-pipeline/TerraformAWS/key/my_ssh_key
// frontend_ip: ${output.frontend_public_ip.value}
// backend_ip: ${output.backend_public_ip.value}
// database_ip: ${output.database_public_ip.value}
// """
//                         writeFile file: 'vars.yml', text: varsContent
                        
//                         echo readFile('vars.yml')
//                     }
//                 }
//             }
//         }

        stage('Run Ansible Playbook') {
            steps {
                dir("${ANSIBLE_DIR}") {
                    sh 'ansible-playbook playbook.yml'
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
            script {
                echo 'Pipeline failed. Attempting to destroy Terraform resources.'
                dir("${TERRAFORM_DIR}") {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
