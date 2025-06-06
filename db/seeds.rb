# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "🔥 Seeding tutor's availabilities..."

# 기존 데이터 삭제
Tutor.delete_all
Availability.delete_all

# 튜터 생성
tutor = Tutor.create!(name: "김문원")

# 기간 설정
start_date = Date.today
end_date = start_date + 30.days

# 시간대 후보 (10:00 ~ 18:00)
hours = (10..17).to_a
minutes = [0, 30]

(start_date..end_date).each do |date|
  # 하루에 1~3개의 수업 가능 시간 생성
  rand(1..3).times do
    hour = hours.sample
    min = minutes.sample
    start_time = Time.zone.local(date.year, date.month, date.day, hour, min)

    # 중복 방지
    unless tutor.availabilities.exists?(start_time: start_time)
      tutor.availabilities.create!(start_time: start_time)
    end
  end
end

puts "✅ Tutor 및 수업 가능 시간 등록 완료!"
