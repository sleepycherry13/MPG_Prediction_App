# Load the required package
library(rsconnect)

# Set your account information (already done in your previous step)
rsconnect::setAccountInfo(
  name = 'riya13',
  token = '9909E326A3023345C5B1E0C157F117C2',
  secret = 'R6KsCJvA6H19dhignseHpWHL84hp90T5ozhm+b/9'  # Your actual secret
)

# Set your working directory to where your app is located
setwd("/Users/riyatanisha/MPG Prediction App")  # This is already your working directory

# Deploy your app
rsconnect::deployApp()



