# テーブル設計

## users テーブル

|Column       |Type         |Options       |
|-------------|-------------|--------------|
|name         |string       |null:false    |
|e-mail       |string       |null:false    |
|nickname     |string       |null:false    |
|password     |string       |null:false    |
|birthday     |date         |null:false    |

## products テーブル

|Column           |Type            |Options       |
|-----------------|----------------|--------------|
|name             |string          |null:false    |
|category         |string          |null:false    |
|price            |integer         |null:false    |
|image            |                |null:false    |
|explanation      |text            |null:false    |
|product_condition|text            |null:false    |
|burden_shipping  |text            |null:false    |
|shipping_area    |text            |null:false    |
|days_to_ship     |integer         |null:false    |
