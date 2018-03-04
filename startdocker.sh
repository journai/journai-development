DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
if [ "$#" -eq 1 ]; then
    DIRECTORY=$1
fi
if [ ! -d $DIRECTORY ]; then  
    mkdir -p $DIRECTORY
fi
cd $DIRECTORY 
declare -a REPOS=("journai-authentication" "journai-entries" "journai-frontend" "journai-reminders" "journai-reporting" "journai-development")
declare -a PORTS=("1000" "2000" "3000" "4000" "5000")
for i in "${!PORTS[@]}"
do
    SERVICE=${REPOS[i]}
    PORT=${PORTS[i]}
    docker rm $(docker stop $(docker ps -a -q --filter ancestor=$SERVICE --format="{{.ID}}"))
    if [ -d $SERVICE ]; then 
        cd $SERVICE
        rm -r logs
        mkdir logs
        git pull development
        git checkout -b development
        cd ../
    else
        URL="https://journai:noway123@github.com/journai/$SERVICE.git"
        git clone $URL
    fi
    cd journai-development
    docker build --build-arg port=$PORT --build-arg service=$SERVICE . --tag $SERVICE
    docker run -p $PORT:$PORT -td -i --mount type=bind,src=$(cd "$(dirname "$0")"; pwd)/../$SERVICE,dst=/home/Journai/$SERVICE $SERVICE
    cd ../
done
printf "\n\nReady for development :)\n\n" 
read -p "Press 'enter' to commit changes. Ctrl+c to cancel"
printf "\n" 
for i in "${REPOS[@]}"
do
    if [ -d $i ]; then 
        cd $i
        git checkout -b "development"
        git add .
        git commit -m "dev work"
        git push -u origin development
        cd ../
    fi
done

printf "\n\nDone with development :)\n\n" 
