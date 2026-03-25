# Fat Loss Pro - B2B2C Coaching SaaS

### Status: 🚧 Work In Progress (Phase 2)

### 📖 [詳細技術文件與開發決策請參考專案 Wiki](https://github.com/srichsun/fatloss-pro-saas/wiki)

-----

### 🚀 專案願景 (Project Vision)

Fat Loss Pro 是一個專為「健身教練與個人工作室」打造的訂閱制管理平台。採用 **B2B2C (Business-to-Business-to-Consumer)** 架構，讓教練能擁有獨立的數位教室，向學員銷售減脂課程並追蹤健康數據。

### 🛠️ 技術選型與核心理念 (Technical Stack & Philosophy)

本專案採用 **Rails 8 (Main Branch)** 架構，專注於「極簡基礎設施、高性能、高安全性」。

  * **Rails 8 "Postgres-only" Stack**: 採用 `Solid Queue` 與 `Solid Cache`，移除對 Redis 的依賴，降低運維複雜度。
  * **Multi-tenancy Isolation**: 透過 `tenant_id` 與 Controller Scoping 實作資料隔離，杜絕 **IDOR (Insecure Direct Object Reference)** 漏洞。
  * **Hand-rolled Auth**: 捨棄 Devise，改採 `has_secure_password` 實作輕量化、高主導權的身份驗證流程。
  * **Modern Frontend**: 結合 **Tailwind CSS** 與 **Hotwire (Turbo/Stimulus)**，提供 SPA 等級的流暢體驗。

-----

### 🚀 技術亮點 (Technical Highlights)

#### 1\. 資料隔離與安全性 (Row-Level Isolation)

  * **Scoped Querying**: 在 Controller 層級封裝 `current_tenant` 邏輯，所有資料查詢皆從租戶出發，從底層防止跨租戶存取風險。
  * **Transactional Setup**: 在教練註冊時，使用 **Transaction** 確保 `Tenant`（組織）與 `User`（管理員）同時建立成功。

#### 2\. 金流與訂單自動化 (Automation)

  * **Precision Handling**: 使用 Rails `Attributes API` 處理金融金額，確保運算精確度。
  * **Idempotency & Webhooks**: 整合 **Stripe API**，利用 Webhook 實作冪等性機制，確保自動化扣款與訂單狀態同步的準確性。

-----

### 📈 開發進度 (Roadmap)

#### **Phase 1: SaaS Foundation (Completed)**

  - [x] **Multi-tenant Architecture**: 實作 `Tenant` 與 `User` 的關聯與資料隔離牆。
  - [x] **Custom Auth System**: 實作基於 Session 的輕量化驗證邏輯。
  - [x] **Security Scoping**: 在 `ApplicationController` 強制執行租戶檢查與 RSpec 驗證。

#### **Phase 2: Financial Integrity (In Progress)**

  - [x] **Automated Order System**: 建立教練開單與學員加入流程。
  - [ ] **Stripe Integration**: 實作自動化支付與 Webhook 狀態監聽。
  - [ ] **Service Objects**: 封裝 `Orders::PlaceOrderService` 確保交易原子性。

#### **Phase 4: Real-time Data & Analytics (Planning)**

  - [ ] **Health Dashboard**: 利用 Turbo Streams 實作無刷新體重追蹤圖表。
  - [ ] **Data Visualization**: 導入 Chart.js 展示教練營收與學員進度。

-----

### 🛡️ 相關技術文件 (Documentation)

本專案的深度設計細節已記錄於 Wiki：

  * [📌 資料庫 Schema 設計] (待補：預計於 Phase 2 模型穩定後更新)
  * [📌 API 整合與 Webhook 說明] (待補：Stripe 實作測試完成後更新)

-----

### ⚡ 快速啟動 (Quick Start)

#### 1\. 啟動環境

確保你的電腦已安裝 PostgreSQL。

```bash
# Clone the repository
git clone [your-repo-link]
cd fat_loss_pro

# Install dependencies
bundle install

# Setup database
bin/rails db:prepare

# Start development server (Rails + Tailwind + CSS Watch)
bin/dev
```

#### 2\. 執行測試 (Running Tests)

```bash
bundle exec rspec
```

