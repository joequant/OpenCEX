#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir /app/opencex -p
cd /app/opencex || exit
git clone https://github.com/Polygant/OpenCEX-backend.git ./backend
git clone https://github.com/Polygant/OpenCEX-frontend.git ./frontend
git clone https://github.com/Polygant/OpenCEX-static.git ./nuxt


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

read -p "Press enter to continue"

cd /app/opencex/backend || exit
FILE=/app/opencex/backend/.env
if test ! -f "$FILE"; then
source $SCRIPT_DIR/generate_env.sh
cp $SCRIPT_DIR/config.env /app/opencex/backend/.env
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
cp /app/deploy/frontend/Dockerfile /app/opencex/frontend/deploy/Dockerfile
cp /app/deploy/frontend/default.conf /app/opencex/frontend/deploy/default.conf
cp /app/deploy/frontend/nginx.conf /app/opencex/frontend/deploy/nginx.conf
sed -i "s/ADMIN_BASE_URL/$ADMIN_BASE_URL/g" /app/opencex/frontend/deploy/default.conf
sed -i "s/DOMAIN/$DOMAIN/g" /app/opencex/frontend/deploy/default.conf
docker build -t frontend -f deploy/Dockerfile .

# build nuxt
mkdir -p /app/opencex/nuxt/deploy/
cd /app/opencex/nuxt || exit
cp /app/deploy/nuxt/.env.template /app/opencex/nuxt/
cp /app/deploy/nuxt/Dockerfile /app/opencex/nuxt/deploy/Dockerfile
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

docker compose up -d

docker stop opencexcel opencexwss
sleep 5;
docker exec -it opencex python ./manage.py migrate
docker exec -it opencex python ./manage.py collectstatic
docker compose up -d



cd /app/opencex || exit
docker compose stop
cat << EOF > /app/opencex/bitcoind_data/bitcoin.conf
rpcuser=$BTC_NODE_USER
rpcpassword=$BTC_NODE_PASS
rpcallowip=0.0.0.0/0
rpcbind=0.0.0.0
rpcport=$BTC_NODE_PORT
prune=20000
wallet=/bitcoin/.bitcoin/opencex

EOF
docker compose up -d
sleep 30;
docker exec -it bitcoind bitcoin-cli -named createwallet wallet_name="opencex" descriptors=false
docker restart bitcoind
sleep 30;
docker exec -it opencex python wizard.py
cd /app/opencex || exit
docker compose stop
docker compose up -d



# cleanup
# cd /app/opencex && docker compose down
# rm -rf /app
# docker system prune -a
