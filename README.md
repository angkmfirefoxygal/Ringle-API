# 🎓 Ringle-API

학생(Student)과 튜터(Tutor)의 1:1 수업 예약을 위한 RESTful API 서비스입니다.  
Rails 기반으로 설계되었으며, 수업 가능 시간 등록 및 수강 신청 기능을 포함합니다.

---

## 🚀 기능 개요

- 학생 및 튜터 등록
- 튜터 수업 가능 시간 등록 / 삭제
- 수업 가능한 시간대 및 튜터 조회
- 학생의 수업 신청 / 조회

---

## 🏗️ 기술 스택

| 항목 | 내용 |
|------|------|
| Framework | Ruby on Rails 8 (API 모드) |
| Language | Ruby 3.2 |
| DB | SQLite3 (개발환경) |
| Tooling | curl, GitHub Issues/PR, Git branching |

---

## 📂 DB 모델 구조

- `Student` (name)
- `Tutor` (name)
- `Availability` (tutor_id, start_time)
- `Enrollment` (student_id, tutor_id, start_time, duration)

모델 간 관계:

```ruby
Student has_many :enrollments  
Tutor has_many :availabilities, :enrollments  
Availability belongs_to :tutor  
Enrollment belongs_to :student, :tutor
