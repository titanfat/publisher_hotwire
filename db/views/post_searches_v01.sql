select
    p.id as post_id,
    (
        to_tsvector('simple', coalesce(p.title, ''))
        || to_tsvector('simple', coalesce(p.original_title, ''))
        || to_tsvector('simple', coalesce(
                string_agg(concat(u.first_name, '', u.last_name)::text, ' ; ')))
    ) as tsv_document
from posts p join authors_posts ap on p.id = ap.post_id
join users u on u.id = ap.user_id
group by p.id, p.title, p.original_title