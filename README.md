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

```
ruby
Student has_many :enrollments  
Tutor has_many :availabilities, :enrollments  
Availability belongs_to :tutor  
Enrollment belongs_to :student, :tutor

```

## 🧪 API 테스트 시나리오 (curl)

튜터와 학생이 seed에 미리 등록되어 있으며, 아래와 같이 실제 수업 예약 흐름을 curl로 테스트할 수 있습니다.

---

### 🧑‍🏫 튜터 기본 정보 (seed 등록됨)

- `tutor_id`: **7**
- `name`: `"김문원"`

### 👩‍🎓 학생 정보 (seed 등록됨)

- `student_id`: **2** (`김여원`)
- `student_id`: **3** (`김강원`)

---

### ✅ 1. 수업 가능한 시간대 조회

```
curl -s "http://localhost:3000/api/v1/available_slots?start_date=2025-06-07&end_date=2025-06-10&duration=30" | jq
```

📌 응답 예시:
```json
[
  { "start_time": "2025-06-07T00:00:00.000+09:00" },
  { "start_time": "2025-06-08T00:00:00.000+09:00" }
]
```

---

### ✅ 2. 해당 시간에 가능한 튜터 조회

```
curl -s "http://localhost:3000/api/v1/available_tutors?start_time=2025-06-07T00%3A00%3A00&duration=30" | jq
```

📌 응답 예시:
```json
[
  { "id": 7, "name": "김문원" }
]
```

---

### ✅ 3. 수업 신청

```
curl -X POST http://localhost:3000/api/v1/enrollments \
  -H "Content-Type: application/json" \
  -d '{
    "student_id": 2,
    "tutor_id": 7,
    "start_time": "2025-06-07T00:00:00+09:00",
    "duration": 30
  }' | jq
```

📌 응답 예시:
```json
{
  "id": 1,
  "student_id": 2,
  "tutor_id": 7,
  "start_time": "2025-06-07T00:00:00.000+09:00",
  "duration": 30
}
```

---

### ✅ 4. 특정 학생의 수업 신청 내역 조회

```
curl -s http://localhost:3000/api/v1/students/2/enrollments | jq
```

📌 응답 예시:
```json
[
  {
    "id": 1,
    "student_id": 2,
    "tutor_id": 7,
    "start_time": "2025-06-07T00:00:00.000+09:00",
    "duration": 30
  }
]
```

