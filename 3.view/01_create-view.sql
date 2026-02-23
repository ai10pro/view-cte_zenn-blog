DROP VIEW IF EXISTS v_book_details;

CREATE VIEW v_book_details AS
SELECT
    b.title,
    a.name AS author_name,
    b.price
FROM
    books b
    JOIN authors a ON b.author_id = a.id;