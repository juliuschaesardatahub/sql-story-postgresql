-- Exercise 04: Database Objects
-- Write your answers below each question.

-- 1. Create a function named get_sales_by_category(p_category VARCHAR)
--    that returns order_id, order_date, product_name, sales, and profit
--    for rows in the requested category, ordered by order_date and order_id.

-- 2. Create a procedure named refresh_region_sales_summary()
--    that rebuilds a table called region_sales_summary with:
--    region, total_sales, total_profit, total_orders.

-- 3. Create an index on superstore(customer_id) and another on superstore(region, order_date).

-- 4. Create a view named vw_customer_order_summary that returns:
--    customer_id, customer_name, total_orders, total_sales, total_profit.

-- 5. Create a materialized view named mv_sales_by_state that returns:
--    state, region, total_sales, total_profit.
--    Then refresh it.

-- 6. Create an audit table for updates named superstore_update_audit,
--    then create a trigger that logs row_id, action_type, and changed_at
--    whenever a row in superstore is updated.
