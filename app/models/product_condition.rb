class ProductCondition < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '新品' },
    { id: 3, name: '中古' },
    { id: 4, name: 'キズ有り' }
  ]
end
