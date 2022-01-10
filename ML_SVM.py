import pandas as pd
import seaborn as sns
file_path ='./test_data.csv'

df=pd.read_csv(file_path,header=0)
df.columns=['acc_x','acc_y','acc_z','gyro_x','gyro_y','gyro_z','mag_x','mag_y','mag_z'
            ,'isCorrect','badType','user']

df['acc_x']=df['acc_x'].astype('float')
df['acc_y']=df['acc_y'].astype('float')
df['acc_z']=df['acc_z'].astype('float')
df.acc_x=df.acc_x/abs(df.acc_x.max())
df.acc_y=df.acc_y/abs(df.acc_y.max())
df.acc_z=df.acc_z/abs(df.acc_z.max())

df['gyro_x']=df['gyro_x'].astype('float')
df['gyro_y']=df['gyro_y'].astype('float')
df['gyro_z']=df['gyro_z'].astype('float')
df.gyro_x=df.gyro_x/abs(df.gyro_x.max())
df.gyro_y=df.gyro_y/abs(df.gyro_y.max())
df.gyro_z=df.gyro_z/abs(df.gyro_z.max())

df['mag_x']=df['mag_x'].astype('float')
df['mag_y']=df['mag_y'].astype('float')
df['mag_z']=df['mag_z'].astype('float')
df.mag_x=df.mag_x/abs(df.mag_x.max())
df.mag_y=df.mag_y/abs(df.mag_y.max())
df.mag_z=df.mag_z/abs(df.mag_z.max())


X = df[['acc_x','acc_y','acc_z','gyro_x','gyro_y','gyro_z','mag_x','mag_y','mag_z']]
y = df['isCorrect']


from sklearn.model_selection import train_test_split
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.3,random_state=10)

from sklearn import svm
svm_model =svm.SVC(kernel='rbf',C=10,gamma=10)
svm_model.fit(X_train,y_train) #¸ðµ¨ ÇÐ½À
y_hat=svm_model.predict(X_test)

from sklearn import metrics
svm_report = metrics.classification_report(y_test,y_hat)

print(svm_report)
