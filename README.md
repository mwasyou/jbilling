ntipa-jbilling
==============



   sudo docker run -d --name postgres  -p 5432:5432   tornabene/docker-postgres 
  /bin/su postgres -c "createdb -O ntipa ntipa-jbilling" 
 
    sudo docker run -P -d --name ntipa-jbilling  --link postgres:postgresdb  scupiddu/ntipa-jbilling 
    
    
    