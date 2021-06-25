import json
import random

import time
    
def str_time_prop(start, end, time_format, prop):

    stime = time.mktime(time.strptime(start, time_format))
    etime = time.mktime(time.strptime(end, time_format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(time_format, time.localtime(ptime))


def random_date(start, end, prop):
    return str_time_prop(start, end, '%m/%d/%Y %I:%M %p', prop)
    

restaurants_list=["Chipotle Mexican Grill",                                                                                                                            
"Carl's Jr",                                                                                                                                           
"Togo's",                                                                                                                               
"7-Eleven",                                                                                                                                            
"Burger King",                                                                                                                                        
"Dairy Queen",                                                                                                                                         
"Wendy's",                                                                                                                                             
"Steak 'n Shake",                                                                                                                                      
"Mr. Hero",
"Golden Chick",                                                                                                                                        
"Rally's",                                                                                                                                             
"Arby's",                                                                                                                                       
"Taco Bell"]

city=["Akron","Atlanta","Brownsville","Las Vegas", "Canton","Charlottesville","Columbus", "Dallas", "Denver", "El Paso", "Houston"]

def generator (n):

    data=[]
    for i in range (n):
        data=data+[{"name": restaurants_list[random.randrange(0,len(restaurants_list))],
                    "date": random_date("1/1/2015 1:30 AM", "12/31/2019 4:50 AM", random.random()),
                    "campaign": "Campaign"+str(random.randrange(0,1000000)),
                    "views": random.randrange(0,500000),
                    "shares": random.randrange(0,10000),
                    "city": city[random.randrange(0,len(city))],
                    "amount": random.uniform(0,1000000.00)}]
    with open("C:/Users/taylo/OneDrive/Documentos/ChangeIt/ETL/JSON_4_Mongo.json","w") as restaurants:
        json.dump(data,restaurants)
    print("To' Gucci")

generator(10000)

