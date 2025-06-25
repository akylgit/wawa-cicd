pipeline {
    agent any

    environment {
        // Define environment variables if needed
        ANSIBLE_INVENTORY = 'inventory.ini'
        ANSIBLE_PLAYBOOK = 'ansible/playbook.yaml'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your repo
                git 'https://github.com/your-username/wawa-cicd.git'
            }
        }

        stage('Pre-deploy: Test SSH connectivity') {
            steps {
                // Test SSH connection to all hosts before deploying
                sh "ansible -i ${ANSIBLE_INVENTORY} all -m ping"
            }
        }

        stage('Deploy') {
            steps {
                // Run your Ansible playbook to deploy
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
            // You can add notifications here (Slack, email, etc.)
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}

