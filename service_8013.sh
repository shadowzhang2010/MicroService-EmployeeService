#!/bin/bash

PROG=MicroService-EmployeeService
APPPATH=/tpc/webapps/microservice/employee
JARNAME=MicroService-EmployeeService-1.0.0.jar
PIDFILE=$APPPATH/$PROG.8013.pid
cd $APPPATH

status() {
    if [ -f $PIDFILE ]; then  
        PID=$(cat $PIDFILE)  
        if [ ! -x /proc/${PID} ]; then  
            return 1  
        else  
            return 0  
        fi  
    else  
        return 1  
    fi  
}  
  
case "$1" in  
    start)  
        status  
        RETVAL=$?  
        if [ $RETVAL -eq 0 ]; then  
            echo "$PIDFILE exists, process is already running or crashed"  
            exit 1  
        fi  
          
        echo "Starting $PROG ..."  
		    nohup /tpc/jdk1.8/bin/java -Dserver.port=8013 -jar $APPPATH/$JARNAME -Dservice=$PROG >> $APPPATH/$PROG_8013.log 2>&1 & 
        RETVAL=$?  
        if [ $RETVAL -eq 0 ]; then  
            echo "$PROG is started"  
            echo $! > $PIDFILE  
            exit 0  
        else  
            echo "Stopping $PROG"  
            rm -f $PIDFILE  
            exit 1  
        fi  
        ;;  
    stop)  
        status  
        RETVAL=$?  
        if [ $RETVAL -eq 0 ]; then  
            echo "Shutting down $PROG"  
            kill `cat $PIDFILE`  
            RETVAL=$?  
            if [ $RETVAL -eq 0 ]; then  
                rm -f $PIDFILE  
            else  
                echo "Failed to stopping $PROG"  
            fi  
        fi  
        ;;  
    status)  
        status  
        RETVAL=$?  
        if [ $RETVAL -eq 0 ]; then  
            PID=$(cat $PIDFILE)  
            echo "$PROG is running ($PID)"  
        else  
            echo "$PROG is not running"  
        fi  
        ;;  
    restart)  
        $0 stop  
        $0 start  
        ;;  
    *)  
        echo "Usage: $0 {start|stop|restart|status}"  
        ;;  
esac 
