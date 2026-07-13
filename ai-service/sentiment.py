import os
import joblib
from preprocessing import clean_text

# Bắt buộc dùng đường dẫn tuyệt đối (Absolute Path) để tránh lỗi khi FastAPI gọi
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_DIR = os.path.join(BASE_DIR, "model")

model_path = os.path.join(MODEL_DIR, "sentiment_model.pkl")
vectorizer_path = os.path.join(MODEL_DIR, "vectorizer.pkl")
label_encoder_path = os.path.join(MODEL_DIR, "label_encoder.pkl")

# Khởi tạo biến global để giữ model trên memory
model = None
vectorizer = None
label_encoder = None

def load_models():
    global model, vectorizer, label_encoder
    try:
        model = joblib.load(model_path)
        vectorizer = joblib.load(vectorizer_path)
        label_encoder = joblib.load(label_encoder_path)
        print("Đã tải mô hình Sentiment Analysis thành công!")
    except FileNotFoundError:
        print("Cảnh báo: Chưa tìm thấy file mô hình. Vui lòng chạy train_model.py trước.")

# Load model ngay khi file này được import
load_models()

def predict_sentiment(comment: str) -> str:
    if not model or not vectorizer or not label_encoder:
        return "Model chưa sẵn sàng"
        
    cleaned_comment = clean_text(comment)
    vectorized_comment = vectorizer.transform([cleaned_comment])
    prediction = model.predict(vectorized_comment)
    sentiment_label = label_encoder.inverse_transform(prediction)[0]
    
    return sentiment_label