cd journai-authentication && npm start && cd ../
cd journai-frontend && npm start && cd ../
cd journai-entries && npm start && cd ../
cd journai-reporting && npm start && cd ../
cd journai-reminders && npm start && cd ../../

printf "\n\nReady for development :)\n\n" 

tail -F -n0 /etc/hosts