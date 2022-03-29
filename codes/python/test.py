import os
from datetime import datetime
from time import sleep

if __name__ == '__main__':

    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")

    print(current_time + " -> Program: " + str(os.getpid()) + " Initialized!")
    sleep(10)
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    print(current_time + " -> Program: " + str(os.getpid()) + " Finalized!")
