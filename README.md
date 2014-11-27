ntipa-jbilling
==============



docker-ntipa-base
=================

### To build:
	Spostarsi nella directory e lanciare il comando
    sudo docker build -t tornabene/ntipa-jbilling .

### To run:

    sudo docker pull tornabene/ntipa-jbilling
    sudo docker run -t -i --name ntipa-base -p 8022:22 -p 8080:8080 tornabene/ntipa-jbilling
    sudo docker run -d --name ntipa-base -p 8022:22 -p 8080:8080 tornabene/ntipa-jbilling
    
    
    