pipeline{
    agent{
        label "Maven-builds"
    }
    stages{
        stage("clone source code"){
            steps{
                git branch: 'main', url: 'https://github.com/budaysagar/tweet-trend-new.git'
            }
        }
    }
}