cd journai-authentication
nohup npm start & 
cd journai-frontend 
nohup npm start &
# cd journai-entries && npm start && cd ../
# cd journai-reporting && npm start && cd ../
# cd journai-reminders && npm start && cd ../../

tail -F -n0 /etc/hosts