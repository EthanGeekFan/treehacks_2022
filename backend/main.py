from typing import Optional

from fastapi import FastAPI
from pydantic import BaseModel
import requests
import pandas as pd
import sklearn
from joblib import load
import random
import time

class User(BaseModel):
    name: str
    gender: int   # 0 - female, 1 - male
    orientation: int # Gender matching to
    age: int
    # Accepted age interval for matching
    age_min: int
    age_max: int
    answer: list  # Answer of the questionaire (28 dimensional)
    
# Dictionary of Users    
db = {}
match_db = {}

def clean_expired(match_db):
    cur_time = time.time()
    remove_num = []
    for i in match_db:
        duration, start_time = match_db[i][1], match_db[i][2]
        if cur_time - start_time > duration and start_time != -1:
            remove_num.append(match_db[i][0])
    for num in remove_num:
        match_db.pop(num)
    

app = FastAPI()

@app.get("/")
def root():
    return {"Home": "backend"}

@app.get("/users/")
def get_users():
    return db

@app.get("/users/{phone}")
def get_user(phone: str):
    return db[phone]

@app.get("/users/get_match/")
def get_match():
    return match_db

@app.post("/users/match/{phone}")
def match(phone: str):
    # First clean expired matching
    clean_expired(match_db)
    if phone in match_db:
        return None
    # Shortlist based on orientation and age
    model = load("RF_Model.joblib")
    max_compat = 0
    max_phone = ""
    sub_db = {}
    user = db[phone]
    orient = user.orientation
    for phone_num in db:
        # Skip himself
        if phone_num == phone: continue
        target_user = db[phone_num]
        if target_user.gender == orient and target_user.age >= user.age_min \
            and target_user.age <= user.age_max and phone_num not in match_db:
                # Use model to predict their compatibility
                if user.gender == 1:
                    input = user.answer + target_user.answer
                else: 
                    input = target_user.answer + user.answer
                compat = model.predict_proba([input])[0][1]
                if compat > max_compat:
                    max_compat = compat
                    max_phone = phone_num
    
    # Generate random duration
    duration = round(171000 * random.random() + 1800)
    if max_phone == "":
        return None
    # [match_phone, duration, start_time]
    match_db[phone] = [max_phone, duration, -1]
    match_db[max_phone] = [phone, duration, -1]
    return {"duration": duration}
        
@app.get("/users/start_match/{phone}")
def start_match(phone):
    # First clean expired matching
    clean_expired(match_db)
    cur_time = time.time()
    match_db[phone][2] = cur_time
    match_db[match_db[phone][0]][2] = cur_time
    

@app.post("/users/")
async def create_item(phone: str, user: User):
    db[phone] = user
    return user
    
@app.delete("/users/{phone}")
def delete_user(phone: str):
    db.pop(phone)
    
    
