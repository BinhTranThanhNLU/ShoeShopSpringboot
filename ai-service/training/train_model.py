import os
import sys

# =====================================================
# Khai báo đường dẫn tuyệt đối ra thư mục gốc (ai-service)
# =====================================================
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Thêm thư mục gốc vào hệ thống để Python có thể import được preprocessing.py
sys.path.append(BASE_DIR)

import joblib
import pandas as pd

from preprocessing import clean_text, is_spam_comment

from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import LabelEncoder
from sklearn.linear_model import LogisticRegression # Thay LinearSVC

from sklearn.metrics import (
    accuracy_score,
    classification_report,
)


# =====================================================
# 1. Đọc Dataset
# =====================================================
DATASET_PATH = os.path.join(BASE_DIR, "dataset", "reviews_dataset.csv")
MODEL_DIR = os.path.join(BASE_DIR, "model")

os.makedirs(MODEL_DIR, exist_ok=True)
df = pd.read_csv(DATASET_PATH)

print("=" * 60)
print("DATASET")
print("=" * 60)

# =====================================================
# 2 - 6. Xử lý & Chuẩn bị dữ liệu
# =====================================================
df = df.dropna(subset=["comment", "sentiment"])
df["comment"] = df["comment"].astype(str)
df = df[df["comment"].str.strip() != ""]

df["comment"] = df["comment"].apply(clean_text)
df = df[~df["comment"].apply(is_spam_comment)]

X = df["comment"]
y = df["sentiment"]

# =====================================================
# 7. Encode Label
# =====================================================
label_encoder = LabelEncoder()
y_encoded = label_encoder.fit_transform(y)

# =====================================================
# 7.5 Xử lý trọng số cho câu Pha trộn cảm xúc ngay trên df
# =====================================================
print("\nĐang tính toán trọng số (Sample Weights) cho dữ liệu...")

# Tạo cột trọng số mặc định là 1.0 cho tất cả bình luận
df['weight'] = 1.0

# Tìm các câu có chứa từ khóa chuyển ngoặt (dấu hiệu của Mixed Sentiment)
contrast_words = ['nhưng', 'tuy nhiên', 'mặc dù', 'thế mà']
mask_mixed_words = df['comment'].str.contains('|'.join(contrast_words), case=False, na=False)

# Hoặc nếu nhãn trong dataset đã được bạn đánh là 'Mixed'
mask_label_mixed = df['sentiment'] == 'Mixed'

# Tăng trọng số lên 2.0 (gấp đôi) cho các câu khó này
df.loc[mask_mixed_words | mask_label_mixed, 'weight'] = 2.0

print(f"Đã tăng trọng số cho {df['weight'][df['weight'] == 2.0].count()} bình luận pha trộn/khó.")

# =====================================================
# 8. Train/Test Split
# =====================================================
X_train, X_test, y_train, y_test, w_train, w_test = train_test_split(
    X,
    y_encoded,
    df['weight'],
    test_size=0.2,
    random_state=42,
    stratify=y_encoded,
)

# =====================================================
# 9. TF-IDF
# =====================================================
vectorizer = TfidfVectorizer(
    analyzer='char_wb',
    ngram_range=(2, 5),
    min_df=2,
    max_df=0.95,
    sublinear_tf=True
)

X_train_vector = vectorizer.fit_transform(X_train)
X_test_vector = vectorizer.transform(X_test)

# =====================================================
# 10. Train Model (Sử dụng Logistic Regression) (Ép trọng số vào khi fit)
# =====================================================
print("\nĐang huấn luyện Logistic Regression...")
model = LogisticRegression(
    class_weight="balanced", 
    max_iter=1000, 
    random_state=42
)
model.fit(X_train_vector, y_train, sample_weight=w_train)

# =====================================================
# 11 & 12. Predict & Evaluation
# =====================================================
y_pred = model.predict(X_test_vector)

print("\nMODEL EVALUATION")
print(f"Accuracy : {accuracy_score(y_test, y_pred):.4f}")
print("\nClassification Report\n")
print(classification_report(y_test, y_pred, target_names=label_encoder.classes_))

# =====================================================
# 13. Save Model
# =====================================================
joblib.dump(model, os.path.join(MODEL_DIR, "sentiment_model.pkl"))
joblib.dump(vectorizer, os.path.join(MODEL_DIR, "vectorizer.pkl"))
joblib.dump(label_encoder, os.path.join(MODEL_DIR, "label_encoder.pkl"))

print("\nModel đã được lưu vào thư mục model/")