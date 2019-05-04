#!/bin/bash
while true
do
  if [ ! -z "$STATUS" ]; then
        if [ $STATUS -eq 201 ] || [ $STATUS -eq 200 ];then
  	     break
	fi
  fi
  if [ -z "$2" ]; then
	  url="http://xjsonserver01.herokuapp.com/offline/""$NUM"
    	  STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X PUT --data "{\"device\":\"$DEVICE\"}" "$url")
	    else
	    	  times=$(grep -oP 'time=...........' log.txt | tail -1| cut -f2 -d '=' )
		  	  echo $times
			  url="http://xjsonserver01.herokuapp.com/online/""$NUM"
			  	  STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X PUT --data "{\"key\":\"$1\",\"link\":\"$2\",\"device\":\"$DEVICE\",\"times\":\"$times\"}" "$url")
				  sleep 1
			  	  STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X PUT --data "{\"key\":\"$1\",\"link\":\"$2\",\"device\":\"$DEVICE\",\"times\":\"$times\"}" "$url")


				  #	  STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "[{\"key\":\"$1\",\"link\":\"$2\",\"device\":\"$3\"}]" "http://myjsonserver-winiss.1d35.starter-us-east-1.openshiftapps.com/online/$4")
				    fi
				      if [ $STATUS -eq 201 ] || [ $STATUS -eq 200 ]; then
				          echo " All done!"
					      break
				      elif [ $STATUS -eq 404 ]; then
				        echo "Got $STATUS :( Not done yet..."
			  	        STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"key\":\"$1\",\"link\":\"$2\",\"device\":\"$DEVICE\",\"times\":\"$times\"}" "http://xjsonserver01.herokuapp.com/online/")
				       else
					  echo "Got $STATUS :( Not done yet..."
				        fi
					 sleep 1
done

