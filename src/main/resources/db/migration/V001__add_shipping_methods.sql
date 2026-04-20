-- Migration: Add shipping_methods table and update cart table
-- Date: 2026-04-20
-- Version: 001

-- 1. Add missing columns to existing shipping_methods table
ALTER TABLE IF EXISTS shipping_methods
ADD COLUMN IF NOT EXISTS description VARCHAR(255) AFTER name,
ADD COLUMN IF NOT EXISTS estimated_days INT AFTER cost,
ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT true AFTER estimated_days;

-- 2. Verify cart table structure and ensure foreign key exists
-- Check if id_shipping_method column exists in cart table
-- ALTER TABLE cart ADD COLUMN id_shipping_method INT NULL DEFAULT NULL IF it doesn't exist
-- (This should already be present in your existing database)

-- 3. Add foreign key constraint if not exists (handles duplicate key error gracefully)
ALTER TABLE IF EXISTS orders
ADD CONSTRAINT IF NOT EXISTS fk_orders_shipping_method
FOREIGN KEY (id_shipping_method) REFERENCES shipping_methods(id_shipping_method)
ON DELETE SET NULL ON UPDATE RESTRICT;

ALTER TABLE IF EXISTS cart
ADD CONSTRAINT IF NOT EXISTS fk_cart_shipping_method
FOREIGN KEY (id_shipping_method) REFERENCES shipping_methods(id_shipping_method)
ON DELETE SET NULL ON UPDATE RESTRICT;

-- 4. Update existing shipping methods to match the migration requirement
UPDATE shipping_methods
SET
    description = CASE name
        WHEN 'Giao hàng tiêu chuẩn' THEN 'Giao trong 3-5 ngày'
        WHEN 'Giao hàng nhanh' THEN 'Giao trong 1-2 ngày'
        WHEN 'Miễn phí vận chuyển' THEN 'Miễn phí vận chuyển cho đơn hàng từ 1.000.000đ'
        ELSE description
    END,
    estimated_days = CASE name
        WHEN 'Giao hàng tiêu chuẩn' THEN 5
        WHEN 'Giao hàng nhanh' THEN 2
        WHEN 'Miễn phí vận chuyển' THEN 7
        ELSE estimated_days
    END,
    is_active = true
WHERE is_active IS NULL OR is_active = false;

-- 5. Add new shipping method if it doesn't exist
INSERT INTO shipping_methods (name, description, cost, estimated_days, is_active)
VALUES ('Giao hàng siêu tốc', 'Giao cùng ngày (chỉ trong nội thành)', 500000.00, 0, true)
ON DUPLICATE KEY UPDATE
    description = 'Giao cùng ngày (chỉ trong nội thành)',
    estimated_days = 0,
    is_active = true;

-- 6. Verify data
SELECT * FROM shipping_methods;

