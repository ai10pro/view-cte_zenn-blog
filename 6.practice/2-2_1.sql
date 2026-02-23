SELECT
    sale_date,
    daily_total_amount
FROM
    mv_p_daily_shop_sales
WHERE
    shop_name = '梅田店'
    AND sale_date BETWEEN '2026-02-01' AND '2026-02-28'
ORDER BY
    sale_date;