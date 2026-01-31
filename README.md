# GGUK (꾹)

**감정을 눌러 담는 iOS 습관 기록 앱**

---

## 📱 프로젝트 소개

**GGUK**은 일상에서 느끼는 분노나 스트레스를

**‘참은 횟수’라는 단순한 행동 기록**으로 전환하는 iOS 토이 앱입니다.

버튼을 누르는 행위를 통해

감정을 즉각적으로 해소하고,

누적된 기록을 통해 **스스로의 인내를 시각적으로 인식**할 수 있도록 설계했습니다.

---

## 🧭 앱 성격 / 목적

- iOS 토이 앱 (감정 / 습관 기록)
- **기술 학습 중심 프로젝트**
- UI 구성, 데이터 흐름, 인증 처리까지 **실서비스 구조를 가볍게 경험**하는 것을 목표로 함

---

## 🛠 기술 스택

### iOS / UI

- **UIKit**
- **SnapKit**
    
    → 코드 기반 AutoLayout 구성
    
    → 모든 화면을 Storyboard 없이 구현
    

### Reactive / Data Flow

- **RxSwift / RxCocoa**
    - 버튼 탭 이벤트 처리
    - UI 상태 바인딩 (`BehaviorRelay`)
    - View ↔ 상태 흐름을 선언적으로 구성

### Local Persistence

- **Realm**
    - 버튼 탭 누적 횟수 로컬 저장
    - 앱 종료/재실행 후에도 상태 유지
    - Singleton 형태의 간단한 데이터 접근 레이어 구성

### Backend / Auth

- **Supabase**
    - Email / Password 로그인
    - Apple OAuth 로그인
    - 세션 기반 자동 로그인 처리
    - 사용자 중복 체크 (users 테이블 조회)

### Async / Concurrency

- **Swift Concurrency (`async / await`)**
    - Supabase Auth / DB 호출
    - 로그인, 회원가입, 로그아웃 플로우 비동기 처리

---

## 🧩 아키텍처 설계

### 기본 구조

- **UIKit + MVVM**
- ViewController는 UI와 이벤트 전달 역할
- ViewModel은 비즈니스 로직과 데이터 접근 담당

```
ViewController
 └─ ViewModel
     └─ SupabaseManager / RealmFunc

```

### 특징

- 화면 단위로 ViewModel 분리
- 네트워크 / 로컬 저장소 로직을 VC에서 분리

---

## 🔐 인증 & 앱 흐름

### 앱 시작 흐름

1. `SplashVC`
2. Supabase 세션 유효성 검사
3. 로그인 상태에 따라 Root 전환
    - 로그인 O → Main
    - 로그인 X → SignIn

### Root 전환

- `AppRouter`를 통한 **RootViewController 교체**
- 로그인 / 로그아웃 시 화면 스택 초기화

---

## 🔄 RxSwift 적용 예시

- 버튼 탭 → 상태 증가
- 상태 변화 → UI 자동 반영

```swift
touchButton.rx.tap
    .withLatestFrom(countRelay)
    .map {$0+1 }
    .bind(to: countRelay)

```

- UI 이벤트, 상태, 저장 로직을 분리해
    
    **“이벤트 → 상태 → 표현” 흐름을 명확히함**
    

---

## 💾 Realm 사용 의도

- 간단한 누적 데이터라도
    - 앱 종료 후 유지
    - 다른 화면(통계)에서 재사용
- Realm을 통해
    - 로컬 DB 모델 정의
    - 전역 상태 관리의 장단점 체감

---

## ✨ 배운 점 / 느낀 점

- RxSwift를 단순 문법이 아니라 **상태 흐름 관점**에서 이해하게 됨
- ViewController가 비대해지는 문제를 MVVM으로 분리하며 체감
- SnapKit을 사용한 코드 기반 UI 구성에 익숙해짐
- Supabase를 통해
    - 인증
    - OAuth
    - 세션 관리
        
        를 실제 앱 흐름에 연결해봄
