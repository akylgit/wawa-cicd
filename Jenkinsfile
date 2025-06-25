pipeline {
    agent any

    environment {
        ANSIBLE_INVENTORY = 'inventory.ini'
        ANSIBLE_PLAYBOOK = 'ansible/playbook.yaml'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your repo
                git url: 'https://github.com/akylgit/wawa-cicd.git', credentialsId: 'github-token'
            }
        }

        stage('Pre-deploy: Test SSH connectivity') {
            steps {
                sshagent(['devops-key']) {
                    sh 'ansible -i ${ANSIBLE_INVENTORY} all -m ping'
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(['devops-key']) {
                    sh "ansible-playbook -i ${ANSIBLE_INVENTORY} ${ANSIBLE_PLAYBOOK}"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment succeeded! 🎉'
        }
        failure {
            echo 'Deployment failed. Check logs for errors.'
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}

