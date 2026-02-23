-- (1) エリア・店舗・キャパシティの確認
SELECT
    g.group_id,
    g.group_name,
    s.shop_id,
    s.shop_name,
    s.capacity
FROM
    p_shops s
    JOIN p_groups g ON s.group_id = g.group_id
ORDER BY
    g.group_id;

-- (2) メニューとキャンペーンの紐付け確認
-- （キャンペーン期間外の商品も表示するために LEFT JOIN を使用）
SELECT
    m.menu_id,
    m.menu_name,
    m.base_price,
    c.discount_rate,
    c.start_date,
    c.end_date
FROM
    p_menu m
    LEFT JOIN p_campaigns c ON m.menu_id = c.menu_id;

-- (3) セットメニュー（親子関係）の確認
SELECT
    m_p.menu_name AS セット名,
    m_c.menu_name AS 構成単品名
FROM
    p_menu_hierarchy mh
    JOIN p_menu m_p ON mh.parent_menu_id = m_p.menu_id
    JOIN p_menu m_c ON mh.child_menu_id = m_c.menu_id;

SELECT
    sl.sale_id,
    s.shop_name,
    m.menu_name,
    sl.quantity,
    sl.sold_at
FROM
    p_sales sl
    JOIN p_shops s ON sl.shop_id = s.shop_id
    JOIN p_menu m ON sl.menu_id = m.menu_id
ORDER BY
    sl.sold_at DESC;