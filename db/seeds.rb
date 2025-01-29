require 'faker'

# ランダムな求人情報を生成
50.times do
  Job.create(
    title: Faker::Job.title,
    location: Faker::Address.city,
    salary: "#{rand(300..800)}万円",
    company: Faker::Company.name
  )
end
