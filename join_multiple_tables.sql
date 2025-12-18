SELECT 
  ord.order_id,
  cus.name,
  DATE_FORMAT(ord.order_date,'%d-%m-%Y') AS order_date,
  ord.order_status,
  prod.product_name,
  prod.category,
  oite.item_price,
  SUM(oite.quantity) AS total_item,
  ROUND(SUM(oite.quantity * oite.item_price),2) AS revenue,
  rev.rating,
  rev.review_text
FROM orders ord
JOIN users cus ON ord.user_id = cus.user_id
JOIN order_items oite ON ord.order_id = oite.order_id
JOIN products prod ON oite.product_id = prod.product_id
LEFT JOIN reviews rev 
    ON ord.order_id = rev.order_id 
    AND oite.product_id = rev.product_id
    AND ord.order_status = 'completed'
GROUP BY ord.order_id, cus.name, ord.order_date, ord.order_status,prod.product_name,prod.category,oite.item_price;