-- 1,000円より高い本を抽出してから、著者と結合する
WITH
    expensive_books AS (
        SELECT
            *
        FROM
            books
        WHERE
            price > 1000
    )
SELECT
    eb.title,
    a.name AS author_name,
    eb.price
FROM
    expensive_books AS eb
    JOIN authors AS a ON eb.author_id = a.id;