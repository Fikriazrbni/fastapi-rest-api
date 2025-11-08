from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI!"}

@app.get("/test ping")
def ping():
    return {"status": "ok"}

@app.get("/bmi")
def calculate_bmi(weight: float, height: float):
    bmi = weight / (height ** 2)
    return {"bmi": round(bmi, 2)}

@app.get("/luas segitiga")
def calculate_triangle_area(base: float, height: float):
    area = 0.5 * base * height
    return {"area": area}