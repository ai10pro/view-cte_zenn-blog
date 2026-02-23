-- エリア
INSERT INTO
    p_groups (group_name)
VALUES
    ('大阪北エリア'),
    ('大阪南エリア');

-- 店舗
INSERT INTO
    p_shops (group_id, shop_name, capacity)
VALUES
    (1, '新大阪店', 30),
    (1, '梅田店', 50),
    (2, '難波店', 25),
    (2, '天王寺店', 70);

-- メニュー
INSERT INTO
    p_menu (menu_id, menu_name, base_price, cost)
VALUES
    (1, 'ブレンドコーヒー', 400, 50),
    (2, '特製ラテ', 550, 80),
    (3, '厚切りトースト', 350, 40),
    (4, 'モーニングAセット', 600, 90);

-- セットメニュー構成
INSERT INTO
    p_menu_hierarchy (parent_menu_id, child_menu_id)
VALUES
    (4, 1),
    (4, 3);

-- キャンペーン
INSERT INTO
    p_campaigns (menu_id, discount_rate, start_date, end_date)
VALUES
    (2, 0.20, '2026-02-01', '2026-02-28');

-- 売上実績
INSERT INTO
    p_sales (shop_id, menu_id, quantity, sold_at)
VALUES
    (1, 1, 12, '2026-02-23 10:00:00'),
    (2, 2, 15, '2026-02-23 14:00:00'),
    (2, 4, 10, '2026-02-23 09:00:00'),
    (3, 1, 10, '2026-02-23 12:00:00'),
    (4, 1, 25, '2026-02-23 12:00:00'),
    (4, 4, 15, '2026-02-23 08:30:00');