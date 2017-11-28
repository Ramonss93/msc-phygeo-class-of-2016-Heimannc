# -*- coding: utf-8 -*-
"""
Created on Mon Nov 27 08:42:08 2017

@author: Christian
"""

import random
import time


data= random.sample(range(2000), 1000)
print(data)


# solution 1
def sort (data_list):
    val = 0
    value_bef = 0
    for i in range(1,len(data_list)):
        val= data_list[i] # der zweite Listenwert (im ersten Durchlauf), danach immer der nächste Wert bis Listenende
        value_bef= i-1 # der vorhergende Listenwerte
        while value_bef>=0:
            if val < data_list[value_bef]:# wenn Wert vorher größer ist als Wert nachher schiebe den Wert nach rechts 
                data_list[value_bef+1]=data_list[value_bef] # verändert den Wert an der Stelle des vorherigen Werts zu einem wert einen  weiter rechts
                data_list[value_bef] = val # verändert den eigentlichen Wert 
                value_bef = value_bef - 1
            else:
                break

start_time = time.time()
sort(data)
print(data) 
print("---%s seconds ---" %(time.time() - start_time))

## takes ---0.1405777931213379 seconds ---


# solution 2

data= random.sample(range(2000), 1000)

nl= []
l = data
start_time = time.time()
while len(l) != 0:
    if min(l) != l[-1]:
        a, b = l.index(min(l)), l.index(l[-1])
        l[a], l[b] = l[b], l[a]
        z = l[-1]
        nl.append(z)
        l.pop()
    elif min(l)== l[-1]:
        z = l[-1]
        nl.append(z)
        l.pop()

print(data)
print("---%s seconds ---" %(time.time() - start_time))
## takes ---0.062499284744262695 seconds ---