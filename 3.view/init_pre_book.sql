-- 著者テーブル
CREATE TABLE authors (id SERIAL PRIMARY KEY, name TEXT);

-- 本テーブル
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title TEXT,
    author_id INTEGER REFERENCES authors (id),
    price INTEGER
);

-- データの投入
INSERT INTO
    authors (name)
VALUES
    ('夏目漱石'),
    ('太宰治');

INSERT INTO
    books (title, author_id, price)
VALUES
    ('吾輩は猫である', 1, 1500),
    ('坊っちゃん', 1, 1200),
    ('人間失格', 2, 1000);

SELECT
    *
FROM
    authors;

SELECT
    *
FROM
    books;