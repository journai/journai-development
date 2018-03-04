DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
if [ "$#" -eq 1 ]; then
    DIRECTORY=$1
fi
if [ ! -d $DIRECTORY ]; then  
    mkdir -p $DIRECTORY
fi
cd $DIRECTORY 
declare -a REPOS=("journai-authentication" "journai-entries" "journai-frontend" "journai-reminders" "journai-reporting" "journai-development")
declare -A PORTS=( ["journai-authentication"]="1000" ["journai-entries"]="2000" ["journai-reminders"]="3000" ["journai-reporting"]="4000" ["journai-development"]="5000")
for i in "${REPOS[@]}"
do
    if [ -d $i ]; then 
        cd $i
        mkdir logs
        git pull development
        git checkout -b development
        cd ../
    else
        URL="https://journai:noway123@github.com/journai/$i.git"
        git clone $URL
    fi
    docker build . --tag $i
    docker run -p ${REPOS[$i]}:${REPOS[$i]} -t -i --mount type=bind,src=$(cd "$(dirname "$0")"; pwd)/../,dst=/home/Journai/$i --build-arg port=${REPOS[$i]} service=$i $i
done

for i in "${REPOS[@]}"
do
    if [ -d $i ]; then 
        cd $i
        rm -r logs/
        git checkout -b "development"
        git add .
        git commit -m "dev work"
        git push -u origin development
        cd ../
    fi
done

printf "\n\nDone with development :)\n\n" 
