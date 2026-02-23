-- 今日売れた数に、最新の販売価格を掛け合わせる
SELECT
    cp.menu_name,
    cp.selling_price AS current_price,
    SUM(sl.quantity) AS today_quantity,
    SUM(sl.quantity * cp.selling_price) AS today_revenue
FROM
    p_sales sl
    JOIN v_p_current_prices cp ON sl.menu_id = cp.menu_id
WHERE
    sl.sold_at::date = '2026-02-23'
GROUP BY
    cp.menu_id,
    cp.menu_name,
    cp.selling_price;