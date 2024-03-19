with users(id, name, sub_name, sub_id, sub_level) as (
	select c.id, c.name, s.name, c.subdivision_id, 0
		FROM dbo.collaborators c
		join dbo.subdivisions s
			on c.subdivision_id = s.id and (c.id = 710253 and c.age < 40)

	union all
	
	select c.id, c.name, s.name, c.subdivision_id, sub_level + 1
		from users u
		join dbo.subdivisions s on s.parent_id = u.sub_id
		join dbo.collaborators c on s.id = c.subdivision_id and c.age < 40
)

select distinct *
	from users
	where users.sub_id != 100055 and users.sub_id != 100059
	order by users.sub_level asc