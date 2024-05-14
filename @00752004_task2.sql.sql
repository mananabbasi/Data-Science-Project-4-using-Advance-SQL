Create Database FoodserviceDB;

USE FoodserviceDB; 
GO

ALTER TABLE dbo.consumers
Add Primary key (Consumer_ID);

ALTER TABLE dbo.restaurants
Add Primary key (Restaurant_ID);

ALTER TABLE dbo.restaurants
ADD UNIQUE (Restaurant_ID);

ALTER TABLE dbo.ratings
Add Primary key (Consumer_ID , Restaurant_ID);

ALTER TABLE dbo.ratings
ADD FOREIGN KEY (Restaurant_ID) REFERENCES dbo.restaurants(Restaurant_ID);

ALTER TABLE dbo.ratings
ADD FOREIGN KEY (Consumer_ID) REFERENCES dbo.consumers(Consumer_ID);

ALTER TABLE dbo.restaurant_cuisines
ADD FOREIGN KEY (Restaurant_ID) REFERENCES dbo.restaurants(Restaurant_ID);



--Write a query that lists all restaurants with a Medium range price with open area, serving Mexican food.


Select * from dbo.restaurants a inner join dbo.restaurant_cuisines b  on
a.Restaurant_ID = b.Restaurant_ID
where a.Price = 'Medium' and a.Area = 'Open' and b.Cuisine = 'Mexican'



 --Write a query that returns the total number of restaurants who have the overall rating  as 1 and are serving Mexican food. Compare the results with the total number of  restaurants who have the overall rating as 1 serving Italian food (please give explanations on their comparison

--Part 1 for Mexico
-- using distinct to get the distinct number 
SELECT COUNT(DISTINCT r.Restaurant_ID)
FROM dbo.ratings r
INNER JOIN dbo.restaurant_cuisines c ON r.Restaurant_ID = c.Restaurant_ID
WHERE r.Overall_Rating = 1 AND c.Cuisine = 'Mexican';


--Part 2 for Italian

SELECT COUNT(DISTINCT r.Restaurant_ID)
FROM dbo.ratings r
INNER JOIN dbo.restaurant_cuisines c ON r.Restaurant_ID = c.Restaurant_ID
WHERE r.Overall_Rating = 1 AND c.Cuisine = 'Italian';



--Calculate the average age of consumers who have given a 0 rating to the 'Service_rating'column. (NB: round off the value if it is a decimal)

SELECT ROUND(AVG(r.age), 0) AS average_age
FROM dbo.consumers r
INNER JOIN dbo.ratings s ON r.Consumer_ID = s.Consumer_ID
WHERE s.Service_rating = 0;


--Write a query that returns the restaurants ranked by the youngest consumer. You should include the restaurant name and food rating that is given by that customer to the restaurant in your result. Sort the results based on food rating from high to low.
FROM consumers s
INNER JOIN ratings r ON s.Consumer_ID = r.Consumer_ID
INNER JOIN restaurants t ON r.Restaurant_ID = t.Restaurant_ID
WHERE s.Age IN (SELECT MIN(Age) FROM consumers)
ORDER BY r.Food_Rating DESC;
SET Service_rating  = '2'
WHERE Restaurant_ID IN  (Select T.Restaurant_ID
Nested queries-EXISTS
Nested queries-IN
System functions
Use of GROUP BY, HAVING and ORDER BY clauses
FROM consumers;

SELECT Age, COUNT(DISTINCT Consumer_ID) AS TotalConsumer
FROM consumers
WHERE Age > 60
GROUP BY Age
ORDER BY COUNT(DISTINCT Consumer_ID) DESC;