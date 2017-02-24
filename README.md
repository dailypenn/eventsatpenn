# Events@Penn
Events@Penn is back.

## Usage

### Development
Run `npm start` or `node app.js`

### Testing
Run `npm test` or `mocha test` to run tests. You must have mocha installed 
globally for this to work (`npm install -g mocha`).

### Deployment
Download the AWS Elastic Beanstalk CLI

    sudo pip install --upgrade --user awsebcli
    eb --version # check your install went okay

Deploy the app to the Events@Penn instance

    eb deploy

⚠️ If it is your first time deploying, it will ask you for credentials for the
AWS. There is a service account set up--just head to IAM on the AWS dashboard.