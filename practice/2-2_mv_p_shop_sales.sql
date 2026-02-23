DROP MATERIALIZED VIEW IF EXISTS mv_p_daily_shop_sales;

CREATE MATERIALIZED VIEW mv_p_daily_shop_sales AS
SELECT
    s.shop_id,
    s.shop_name,
    DATE (sl.sold_at) AS sale_date,
    COUNT(sl.sale_id) AS transaction_count,
    -- 販売価格を「その日」のキャンペーンに基づいて計算する
    SUM(sl.quantity * FLOOR(m.base_price * (1 - COALESCE(c.discount_rate, 0)))) AS daily_total_amount
FROM
    p_sales sl
    JOIN p_shops s ON sl.shop_id = s.shop_id
    JOIN p_menu m ON sl.menu_id = m.menu_id
    -- 販売日(sold_at)がキャンペーン期間内であるものを結合
    LEFT JOIN p_campaigns c ON m.menu_id = c.menu_id AND
    sl.sold_at::date BETWEEN c.start_date AND c.end_date
GROUP BY
    s.shop_id,
    s.shop_name,
    DATE (sl.sold_at)
ORDER BY
    DATE (sl.sold_at),
    s.shop_id;