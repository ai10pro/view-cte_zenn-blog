CREATE OR REPLACE VIEW v_p_current_prices AS
SELECT
    m.menu_id,
    m.menu_name,
    m.base_price AS standard_price,
    -- キャンペーンがない場合に備えて COALESCE で 0 を設定
    COALESCE(c.discount_rate, 0) AS current_discount_rate,
    -- 販売価格の計算
    FLOOR(m.base_price * (1 - COALESCE(c.discount_rate, 0))) AS selling_price
FROM
    p_menu AS m
    LEFT JOIN p_campaigns AS c ON m.menu_id = c.menu_id AND
    CURRENT_DATE BETWEEN c.start_date AND c.end_date;