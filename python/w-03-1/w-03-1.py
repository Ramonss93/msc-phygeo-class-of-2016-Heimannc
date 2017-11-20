# -*- coding: utf-8 -*-
"""
Created on Sat Nov 18 12:32:42 2017

@author: Christian
"""

from random import randint
import numpy


data = list (range(0,1000001))

# binary search
def binary_search(data,target):
    low = 0
    high = len(data)-1
    counter=1
    while low<= high:
        mid= (low+high)//2
        if target == mid:
            return counter
        elif target < mid:
            high = mid - 1
            counter +=1
        else:
            low = mid + 1
            counter +=1
    return "Target not in data range"

counts=[]
for i in range(len(data)):
    target = randint(0,1000000)
    counts.append(binary_search(data, target))
    

mean_count=numpy.mean(counts)
   
print(mean_count)
# gerundet auf zweite Nachkommastelle: 18.95
print(max(counts))
# 20
print(min(counts))
# 1