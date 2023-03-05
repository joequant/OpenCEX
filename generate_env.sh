#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 1 OF 8. PROJECT VARIABLES
===========================================================

PROJECT_NAME* - name of your exchange
DOMAIN* - base domain of your exchange
ADMIN_BASE_URL* - URL of the admin panel, added to DOMAIN
ADMIN_USER* - email of the user that would have admin rights 
ADMIN_MASTERPASS* - master password, used to create 
   balance accrual/debit transactions
SUPPORT_EMAIL - email address of support

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "PROJECT_NAME* (i.e. SuperExchange): "
read PROJECT_NAME
export PROJECT_NAME

echo -n "DOMAIN* (i.e. test.com): "
read DOMAIN
export DOMAIN

echo -n "ADMIN_BASE_URL* (i.e: admin): "
read ADMIN_BASE_URL
export ADMIN_BASE_URL

echo -n "ADMIN_USER* (i.e: admin@exchange.net): "
read ADMIN_USER
export ADMIN_USER

echo -n "ADMIN_MASTERPASS*: "
read ADMIN_MASTERPASS
export ADMIN_MASTERPASS

echo -n "SUPPORT_EMAIL: "
read SUPPORT_EMAIL
export SUPPORT_EMAIL

#TELEGRAM - telegram chat URL (i.e. opencex)
#FACEBOOK - facebook page URL
#TWITTER - twitter page URL
#LINKEDIN - linkedin page URL

TELEGRAM=opencex
FACEBOOK=polygant
TWITTER=polygant
LINKEDIN=polygant

export TELEGRAM
export FACEBOOK
export TWITTER
export LINKEDIN

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 2 OF 8. COMMON SERVICES
===========================================================

RECAPTCHA* - Google Captcha site key
RECAPTCHA_SECRET* - Google Captcha secret key
TELEGRAM_CHAT_ID - used to send alerts to Telegram
TELEGRAM_ALERTS_CHAT_ID - monitoring collection and the state of collectors
TELEGRAM_BOT_TOKEN - token for the Alert bot

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "RECAPTCHA*: "
read RECAPTCHA
export RECAPTCHA

echo -n "RECAPTCHA_SECRET*: "
read RECAPTCHA_SECRET
export RECAPTCHA_SECRET

echo -n "TELEGRAM_CHAT_ID: "
read TELEGRAM_CHAT_ID
export TELEGRAM_CHAT_ID

echo -n "TELEGRAM_ALERTS_CHAT_ID: "
read TELEGRAM_ALERTS_CHAT_ID
export TELEGRAM_ALERTS_CHAT_ID

echo -n "TELEGRAM_BOT_TOKEN: "
read TELEGRAM_BOT_TOKEN
export TELEGRAM_BOT_TOKEN

# CAPTCHA_ALLOWED_IP_MASK=172\.\d{1,3}\.\d{1,3}\.\d{1,3}
# export CAPTCHA_ALLOWED_IP_MASK

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 3 OF 8. BLOCKCHAIN SERVICES
===========================================================

INFURA_API_KEY* - used for the ETH blockchain data
INFURA_API_SECRET* - used for the ETH blockchain data

ETHERSCAN_KEY* - used for the ETH blockchain data

CRYPTOCOMPARE_API_KEY* - used for the market data

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "INFURA_API_KEY*: "
read INFURA_API_KEY
export INFURA_API_KEY

echo -n "INFURA_API_SECRET*: "
read INFURA_API_SECRET
export INFURA_API_SECRET

echo -n "ETHERSCAN_KEY*: "
read ETHERSCAN_KEY
export ETHERSCAN_KEY

echo -n "CRYPTOCOMPARE_API_KEY*: "
read CRYPTOCOMPARE_API_KEY
export CRYPTOCOMPARE_API_KEY

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 4 OF 8. SAFE ADDRESSES
===========================================================

BTC_SAFE_ADDR* - bitcoin address. All BTC deposits go there
ETH_SAFE_ADDR* - ethereum address. All ETH and ERC-20 deposits go there

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "BTC_SAFE_ADDR*: "
read BTC_SAFE_ADDR
export BTC_SAFE_ADDR

echo -n "ETH_SAFE_ADDR*: "
read ETH_SAFE_ADDR
export ETH_SAFE_ADDR

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 5 OF 8. EMAIL SERVICE
===========================================================

Used for sending notifications and alerts.

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "EMAIL_HOST*: "
read EMAIL_HOST
export EMAIL_HOST

echo -n "EMAIL_HOST_USER*: "
read EMAIL_HOST_USER
export EMAIL_HOST_USER

echo -n "EMAIL_HOST_PASSWORD*: "
read EMAIL_HOST_PASSWORD
export EMAIL_HOST_PASSWORD

echo -n "EMAIL_PORT*: "
read EMAIL_PORT
export EMAIL_PORT

