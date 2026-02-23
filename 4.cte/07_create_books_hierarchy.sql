DROP TABLE IF EXISTS books_hierarchy;

-- 再帰実験用の専用テーブル
CREATE TABLE books_hierarchy (
    id SERIAL PRIMARY KEY,
    title TEXT,
    parent_book_id INTEGER REFERENCES books_hierarchy (id) -- 親（前の巻）のID
);

-- シリーズデータの投入
-- 吾輩は猫である(1) -> 坊っちゃん(2) -> 人間失格(3)
INSERT INTO
    books_hierarchy (id, title, parent_book_id)
VALUES
    (1, '吾輩は猫である', NULL),
    (2, '坊っちゃん', 3),
    (3, '人間失格', 2);

SELECT
    *
FROM
    books_hierarchy;