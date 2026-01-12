-- Pivoting

CREATE TABLE pizza_table(
    category VARCHAR(50),
    crust_type VARCHAR(50),
    pizza_name VARCHAR(100),
    price DECIMAL(5, 2)
    );

INSERT INTO pizza_table (category, crust_type, pizza_name, price) VALUES
( 'Chicken', 'Gluten-Free Crust', 'California Chicken', 21.75),
( 'Chicken', 'Thin Crust', 'Chicken Pesto', 20.75),
( 'Classic', 'Standard Crust', 'Greek',  21.50),
( 'Classic', 'Standard Crust', 'Hawaiian', 19.50),
( 'Classic','Standard Crust', 'Pepperoni', 18.95),
( 'Supreme','Standard Crust', 'Spicy Italian', 22.75),
( 'Veggie', 'Thin Crust', 'Five Cheese', 19.50 ),
( 'Veggie','Thin Crust', 'Margherita', 19.50),
( 'Veggie','Gluten-Free Crust','Garden Delight', 21.50);

-- View the Pizza table
SELECT * FROM pizza_table;

-- Create 1/0 columns
SELECT 
    crust_type,
    CASE WHEN crust_type = 'Standard Crust' THEN 1 ELSE 0 END AS standard_crust,
    CASE WHEN crust_type = 'Thin Crust' THEN 1 ELSE 0 END AS thin_crust,
    CASE WHEN crust_type = 'Gluten-Free Crust' THEN 1 ELSE 0 END AS gluten_free_crust
FROM pizza_table;

SELECT 
    category,
    sum(CASE WHEN crust_type = 'Standard Crust' THEN 1 ELSE 0 END) AS standard_crust,
    sum(CASE WHEN crust_type = 'Thin Crust' THEN 1 ELSE 0 END) AS thin_crust,
    sum(CASE WHEN crust_type = 'Gluten-Free Crust' THEN 1 ELSE 0 END) AS gluten_free_crust
FROM pizza_table
GROUP BY category;

SELECT
        sg.department,
        ROUND(AVG(CASE WHEN s.grade_level = 9 THEN sg.final_grade END),0) AS Freshman,
        ROUND(AVG(CASE WHEN s.grade_level = 10 THEN sg.final_grade END),0) AS Sophmore,
        ROUND(AVG(CASE WHEN s.grade_level = 11 THEN sg.final_grade END),0) AS Junior,
        ROUND(AVG(CASE WHEN s.grade_level = 12 THEN sg.final_grade END),0) AS Senior
FROM student_grades as sg
LEFT JOIN students as s
ON sg.student_id = s.id
GROUP BY sg.department
ORDER BY sg.department, Freshman, Sophmore, Junior, Senior;