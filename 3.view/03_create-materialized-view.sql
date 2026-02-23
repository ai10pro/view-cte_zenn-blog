DROP MATERIALIZED VIEW IF EXISTS mv_book_materialized;

CREATE MATERIALIZED VIEW mv_book_materialized AS
SELECT
    b.title,
    a.name AS author_name,
    b.price
FROM
    books b
    JOIN authors a ON b.author_id = a.id;