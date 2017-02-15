-- -h localhost -d hr-til_development

SELECT c1.name, c2.name, c2.parent_id, p.*
FROM
  channels AS c1
    INNER JOIN channels AS c2 ON c1.id = c2.parent_id
    INNER JOIN channels_posts AS cp ON c2.id = cp.channel_id
    INNER JOIN posts AS p ON cp.post_id = p.id
