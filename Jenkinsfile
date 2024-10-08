pipeline {
    agent any
    
    tools {
    jdk 'jdk11'    
    }

    environment {
        // Load the .env file using PowerShell
        LOADED_ENV = powershell(returnStdout: true, script: './load_env.ps1').trim()
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out the latest code...'
                // Checkout the code from the repo
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/pawanr-98/Web-application-microservices.git'
            }
        } 
    }
}      
