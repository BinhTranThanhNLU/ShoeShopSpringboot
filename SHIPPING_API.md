# Shipping Methods API Documentation

## Overview
Các API xử lý phương thức vận chuyển cho giỏ hàng.

## Endpoints

### 1. Get All Active Shipping Methods
**GET** `/api/cart/shipping-methods`

Lấy danh sách tất cả các phương thức vận chuyển hiện hoạt động.

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "name": "Giao hàng tiêu chuẩn",
    "description": "Giao trong 3-5 ngày",
    "cost": 100000,
    "estimatedDays": 5,
    "isActive": true
  },
  {
    "id": 2,
    "name": "Giao hàng nhanh",
    "description": "Giao trong 1-2 ngày",
    "cost": 200000,
    "estimatedDays": 2,
    "isActive": true
  },
  {
    "id": 3,
    "name": "Giao hàng siêu tốc",
    "description": "Giao cùng ngày (chỉ trong nội thành)",
    "cost": 500000,
    "estimatedDays": 0,
    "isActive": true
  }
]
```

---

### 2. Update Cart Shipping Method
**PUT** `/api/cart/shipping`

Cập nhật phương thức vận chuyển cho giỏ hàng của người dùng hiện tại.

**Headers:**
- `Authorization: Bearer {token}`

**Request Body:**
```json
{
  "shippingMethodId": 2
}
```

**Response (200 OK):**
```json
{
  "cartId": 1,
  "userId": 5,
  "totalItems": 2,
  "totalPrice": 3500000,
  "shippingCost": 200000,
  "grandTotal": 3700000,
  "shippingMethod": {
    "id": 2,
    "name": "Giao hàng nhanh",
    "description": "Giao trong 1-2 ngày",
    "cost": 200000,
    "estimatedDays": 2,
    "isActive": true
  },
  "items": [
    {
      "cartItemId": 1,
      "variantId": 1,
      "productId": 1,
      "productName": "Giày Sneaker Có Thắp Năng Động",
      "color": "Trắng",
      "size": "US10",
      "unitPrice": 850000,
      "quantity": 2,
      "availableStock": 10,
      "lineTotal": 1700000
    },
    {
      "cartItemId": 2,
      "variantId": 3,
      "productId": 2,
      "productName": "Giày đá bóng Mizuno Morelia Sala Elite AS TF",
      "color": "Trắng",
      "size": "US8",
      "unitPrice": 2175200,
      "quantity": 1,
      "availableStock": 5,
      "lineTotal": 2175200
    }
  ]
}
```

**Error Response (404 Not Found):**
```json
{
  "message": "Shipping method not found with id: 99"
}
```

**Error Response (400 Bad Request):**
```json
{
  "message": "Shipping method is not active"
}
```

---

## Usage Flow

### Frontend Integration Example

```javascript
// 1. Lấy danh sách phương thức vận chuyển khi tải trang giỏ hàng
async function loadShippingMethods() {
  const response = await fetch('http://localhost:8080/api/cart/shipping-methods');
  const methods = await response.json();
  // Hiển thị các option vận chuyển
  displayShippingOptions(methods);
}

// 2. Khi người dùng chọn phương thức vận chuyển
async function selectShippingMethod(shippingMethodId, token) {
  const response = await fetch('http://localhost:8080/api/cart/shipping', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    },
    body: JSON.stringify({
      shippingMethodId: shippingMethodId
    })
  });
  const cart = await response.json();
  // Cập nhật hiển thị giỏ hàng với shippingCost và grandTotal mới
  updateCartDisplay(cart);
}
```

---

## Database Setup

### Insert Sample Shipping Methods
```sql
INSERT INTO shipping_methods (name, description, cost, estimated_days, is_active) VALUES
('Giao hàng tiêu chuẩn', 'Giao trong 3-5 ngày', 100000, 5, true),
('Giao hàng nhanh', 'Giao trong 1-2 ngày', 200000, 2, true),
('Giao hàng siêu tốc', 'Giao cùng ngày (chỉ trong nội thành)', 500000, 0, true);
```

---

## Notes

- Các phương thức vận chuyển được quản lý độc lập, có thể kích hoạt/vô hiệu hoá qua `is_active` flag
- Khi người dùng chọn phương thức vận chuyển, `shippingCost` sẽ được tự động tính
- `grandTotal = totalPrice + shippingCost`
- Nếu chưa chọn phương thức vận chuyển nào, `shippingCost = 0` và `shippingMethod = null`

