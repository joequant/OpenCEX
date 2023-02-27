#!/bin/bash

while test $# -gt 0
do
    case "$1" in
        --batch) echo "Batch mode"
		 MODE=batch
            ;;
    esac
    shift
done

prompt() {
    if [ "$MODE" != "batch" ] ; then
	read -p "$1"
    fi
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ -z "${APP_DEPLOY}" ]]; then
    APP_DEPLOY=$SCRIPT_DIR
fi

mkdir /app/opencex -p
cd /app/opencex || exit
GITHUB_ROOT="${GITHUB_ROOT:-Polygant}"

git clone https://github.com/${GITHUB_ROOT}/OpenCEX-backend.git ./backend
git clone https://github.com/${GITHUB_ROOT}/OpenCEX-frontend.git ./frontend
git clone https://github.com/${GITHUB_ROOT}/OpenCEX-static.git ./nuxt


echo "`cat <<YOLLOPUKKI


 000000\                                 000000\  00000000\ 00\   00\ 
00  __00\                               00  __00\ 00  _____|00 |  00 |
00 /  00 | 000000\   000000\  0000000\  00 /  \__|00 |      \00\ 00  |
00 |  00 |00  __00\ 00  __00\ 00  __00\ 00 |      00000\     \0000  / 
00 |  00 |00 /  00 |00000000 |00 |  00 |00 |      00  __|    00  00<  
00 |  00 |00 |  00 |00   ____|00 |  00 |00 |  00\ 00 |      00  /\00\ 
 000000  |0000000  |\0000000\ 00 |  00 |\000000  |00000000\ 00 /  00 |
 \______/ 00  ____/  \_______|\__|  \__| \______/ \________|\__|  \__|
          00 |                                                        
          00 |                                                        
          \__|  

Hello! This is OpenCEX Setup. Please enter parameters for your exchange.
If you make a mistake when entering a parameter, don't worry, 
at the end of each parameter block you will have the opportunity 
to re-enter the parameters.

* is for the required field. 
		  
