DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
if [ "$#" -eq 1 ]; then
    DIRECTORY=$1
fi
if [ ! -d $DIRECTORY ]; then  
    mkdir -p $DIRECTORY
fi
cd $DIRECTORY 
declare -a REPOS=("journai-authentication" "journai-entries" "journai-frontend" "journai-reminders" "journai-reporting" "journai-development")
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
done
cd journai-development
docker build . --tag development
docker run -p 1000:1000 -p 2000:2000 -p 3000:3000 -p 4000:4000 -p 5000:5000 -t -i --mount type=bind,src=$(cd "$(dirname "$0")"; pwd)/../,dst=/home/Journai development
cd ..
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
