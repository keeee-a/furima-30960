class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '衣服' },
    { id: 3, name: '本' },
    { id: 4, name: '電子機器' },
    { id: 5, name: '家具' },
    { id: 6, name: 'その他' }

  ]

  include ActiveHash::Associations
  has_many :items
end
