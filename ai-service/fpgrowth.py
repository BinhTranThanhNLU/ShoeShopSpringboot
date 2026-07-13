import pandas as pd
from mlxtend.preprocessing import TransactionEncoder
from mlxtend.frequent_patterns import fpgrowth, association_rules
from sqlalchemy import create_engine

def get_recommendations(product_id):
    # 1. Kết nối vào MySQL
    # Cấu trúc: mysql+mysqlconnector://<username>:<password>@<host>/<database>
    engine = create_engine("mysql+mysqlconnector://root:@localhost/shoeshop")

    # 2. Query dữ liệu
    query = """
        SELECT oi.id_order, pv.id_product
        FROM order_item oi
        JOIN product_variants pv ON oi.id_variant = pv.id_variant
        ORDER BY oi.id_order;
    """
    
    df = pd.read_sql(query, engine)
    
    engine.dispose()

    # 3. Chạy thuật toán FP-Growth
    transactions = df.groupby("id_order")["id_product"].apply(list).tolist()
    
    te = TransactionEncoder()
    te_array = te.fit(transactions).transform(transactions)
    basket = pd.DataFrame(te_array, columns=te.columns_)

    frequent_itemsets_fp = fpgrowth(basket, min_support=0.05, use_colnames=True)
    
    rules_fp = association_rules(
        frequent_itemsets_fp,
        num_itemsets=len(basket),
        metric="confidence",
        min_threshold=0.5
    )

    rules_fp = rules_fp[
        (rules_fp["confidence"] >= 0.5) &
        (rules_fp["lift"] > 1)
    ]

    # 4. Tìm các sản phẩm được gợi ý
    recommendations = set()
    for idx, row in rules_fp.iterrows():
        antecedents = list(row['antecedents'])
        consequents = list(row['consequents'])
        
        if product_id in antecedents:
            for item in consequents:
                recommendations.add(int(item))

    return list(recommendations)