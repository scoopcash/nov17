select rating, count(*) as "Number of Films" from film group by rating having count(*) > 200;

select avg(rental_rate), rental_duration from film group by rental_duration;

select * from payment;

select avg(amount) from payment;

select sum(amount) from payment;

select min(amount) from payment;

select max(amount) from payment;

select count(customer_id), staff_id from payment group by staff_id;

select count(*) from payment;

select customer_id, count(payment_id) as "No. of transactions" from payment group by customer_id having count(payment_id) >40;

select film_id, round(avg(length)) as "average film length" from film group by film_id order by avg(length);

select customer_id, count(payment_id) as "No. of transactions" from payment group by customer_id order by count(payment_id) desc;

select customer_id, sum(amount) as "No. of transactions" from payment group by customer_id order by sum(amount) desc limit 5;


select film_id, title from film where title = 'EARLY HOME';
select * from inventory where film_id = 268;
select inventory_id, film_id, store_id, last_update from inventory

select i.inventory_id, i.film_id, i.store_id from inventory i join film f on(i.film_id = f.film_id) where f.title = 'EARLY HOME'

select * from inventory 
where film_id in
	(
	select film_id
	from film
	where title = 'EARLY HOME'
	)


select customer_id, first_name, last_name from customer 
where customer_id in
	(
	select customer_id
	from payment
	);


select count(*) from payment;

select customer_id, first_name, last_name from customer 
where customer_id in
	(
	select customer_id
	from payment
	);

#view

create view total_sales as 
SELECT s.store_id, SUM(amount) AS Gross
FROM payment AS p
  JOIN rental AS r
  ON (p.rental_id = r.rental_id)
    JOIN inventory AS i
    ON (i.inventory_id = r.inventory_id)
      JOIN store AS s
      ON (s.store_id = i.store_id)
      GROUP BY s.store_id;
	  
	 
select * from total_sales;


create view customer_data as 
select c.first_name, c.last_name, count(payment_id), sum(amount)
from payment p 
	join customer c
	on (p.customer_id = c.customer_id)
	group by c.customer_id
	
select * from customer_data;



create view customer_data as 
select c.first_name, c.last_name, count(payment_id), sum(amount)
from payment p 
	join customer c
	on (p.customer_id = c.customer_id)
	group by first_name, last_name
	order by sum(amount) desc;
	
select * from customer_data;

select *
from customer_data
where first_name = 'THERESA'
AND last_name = 'WATSON';

create view staff_sales as
select staff_id, cast(payment_date as DATE), count(payment_id), sum(amount)
from payment 
where staff_id in
	(
	select staff_id from staff
	where first_name = 'Mike'
	AND last_name = 'Hillyer'
	)
group by staff_id, cast(payment_date as DATE);

select * from staff_sales


