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
        git pull
        cd ../
    else
        URL="https://journai:noway123@github.com/journai/$i.git"
        git clone $URL
    fi
done
# docker build . --tag development && cd ..
# docker run -p 3000:3000 -t -i --mount type=bind,src=$(cd "$(dirname "$0")"; pwd),dst=/home/Journai development /bin/bash
