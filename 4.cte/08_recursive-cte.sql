WITH RECURSIVE
    book_series AS (
        -- 1. 非再帰項：起点となる第1巻（親がNULL）を探す
        SELECT
            id,
            title,
            parent_book_id,
            1 AS volume_num
        FROM
            books_hierarchy
        WHERE
            parent_book_id IS NULL
        UNION ALL
        -- 2. 再帰項：前回の結果(bs)のIDを親に持つ「次の巻(b)」を結合する
        SELECT
            b.id,
            b.title,
            b.parent_book_id,
            bs.volume_num + 1
        FROM
            books_hierarchy b
            JOIN book_series bs ON b.parent_book_id = bs.id
    )
SELECT
    *
FROM
    book_series;