echo -n "EMAIL_USE_TLS* (True/False): "
read EMAIL_USE_TLS
export EMAIL_USE_TLS

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 6 OF 8. SMS SERVICE TWILIO (optional)
===========================================================

Used for sending notifications and alerts. 
You can set IS_SMS_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "IS_SMS_ENABLED (True/False): "
read IS_SMS_ENABLED
export IS_SMS_ENABLED

if [ "$IS_SMS_ENABLED" = "True" ]; then
echo -n "TWILIO_ACCOUNT_SID: "
read TWILIO_ACCOUNT_SID
export TWILIO_ACCOUNT_SID

echo -n "TWILIO_AUTH_TOKEN: "
read TWILIO_AUTH_TOKEN
export TWILIO_AUTH_TOKEN

echo -n "TWILIO_VERIFY_SID: "
read TWILIO_VERIFY_SID
export TWILIO_VERIFY_SID

echo -n "TWILIO_PHONE: "
read TWILIO_PHONE
export TWILIO_PHONE
echo ""
fi

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done

echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 7 OF 8. KYC PROVIDER SUMSUB (OPTIONAL)
===========================================================

Used for KYC. 
You can set IS_KYC_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "IS_KYC_ENABLED (True/False): "
read IS_KYC_ENABLED
export IS_KYC_ENABLED

if [ "$IS_KYC_ENABLED" = "True" ]; then
echo -n "SUMSUB_SECRET_KEY: "
read SUMSUB_SECRET_KEY
export SUMSUB_SECRET_KEY

echo -n "SUMSUB_APP_TOKEN: "
read SUMSUB_APP_TOKEN
export SUMSUB_APP_TOKEN

echo -n "SUMSUM_CALLBACK_VALIDATION_SECRET: "
read SUMSUM_CALLBACK_VALIDATION_SECRET
export SUMSUM_CALLBACK_VALIDATION_SECRET
fi

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done


echo "`cat <<YOLLOPUKKI

===========================================================
     STEP 8 OF 8. KYT PROVIDER SCORECHAIN (OPTIONAL)
===========================================================

Used for KYT. 
You can set IS_KYT_ENABLED: False or leave it blank
to turn it off.

-----------------------------------------------------------
YOLLOPUKKI`"

while true; do

echo -n "IS_KYT_ENABLED (True/False): "
read IS_KYT_ENABLED
export IS_KYT_ENABLED

if [ "$IS_KYT_ENABLED" = "True" ]; then

echo -n "SCORECHAIN_BITCOIN_TOKEN: "
read SCORECHAIN_BITCOIN_TOKEN
export SCORECHAIN_BITCOIN_TOKEN

echo -n "SCORECHAIN_ETHEREUM_TOKEN: "
read SCORECHAIN_ETHEREUM_TOKEN
export SCORECHAIN_ETHEREUM_TOKEN

fi

echo "-----------------------------------------------------------"
    read -p "IS EVERYTHING CORRECT? (y or n)" YESORNO
    case $YESORNO in
        [Yy]* ) break;;
        [Nn]* ) echo "Re-enter the parameters.";;
        * ) break;;
    esac
done


#echo "Instance name"
INSTANCE_NAME='opencex'
export INSTANCE_NAME

#echo "Postgres credentials - user, database name, password, server address and port"
DB_NAME=opencex
DB_USER=opencex
DB_PASS=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
DB_HOST=postgresql
DB_PORT=5432
export DB_NAME
export DB_USER
export DB_PASS
export DB_HOST
export DB_PORT

#echo "RabbitMQ credentials - user, password, server address and port"
AMQP_USER=opencex
AMQP_PASS=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
AMQP_HOST=rabbitmq
AMQP_PORT=5672
export AMQP_USER
export AMQP_PASS
export AMQP_HOST
export AMQP_PORT

#echo "Bitcoin node credentials - user, password, server address and port"
BTC_NODE_USER=opencex
BTC_NODE_PASS=$(< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c12)
BTC_NODE_PORT=8332
BTC_NODE_HOST=bitcoind
export BTC_NODE_USER
export BTC_NODE_PASS
export BTC_NODE_PORT
export BTC_NODE_HOST

#echo "Redis credentials - server address and port"
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASS=
export REDIS_HOST
export REDIS_PORT
export REDIS_PASS

#echo "the address where bots can directly access the django instance"
BOTS_API_BASE_URL=http://opencex:8080
export BOTS_API_BASE_URL

# key for encrypting private keys in the database (generated automatically)
CRYPTO_KEY=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;)
export CRYPTO_KEY

# bot user password
BOT_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;)
export BOT_PASSWORD

if [ -f $SCRIPT_DIR/config.env ] ; then
   echo "Move file to $SCRIPT_DIR/config.env.bak"
   mv -f $SCRIPT_DIR/config.env $SCRIPT_DIR/config.env.bak
fi
envsubst < /app/opencex/backend/.env.template > $SCRIPT_DIR/config.env
echo "Environment file created at $SCRIPT_DIR/config.env"
