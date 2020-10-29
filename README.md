# README

Микросервис работы складов. Продукты могут находиться на складе, переезжать со склада на склад, реализовываться. 
Сущности:
- Склад (название, адрес, баланс)
- Продукт (название, количество, цена, склад)

# Setup & start
rvm install 2.7.1
<br/>
rvm use 2.7.1
<br/>
bundle install
<br/>
rake db:migrate
<br/>
rake db:seed
<br/>
rails s

# Endpoints:

- реализация продукта. Продукт могут купить в любом количестве. Сумма проданных продуктов поступает на баланс склада.
PUT /sell {product_id: integer, count: integer}
Пример: curl -d "id=1&count=1" -X PUT http://localhost:3000/sell
<br/><br/>

- перенос продукта со склада на склад. Перенести можно как весь товар целиком, так и указанное количество;
PUT /transfer {warehouse_1: integer, warehouse_2: integer, product_id: integer, count: integer}
Пример: curl -d "warehouse_from_id=1&warehouse_to_id=2&product_id=1&count=1" -X PUT http://localhost:3000/transfer

