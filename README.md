# GGUK (꾹)

**감정을 눌러 담는 iOS 습관 기록 앱**

> “빡칠 때마다, 버튼을 눌러주세요.”

---

## 📱 프로젝트 소개

**GGUK**은 일상에서 느끼는 분노나 스트레스를  
**‘참은 횟수’라는 단순한 행동 기록**으로 전환하는 iOS 토이 앱입니다.

버튼을 누르는 행위를 통해 감정을 즉각적으로 해소하고,  
누적된 기록을 통해 **스스로의 인내를 시각적으로 인식**할 수 있도록 설계했습니다.

본 프로젝트는 기능 완성도보다는  
**RxSwift, Realm, SnapKit, Supabase 등 다양한 기술을 실제 앱 흐름 속에서 학습·적용하는 것**을 목표로 한 개인 학습용 토이 프로젝트입니다.

---

## 👤 개발 인원

- iOS 1인 개발

---

## 🧭 앱 성격 / 목적

- iOS 토이 앱 (감정 / 습관 기록)
- 기술 학습 중심 프로젝트
- UI 구성, 데이터 흐름, 인증 처리까지  
  **실서비스 구조를 간단히 경험하는 것을 목표로 함**

---

## 🛠 기술 스택

### iOS / UI
- UIKit
- SnapKit  
  - Storyboard 없이 코드 기반 AutoLayout 구성
  - 모든 화면을 SnapKit으로 레이아웃 구현

### Reactive / Data Flow
- RxSwift / RxCocoa
  - 버튼 탭 이벤트 처리
  - 상태 관리 (`BehaviorRelay`)
  - UI ↔ 상태 흐름을 선언적으로 구성

### Local Persistence
- Realm
  - 버튼 탭 누적 횟수 로컬 저장
  - 앱 종료 후에도 상태 유지
  - 간단한 데이터 접근 레이어 구성

### Backend / Auth
- Supabase
  - Email / Password 로그인
  - Apple OAuth 로그인
  - 세션 기반 자동 로그인
  - 사용자 이메일 중복 체크

### Async / Concurrency
- Swift Concurrency (`asyn
