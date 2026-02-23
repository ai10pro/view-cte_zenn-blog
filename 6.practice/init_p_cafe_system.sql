-- 既存のテーブルを削除
DROP TABLE IF EXISTS p_sales CASCADE;

DROP TABLE IF EXISTS p_menu_hierarchy CASCADE;

DROP TABLE IF EXISTS p_campaigns CASCADE;

DROP TABLE IF EXISTS p_menu CASCADE;

DROP TABLE IF EXISTS p_shops CASCADE;

DROP TABLE IF EXISTS p_groups CASCADE;

-- 1. エエリア管理
CREATE TABLE p_groups (group_id SERIAL PRIMARY KEY, group_name TEXT NOT NULL);

-- 2. 店舗管理
CREATE TABLE p_shops (
    shop_id SERIAL PRIMARY KEY,
    group_id INTEGER REFERENCES p_groups (group_id),
    shop_name TEXT NOT NULL,
    capacity INTEGER NOT NULL
);

-- 3. メニューマスター
CREATE TABLE p_menu (
    menu_id SERIAL PRIMARY KEY,
    menu_name TEXT NOT NULL,
    base_price INTEGER NOT NULL,
    cost INTEGER NOT NULL
);

-- 4. キャンペーン管理
CREATE TABLE p_campaigns (
    campaign_id SERIAL PRIMARY KEY,
    menu_id INTEGER REFERENCES p_menu (menu_id),
    discount_rate DECIMAL(3, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- 5. セットメニュー構成
CREATE TABLE p_menu_hierarchy (
    parent_menu_id INTEGER REFERENCES p_menu (menu_id),
    child_menu_id INTEGER REFERENCES p_menu (menu_id),
    PRIMARY KEY (parent_menu_id, child_menu_id)
);

-- 6. 売上実績
CREATE TABLE p_sales (
    sale_id SERIAL PRIMARY KEY,
    shop_id INTEGER REFERENCES p_shops (shop_id),
    menu_id INTEGER REFERENCES p_menu (menu_id),
    quantity INTEGER NOT NULL,
    sold_at TIMESTAMP NOT NULL
);