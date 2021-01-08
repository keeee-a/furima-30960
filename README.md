# テーブル設計

## users テーブル
|Column              |Type         |Options                    |
|--------------------|-------------|---------------------------|
|first_name          |string       |null:false                 |
|last_name           |string       |null:false                 |
|first_name_kana     |string       |null:false                 |
|last_name_kana      |string       |null:false                 |
|email               |string       |null:false, unique: true   |
|nickname            |string       |null:false                 |
|encrypted_password  |string       |null:false                 |
|birthday            |date         |null:false                 |

### Association
has_one :street_address
has_many :products
has_many :purchases


## products テーブル
|Column               |Type            |Options       |
|---------------------|----------------|--------------|
|name                 |string          |null:false    |
|category_id          |integer         |null:false    |
|price                |integer         |null:false    |
|explanation          |text            |null:false    |
|product_condition_id |integer         |null:false    |
|burden_shipping_id   |integer         |null:false    |
|shipping_area_id     |integer         |null:false    |
|days_to_ship_id      |integer         |null:false    |
|user_id              |integer         |null:false    |

### Association
belongs_to :user
has_one :purchase

## purchases テーブル
|Column               |Type            |Options           |
|---------------------|----------------|------------------|
|user_id              |integer         |null:false        |
|product_id           |integer         |null:false        |

### Association
belongs_to :product
belongs_to :user


## street_addresses テーブル
|Column               |Type            |                   |
|---------------------|----------------|-------------------|
|postal_code          |integer         |null:false         |
|prefecture_id        |integer         |null:false         |
|city                 |string          |null:false         |
|address              |string          |null:false 


