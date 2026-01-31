# GGUK（꾹）

**感情を“押し込めて”記録する iOS 習慣トラッキングアプリ**

---

## 📱 プロジェクト紹介

**GGUK** は、日常で感じる怒りやストレスを

**「我慢した回数」というシンプルな行動記録**へと変換する

iOS トイアプリです。

ボタンを押すという行為を通じて感情を即座に発散し、

蓄積された記録によって

**自分自身の忍耐を視覚的に認識できる**よう設計しました。

---

## 🧭 アプリの性格 / 目的

- iOS トイアプリ（感情 / 習慣記録）
- **技術学習を目的としたプロジェクト**
- UI 構成、データフロー、認証処理まで
    
    **実サービス構成を軽く体験すること**を目的としています
    

---

## 🛠 技術スタック

### iOS / UI

- **UIKit**
- **SnapKit**
    
    → コードベースで AutoLayout を構築
    
    → すべての画面を Storyboard なしで実装
    

### Reactive / Data Flow

- **RxSwift / RxCocoa**
    - ボタンタップイベントの処理
    - UI 状態バインディング（`BehaviorRelay`）
    - View ↔ 状態の流れを宣言的に構成

### Local Persistence

- **Realm**
    - ボタンタップ回数のローカル保存
    - アプリ終了 / 再起動後も状態を保持
    - Singleton 形式のシンプルなデータアクセスレイヤーを構成

### Backend / Auth

- **Supabase**
    - Email / Password ログイン
    - Apple OAuth ログイン
    - セッションベースの自動ログイン処理
    - ユーザー重複チェック（users テーブル参照）

### Async / Concurrency

- **Swift Concurrency（`async / await`）**
    - Supabase Auth / DB 呼び出し
    - ログイン、会員登録、ログアウトフローの非同期処理

---

## 🧩 アーキテクチャ設計

### 基本構成

- **UIKit + MVVM**
- ViewController は UI とイベント伝達を担当
- ViewModel はビジネスロジックとデータアクセスを担当

```
ViewController
 └─ ViewModel
     └─ SupabaseManager / RealmFunc

```

### 特徴

- 画面単位で ViewModel を分離
- ネットワーク / ローカル保存ロジックを VC から分離

---

## 🔐 認証 & アプリフロー

### アプリ起動フロー

1. `SplashVC`
2. Supabase セッションの有効性チェック
3. ログイン状態に応じて Root を切り替え
    - ログイン済み → Main
    - 未ログイン → SignIn

### Root 切り替え

- `AppRouter` による **RootViewController の差し替え**
- ログイン / ログアウト時に画面スタックを初期化

---

## 🔄 RxSwift 適用例

- ボタンタップ → 状態増加
- 状態変化 → UI に自動反映

```swift
touchButton.rx.tap
    .withLatestFrom(countRelay)
    .map {$0+1 }
    .bind(to: countRelay)

```

- UI イベント、状態、保存ロジックを分離し、
    
    **「イベント → 状態 → 表現」** の流れを明確化
    

---

## 💾 Realm 使用意図

- シンプルな累積データであっても
    - アプリ終了後も保持
    - 他画面（統計）で再利用
- Realm を通じて
    - ローカル DB モデル定義
    - グローバル状態管理のメリット / デメリットを体感

---

## ✨ 学んだこと / 振り返り

- RxSwift を単なる文法ではなく
    
    **状態フローの観点**で理解できた
    
- ViewController の肥大化問題を
    
    MVVM 分離によって実感
    
- SnapKit を用いたコードベース UI 構築に習熟
- Supabase を通じた認証、セッション管理、OAuth ハンドリングの経験
