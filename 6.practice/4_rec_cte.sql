WITH RECURSIVE exploded_menu AS (
    -- 1. 起点：すべてのメニュー（単品もセットも）
    SELECT 
        menu_id AS root_menu_id,
        menu_id,
        cost,
        1 AS level
    FROM p_menu
    
    UNION ALL
    
    -- 2. 再帰：セットの中身をどんどんバラしていく
    SELECT 
        em.root_menu_id,
        m.menu_id,
        m.cost,
        em.level + 1
    FROM exploded_menu em
    JOIN p_menu_hierarchy mh ON em.menu_id = mh.parent_menu_id
    JOIN p_menu m ON mh.child_menu_id = m.menu_id
),
final_product_costs AS (
    -- 3. 分解した結果を合算（セットは中身の合計原価に、単品はそのままに）
    SELECT 
        root_menu_id,
        SUM(cost) AS real_cost
    FROM exploded_menu
    WHERE 
        -- 「自分自身が親でない（＝末端の単品）」か、
        -- 「深さが2以上（＝セットの中身として出てきた単品）」を集計
        level > 1 OR menu_id NOT IN (SELECT parent_menu_id FROM p_menu_hierarchy)
    GROUP BY root_menu_id
)
-- 4. メインクエリ：現在の販売価格と「真の原価」をぶつけて利益率を出す
SELECT 
    v.menu_name,
    v.selling_price AS price,
    f.real_cost,
    (v.selling_price - f.real_cost) AS profit_amount,
    ROUND(((v.selling_price - f.real_cost)::numeric / v.selling_price) * 100, 1) AS profit_margin_pct
FROM v_p_current_prices v
JOIN final_product_costs f ON v.menu_id = f.root_menu_id
ORDER BY profit_margin_pct DESC;