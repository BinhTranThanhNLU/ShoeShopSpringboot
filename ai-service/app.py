from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import create_engine, text
import pandas as pd

from fpgrowth import get_recommendations
from sentiment import predict_sentiment

app = FastAPI()

# Chuỗi kết nối DB tuyệt đối
DB_URL = "mysql+mysqlconnector://root:@localhost/shoeshop"

class CommentRequest(BaseModel):
    comment_text: str

@app.get("/api/recommend/{product_id}")
def recommend(product_id: int):
    recommended_ids = get_recommendations(product_id)
    return {
        "product_id": product_id,
        "recommendations": recommended_ids
    }

@app.post("/api/sentiment/analyze")
def analyze_comment(request: CommentRequest):
    """
    API này dùng khi User submit một review mới.
    Backend chính sẽ gọi API này để lấy nhãn (Positive/Negative) rồi lưu vào database.
    """
    sentiment_result = predict_sentiment(request.comment_text)
    return {
        "original_comment": request.comment_text,
        "sentiment": sentiment_result
    }

@app.get("/api/products/top-rated")
def get_top_rated_products(limit: int = 10):
    """
    API lấy danh sách Sản phẩm hiển thị ra trang Home.
    Dựa trên số lượng bình luận có sentiment = 'Positive'.
    """
    try:
        engine = create_engine(DB_URL)
        
        # Query đếm số lượng Positive của từng sản phẩm, JOIN để lấy tên và giá
        query = text(f"""
            SELECT p.id_product AS id, p.name, p.price, p.discount_percent, pi.image_url AS image, COUNT(r.id_review) as positive_count
            FROM products p
            JOIN review r ON p.id_product = r.id_product
            LEFT JOIN product_images pi ON p.id_product = pi.id_product
            WHERE r.sentiment = 'Positive'
            GROUP BY p.id_product
            ORDER BY positive_count DESC
            LIMIT {limit};
        """)
        
        with engine.connect() as conn:
            result = conn.execute(query)
            # Chuyển đổi kết quả SQL thành list of dictionaries
            top_products = [dict(row._mapping) for row in result]
            
        engine.dispose()
        
        return {
            "status": "success",
            "data": top_products
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

