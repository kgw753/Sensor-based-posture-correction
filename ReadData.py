import FaBo9Axis_MPU9250
import time
import sys
 
from pypreprocessor import pypreprocessor
pypreprocessor.parse()
 
import pandas as pd
from IPython.display import display
 
from datetime import datetime
 
#define DEBUG
 
mpu9250 = FaBo9Axis_MPU9250.MPU9250()
 
dataFrame = pd.DataFrame(data=None, columns=["acc.x","acc.y","acc.z","gyro.x",
                                             "gyro.y","gyro.z","mag.x","mag.y","mag.z","datetime"])
dataFrameIndex = 0
 
savePath = '/home/pi/mpu9250/.csv/'
 
#ifdef DEBUG
display(dataFrame)
#endif
 
# sys.exit()
 
# minutes data from app
minutes = 2
 
# 1 count per sec
count = minutes * 60
 
try:
    while count:
        row = []
        #type(accel): Dictionary
        accel = mpu9250.readAccel()
        row.append(accel['x'])
        row.append(accel['y'])
        row.append(accel['z'])
        
#ifdef DEBUG
        print (" ax = " , ( accel['x'] ))
        print (" ay = " , ( accel['y'] ))
        print (" az = " , ( accel['z'] ))
#endif
        gyro = mpu9250.readGyro()
        row.append(gyro['x'])
        row.append(gyro['y'])
        row.append(gyro['z'])
        
#ifdef DEBUG
        print (" gx = " , ( gyro['x'] ))
        print (" gy = " , ( gyro['y'] ))
        print (" gz = " , ( gyro['z'] ))
#endif
        
        mag = mpu9250.readMagnet()
        row.append(mag['x'])
        row.append(mag['y'])
        row.append(mag['z'])
        
#ifdef DEBUG
        print (" mx = " , ( mag['x'] ))
        print (" my = " , ( mag['y'] ))
        print (" mz = " , ( mag['z'] ))
        print()
#endif
        
        row.append(datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        
#ifdef DEBUG
        print(row)
#endif
        dataFrame.loc[dataFrameIndex] = row
        dataFrameIndex += 1
        
#ifdef DEBUG
        display(dataFrame)
#endif
        time.sleep(1)
        count -= 1
        
 
except KeyboardInterrupt:
    sys.exit()
 
#ifdef DEBUG
display(dataFrame)
#endif
 dataFrame = dataFrame.set_index('datetime')
dataFrame.to_csv(savePath+str(datetime.now().strftime('%Y-%m-%d %H:%M:%S')) +
                 '_')
