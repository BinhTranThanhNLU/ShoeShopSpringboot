from fastapi import FastAPI
from fpgrowth import get_recommendations

app = FastAPI()

@app.get("/api/recommend/{product_id}")
def recommend(product_id: int):
    # Gọi hàm từ fpgrowth.py
    recommended_ids = get_recommendations(product_id)
    
    return {
        "product_id": product_id,
        "recommendations": recommended_ids
    }