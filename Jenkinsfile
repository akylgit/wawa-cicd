pipeline {
    agent any

    tools {
        git 'Default'
    }

    environment {
        ANSIBLE_INVENTORY = 'inventory.ini'
        ANSIBLE_PLAYBOOK = 'ansible/playbook.yaml'
    }

    stages {
        stage('Pre-deploy: Test SSH connectivity') {
            steps {
                sh "ansible -i ${ANSIBLE_INVENTORY} all -m ping"
            }
        }

        stage('Deploy') {
            steps {
                sh "ansible-playbook -i ${ANSIBLE_INVENTORY} ${ANSIBLE_PLAYBOOK}"
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

