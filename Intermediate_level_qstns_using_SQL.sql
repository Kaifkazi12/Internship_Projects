-- Moderate Level Queries --
-- 1. Find the email, first name, and last name of customers who listen to Rock music. --
SELECT DISTINCT
    c.email,
    c.first_name,
    c.last_name
FROM
    customer c
JOIN
    invoice i ON c.customer_id = i.customer_id
JOIN
    invoice_line il ON i.invoice_id = il.invoice_id
JOIN
    track t ON il.track_id = t.track_id
JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name = 'Rock'
ORDER BY
    c.last_name, c.first_name;

-- Identify the top 10 rock artists based on track count. --
SELECT
    ar.name AS artist_name,
    COUNT(t.track_id) AS rock_track_count
FROM
    artist ar
JOIN
    album2 al ON ar.artist_id = al.artist_id
JOIN
    track t ON al.album_id = t.album_id
JOIN
    genre g ON t.genre_id = g.genre_id
WHERE
    g.name = 'Rock'
GROUP BY
    ar.name
ORDER BY
    rock_track_count DESC
LIMIT 10;

-- Find all track names that are longer than the average track length. --
SELECT
    name,
    milliseconds  -- Assuming 'milliseconds' is the column for track length
FROM
    track
WHERE
    milliseconds > (
        SELECT
            AVG(milliseconds)
        FROM
            track
    )
ORDER BY
    milliseconds DESC;