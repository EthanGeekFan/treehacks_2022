import pandas as pd
import numpy as  np
import random

def generate_random_data(num = 10):
    data = {}
    for i in range(num):
        name = str(i)
        gender = round(random.random())
        rand_float = random.random()
        if (rand_float >= 0.95):
            orientation = gender
        else:
            orientation = 1 - gender
        
        # Random age between 20 and 30
        age = round(random.random() * 10 + 20)
        age_min = round(random.random() * 10 + 20)
        age_max = round(random.random() * 10 + 20)
        if age_min > age_max:
            age_min, age_max = age_max, age_min
        
        answer = [0 for _ in range(28)]
        for j in range(len(answer)):
            # Randint 1-10
            rand_int = round(9 * random.random()) + 1
            answer[j] = rand_int
        
        data[i] = {"name": name, "gender": gender, "orientation": orientation, "age": age,
                   "age_min": age_min, "age_max": age_max, "answer":answer}
    
    return data
    
