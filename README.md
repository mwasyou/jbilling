jBilling Docker
==============

### To build:
    sudo docker build -t guigo2k/jbilling .

### To run:

    sudo docker pull guigo2k/jbilling
    sudo docker run -t -i --name jbilling -p 8022:22 -p 8080:8080 guigo2k/jbilling
    sudo docker run -d --name jbilling -p 8022:22 -p 8080:8080 guigo2k/jbilling
    
    
    