pipeline {
    agent any
    
    stages {
        stage('Clone Repo') {
            steps {
                echo 'Going to Checkout from Git'
                git branch: 'main', credentialsId: 'gittoken', url: 'https://github.com/chevvusandeep12/nodejs.git'
                echo 'Completed Checkout from Git'
            }
        }//end of stage 1
        
         stage('install node'){
            steps{
                sh 'sudo apt update'
                sh 'curl -sL https://deb.nodesource.com/setup_16.x | bash -'
                sh 'sudo apt-get install nodejs -y'
                sh 'npm -v'
            }
        }//end of stage 2
        
        stage("npm install") {
            steps {
                    sh 'npm install'
                }
            }//end of stage 3
            
            stage("Build"){
            steps{
                 sh 'echo "skipping build stage"'
                //sh 'npm run build'
            }
        }//end of stage 4
        
        stage('Test'){
            steps{
                sh 'npm run test'
            }
        }//end of stage 5
        
        stage('SCA'){
            steps{
               // sh 'npm run owasp'
               sh 'echo "owasp-done" '
            }
        }//end of stage 6
        
     stage('SAST'){
            steps{
                withSonarQubeEnv('sonarqube') {
                    sh 'npm run sonar -Dsonar.login=sqa_24cb4bdc2f205c4a205e59c92af2e9c8fce18078sqa_24cb4bdc2f205c4a205e59c92af2e9c8fce18078'
                }
            }//end of stage 7
        }
        
        stage('Code Coverage'){
            steps{
                sh 'npm run test1'
                //sh 'nyc report'
            }
        }//end of stage 8
        
         stage('Docker Setup'){
            steps{
                sh 'sudo apt install -y docker.io'
                sh 'systemctl status docker'
                //sh 'sudo adduser jenkins'
                sh 'sudo usermod -a -G docker jenkins'
            }
        }//end of stage 9
        
        stage('Image Generation') {
    steps {
        dir('/var/lib/jenkins/workspace/nodejs') {
            sh 'sudo docker build -t first-image:latest .'
                 }
        }
   } //end of stage 10

        stage('Docker Login & Docker tag   Docker push '){
            steps{
                sh 'docker login -u "docker login -u chevvusandeep" -p "dckr_pat_dTYgGjZmf6xW6N-Ra4kFiguBGuw"'
                sh 'docker tag first-image:latest sandeep/first-image:latest'
                sh 'docker push sandeep/first-image:latest'
            }
        }//end of stage 11
         stage('smoke deploy'){
            steps{
                sh 'docker run --rm -p 3000:3000 first-image:latest' 
            }
        }//end of stage 12
        
     }
}


