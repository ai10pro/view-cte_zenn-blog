WITH shop_metrics AS (
    -- 1. 各店舗の「本日の売上」と「キャパシティ」を整理
    SELECT
        s.group_id,
        s.shop_name,
        s.capacity,
        SUM(sl.quantity * cp.selling_price) AS daily_revenue
    FROM p_shops s
    JOIN p_sales sl ON s.shop_id = sl.shop_id
    JOIN v_p_current_prices cp ON sl.menu_id = cp.menu_id
    WHERE sl.sold_at::date = CURRENT_DATE
    GROUP BY s.group_id, s.shop_id, s.shop_name, s.capacity
),
area_averages AS (
    -- 2. エリアごとの「平均売上」を算出
    SELECT
        group_id,
        AVG(daily_revenue) AS area_avg_revenue
    FROM shop_metrics
    GROUP BY group_id
)
-- 3. メインクエリ：1席あたりの売上（効率）とエリア平均との比較
SELECT
    g.group_name,
    sm.shop_name,
    sm.daily_revenue,
    ROUND(sm.daily_revenue::numeric / sm.capacity, 0) AS revenue_per_seat, -- 1席あたりの売上
    CASE 
        WHEN sm.daily_revenue > aa.area_avg_revenue THEN '★優良店'
        ELSE '要改善'
    END AS area_status
FROM shop_metrics sm
JOIN area_averages aa ON sm.group_id = aa.group_id
JOIN p_groups g ON sm.group_id = g.group_id
ORDER BY revenue_per_seat DESC;