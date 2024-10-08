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
       stage('Build catalogue-service') {
            when {
                changeset "backend with eclipse/catalogue-service/**"
            }
            steps {
                dir('backend with eclipse/catalogue-service') {
                echo 'Building catalogue-service'
                bat 'mvn clean package'
                }    
            }
        }
        stage('Deploy catalogue-service') {
            when {
                changeset "backend with eclipse/catalogue-service/**"
            }
            steps {
                script {
                    // Navigate to the microservice directory and find the .jar file dynamically
                    def jarFile = bat(script: 'for /f "tokens=*" %%i in (\'dir /B "backend with eclipse\\catalogue-service\\target\\*.jar"\') do echo %%i', returnStdout: true).trim()

                    echo "Deploying ${jarFile}"

                    // Run the Java command to start the .jar file
                    bat "java -jar \"backend with eclipse\\catalogue-service\\target\\${jarFile}\""
                }
            }
        }
    }
}      
