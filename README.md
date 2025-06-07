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

## API Endpoints

아래는 `/api/v1` 네임스페이스에 정의된 주요 엔드포인트 목록입니다.

### POST /api/v1/availabilities (`AvailabilitiesController#create`)
- **Params**: `tutor_id`, `start_time`
- **Response**: 생성된 `Availability` JSON
```bash
curl -X POST /api/v1/availabilities \
  -d tutor_id=7 -d start_time="2025-06-05T10:00"
```

### DELETE /api/v1/availabilities/:id (`AvailabilitiesController#destroy`)
- **Params**: `id` (path)
- **Response**: `204 No Content`

### GET /api/v1/available_slots (`SlotsController#index`)
- **Params**: `start_date`, `end_date`, `duration`
- **Response**: 가능한 시작 시간 배열 JSON
```bash
curl "./api/v1/available_slots?start_date=2025-06-05&end_date=2025-06-10&duration=30"
```

### GET /api/v1/available_tutors (`SlotsController#available_tutors`)
- **Params**: `start_time`, `duration`
- **Response**: 가능한 튜터 목록 JSON

### POST /api/v1/enrollments (`EnrollmentsController#create`)
- **Params**: `student_id`, `tutor_id`, `start_time`, `duration`
- **Response**: 생성된 `Enrollment` JSON
```bash
curl -X POST /api/v1/enrollments \
  -d student_id=2 -d tutor_id=7 \
  -d start_time="2025-06-05T10:00" -d duration=30
```

### GET /api/v1/students/:id/enrollments (`EnrollmentsController#index`)
- **Params**: `id` (path)
- **Response**: 해당 학생의 수강 신청 목록 JSON

## 🧪 API 테스트 시나리오 (curl & postman)

튜터와 학생이 seed에 미리 등록되어 있으며, 아래와 같이 실제 수업 예약 흐름을 curl로 테스트할 수 있습니다. <br>
curl 명령어로 테스트 진행한 이후, postman을 통한 최종 테스트도 완료하였습니다. 

---

### 🧑‍🏫 튜터 기본 정보 (seed 등록됨)

- `tutor_id`: **7**
- `name`: `"김문원"`

### 👩‍🎓 학생 정보 (seed 등록됨)

- `student_id`: **2** (`김여원`)
- `student_id`: **3** (`김강원`)

---
