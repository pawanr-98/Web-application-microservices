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
                     // Use PowerShell to find the .jar file and store it in a variable
                    def jarFile = powershell(script: '''
                        $jar = Get-ChildItem -Path "backend with eclipse\\catalogue-service\\target\\" -Filter "*.jar" | Select-Object -ExpandProperty FullName
                        Write-Output $jar
                    ''', returnStdout: true).trim()

                    echo "Deploying ${jarFile}"
                    
                    // Create a .bat file dynamically to run the .jar file
                    writeFile file: 'run_catalogue_service.bat', text: """
                        @echo off
                        set JAR_PATH="${jarFile}" >> service_log.txt
                        start /B java -jar %JAR_PATH% >> service_log.txt 2>&
                    """

                    // Run the .bat file
                    bat "run_catalogue_service.bat"
                }
            }
        }
    }
}      