YOLLOPUKKI`"

prompt "Press enter to continue"

cd /app/opencex/backend || exit
FILE=/app/opencex/backend/.env
if test ! -f "$FILE"; then

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

envsubst < /app/opencex/backend/.env.template > /app/opencex/backend/.env

fi

source /app/opencex/backend/.env
set -a
cd /app/opencex/frontend || exit
FILE=/app/opencex/frontend/src/local_config

if test ! -f "$FILE"; then
envsubst < /app/opencex/frontend/src/example.local_config.js > /app/opencex/frontend/src/local_config
### save to env

cat << EOF >> /app/opencex/backend/.env


#opencex frontend values
RECAPTCHA=$RECAPTCHA
TELEGRAM=$TELEGRAM
TG_NEWS=$TG_NEWS
SUPPORT_EMAIL=$SUPPORT_EMAIL
FACEBOOK=$FACEBOOK
TWITTER=$TWITTER
LINKEDIN=$LINKEDIN
EOF

fi

##################
# START BUILDING!
##################


# build front
mkdir -p /app/opencex/frontend/deploy/
cp ${APP_DEPLOY}/frontend/Dockerfile /app/opencex/frontend/deploy/Dockerfile
cp ${APP_DEPLOY}/frontend/default.conf /app/opencex/frontend/deploy/default.conf
cp ${APP_DEPLOY}/frontend/nginx.conf /app/opencex/frontend/deploy/nginx.conf
sed -i "s/ADMIN_BASE_URL/$ADMIN_BASE_URL/g" /app/opencex/frontend/deploy/default.conf
sed -i "s/DOMAIN/$DOMAIN/g" /app/opencex/frontend/deploy/default.conf
docker build -t frontend -f deploy/Dockerfile .

# build nuxt
mkdir -p /app/opencex/nuxt/deploy/
cd /app/opencex/nuxt || exit
cp ${APP_DEPLOY}/nuxt/.env.template /app/opencex/nuxt/
cp ${APP_DEPLOY}/nuxt/Dockerfile /app/opencex/nuxt/deploy/Dockerfile
envsubst < /app/opencex/nuxt/.env.template > /app/opencex/nuxt/.env
docker build -t nuxt -f deploy/Dockerfile .

# build backend
cd /app/opencex/backend/ || exit
chmod +x /app/opencex/backend/manage.py
docker build -t opencex .



### install Caddy

mkdir /app/opencex -p
cd /app/opencex || exit
mkdir caddy_data postgresql_data redis_data rabbitmq_data rabbitmq_logs bitcoind_data -p
chmod 777 caddy_data postgresql_data redis_data rabbitmq_data rabbitmq_logs bitcoind_data
docker network create caddy

cat << EOF > docker-compose.yml
version: "3.7"
services:
    opencex:
     container_name: opencex
     image: opencex:latest
     command: gunicorn  exchange.wsgi:application   -b 0.0.0.0:8080 -w 2 --access-logfile - --error-logfile -
#     entrypoint: tail -f /dev/null
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy

    opencexwss:
     container_name: opencexwss
     image: opencex:latest
     command: daphne -b 0.0.0.0 exchange.asgi:application
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy

    opencexcel:
     container_name: opencexcel
     image: opencex:latest
     command: celery -A exchange worker -l info -n general -B -s /tmp/cebeat.db -X btc,eth_new_blocks,eth_deposits,eth_payouts,eth_check_balances,eth_accumulations,erc20_accumulations,eth_send_gas
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy

    opencex-matching:
      container_name: opencex-matching
      image: opencex:latest
      command: python bin/stack.py
      restart: always
      volumes:
        - /app/opencex/backend:/app
      networks:
        - caddy
    opencex-btc:
     container_name: opencex-btc
     image: opencex:latest
     command: /app/manage.py btcworker
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-eth-blocks:
     container_name: opencex-eth-blocks
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_new_blocks -Q eth_new_blocks -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-eth-deposits:
     container_name: opencex-eth-deposits
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_deposits -Q eth_deposits -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-eth-payouts:
     container_name: opencex-eth-payouts
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_payouts -Q eth_payouts -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-eth-balances:
     container_name: opencex-eth-balances
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_check_balances -Q eth_check_balances -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-eth-accumulations:
     container_name: opencex-eth-accumulations
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_accumulations -Q eth_accumulations -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-erc-accumulations:
     container_name: opencex-erc-accumulations
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n erc20_accumulations -Q erc20_accumulations -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy
    opencex-eth-gas:
     container_name: opencex-eth-gas
     image: opencex:latest
     command: bash -c "celery -A exchange worker -l info -n eth_send_gas -Q eth_send_gas -c 1 "
     restart: always
     volumes:
       - /app/opencex/backend:/app
     networks:
       - caddy

    frontend:
     image: frontend:latest
     container_name: frontend
     restart: always
     volumes:
     - /app/opencex/backend:/app
     networks:
     - caddy
     labels:
      caddy: $DOMAIN
      caddy.reverse_proxy: "{{upstreams 80}}"
    nuxt:
     image: nuxt:latest
     container_name: nuxt
     restart: always
     networks:
     - caddy
    caddy:
      image: lucaslorentz/caddy-docker-proxy:latest
      restart: always
      ports:
        - 80:80
        - 443:443
      environment:
        - CADDY_INGRESS_NETWORKS=caddy
      networks:
        - caddy
      volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        - ./caddy_data:/data
      restart: always

    postgresql:
     container_name: postgresql
     hostname: postgresql
     restart: always
     image: postgres:latest
     shm_size: 1g
     volumes:
        - ./postgresql_data:/var/lib/postgresql/data
     environment:
       POSTGRES_USER: "$DB_USER"
       POSTGRES_PASSWORD: "$DB_PASS"
       POSTGRES_DB: "$DB_NAME"
     networks:
      - caddy

    redis:
     container_name: redis
     restart: always
     image: redis:latest
     volumes:
         - ./redis_data:/data
     entrypoint: redis-server
     networks:
       - caddy
    rabbitmq:
     hostname: rabbitmq
     container_name: rabbitmq
     restart: always
     image: rabbitmq:3.9.22-management
     volumes:
         - ./rabbitmq_data/:/var/lib/rabbitmq/
         - ./rabbitmq_logs/:/var/log/rabbitmq/
     environment:
         RABBITMQ_DEFAULT_USER: $AMQP_USER
         RABBITMQ_DEFAULT_PASS: $AMQP_PASS
         RABBITMQ_DEFAULT_VHOST: /
     networks:
       - caddy
     labels:
       caddy: $RMQDOMAIN
       caddy.reverse_proxy: "{{upstreams http 15672}}"
    bitcoind:
      container_name: bitcoind
      restart: always
      image: kylemanna/bitcoind
      volumes:
      - ./bitcoind_data/:/bitcoin/.bitcoin/
      networks:
      - caddy
networks:
  caddy:
    external: true
EOF

docker-compose up -d

docker stop opencexcel opencexwss
sleep 5;
docker exec -it opencex python ./manage.py migrate
docker exec -it opencex python ./manage.py collectstatic
docker-compose up -d



cd /app/opencex || exit
docker-compose stop
cat << EOF > /app/opencex/bitcoind_data/bitcoin.conf
rpcuser=$BTC_NODE_USER
rpcpassword=$BTC_NODE_PASS
rpcallowip=0.0.0.0/0
rpcbind=0.0.0.0
rpcport=$BTC_NODE_PORT
prune=20000
wallet=/bitcoin/.bitcoin/opencex

EOF
docker-compose up -d
sleep 30;
docker exec -it bitcoind bitcoin-cli -named createwallet wallet_name="opencex" descriptors=false
docker restart bitcoind
sleep 30;
docker exec -it opencex python wizard.py
cd /app/opencex || exit
docker-compose stop
docker-compose up -d



# cleanup
# cd /app/opencex && docker-compose down
# rm -rf /app
# docker system prune -a
