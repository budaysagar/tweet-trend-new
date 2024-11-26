pipeline{
    agent{
        label "Maven-builds"
    }
    stages{
      stage('build source code'){
        steps{
            sh 'mvn clean install'
        }
      }
    }
}