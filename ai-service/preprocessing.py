import re
import emoji
from underthesea import text_normalize, word_tokenize

# Danh sách từ dừng an toàn (không làm thay đổi ý nghĩa cảm xúc)
SAFE_STOPWORDS = {
    "là", "thì", "mà", "ở", "tại", "của", "các", "những", 
    "để", "cho", "với", "do", "bởi", "và", "vào", "ra"
}

def clean_text(text):
    text = str(text)
    
    # 1. Dùng thư viện chuẩn hóa có sẵn của underthesea
    text = text_normalize(text)
    text = text.lower()
    
    # 2. Dịch toàn bộ emoji sang text (vd: 👍 -> :thumbs_up:)
    text = emoji.demojize(text)
    
    # 3. Loại bỏ ký tự đặc biệt (chỉ giữ lại chữ, số và format của emoji có dấu ':')
    text = re.sub(r"[^\w\s:À-ỹ]", " ", text)
    text = re.sub(r"\s+", " ", text)
    
    # 4. Tách từ ghép tiếng Việt bằng underthesea
    text = word_tokenize(text.strip(), format="text")

    # 5. Loại bỏ các từ stop word vô nghĩa
    words = text.split()
    words = [w for w in words if w not in SAFE_STOPWORDS]
    text = " ".join(words)
    
    return text

def is_spam_comment(text):
    text = text.strip()
    if len(text) < 2: return True
    if re.fullmatch(r"[^\w]+", text): return True
    if re.fullmatch(r"(.)\1{4,}", text): return True
    if re.fullmatch(r"(asdf)+", text): return True
    if re.fullmatch(r"(ha)+", text): return True 
    if re.fullmatch(r"(hj)+", text): return True
    if len(text.split()) == 1 and len(text) <= 2: return True
    return False