Admin.find_or_create_by!(email: '1@1') do |admin|
  admin.email='1@1'
  admin.password='111111'
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
genre = Genre.find_or_create_by!(
  name: "肉"
)
genre = Genre.find_or_create_by!(
  name: "魚"
)
genre = Genre.find_or_create_by!(
  name: "卵"
)
genre = Genre.find_or_create_by!(
  name: "パン"
)
genre = Genre.find_or_create_by!(
  name: "麺"
)

camptaro = Customer.find_or_create_by!(email: "camptaro@example.com") do |customer|
  customer.name = "キャンプ太郎"
  customer.password = "password"
  customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

yamachan = Customer.find_or_create_by!(email: "yamachan@example.com") do |customer|
  customer.name = "やまちゃん"
  customer.password = "password"
  customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

tanacamp = Customer.find_or_create_by!(email: "tanacamp@example.com") do |customer|
  customer.name = "タナキャンプ"
  customer.password = "password"
  customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

maricook = Customer.find_or_create_by!(email: "maricook@example.com") do |customer|
  customer.name = "マリクック"
  customer.password = "password"
  customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")
end

takibito = Customer.find_or_create_by!(email: "takibito@example.com") do |customer|
  customer.name = "タキビト"
  customer.password = "password"
  customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.jpg"), filename:"sample-user5.jpg")
end

sorameshi = Customer.find_or_create_by!(email: "sorameshi@example.com") do |customer|
  customer.name = "そらめし"
  customer.password = "password"
  customer.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename:"sample-user6.jpg")
end
