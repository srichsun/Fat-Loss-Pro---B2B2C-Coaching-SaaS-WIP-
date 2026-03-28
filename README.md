# FlashSale Pro - High-Concurrency Influencer Launchpad

### Status: 🚧 Phase 2: High-Concurrency Core (In Progress)
Current Progress: Successfully implemented Pessimistic Locking and Redis Caching for flash sale scenarios.

### 📖 [Detailed Technical Documentation & Wiki](https://github.com/srichsun/fatloss-pro-saas/wiki)

-----

### 🚀 Project Vision (專案願景)

**Fat Loss Pro** 是一個專為健身網紅打造的「極速快閃銷售」平台。不同於一般的管理系統，本專案針對「萬人瞬間湧入搶購」的場景進行了深度優化，確保在極高併發（High-Concurrency）下，系統依然能保持**庫存精準、反應迅速、穩定不當機**。

---

### 🛠️ Technical Stack (技術選型)

* **Framework**: Rails 8.2 (Edge)
* **High-Concurrency Core**: 
    * **Database**: PostgreSQL with **Pessimistic Locking** (`SELECT ... FOR UPDATE`).
    * **Caching**: **Redis** (Cache-Aside Pattern) for high-speed inventory reads.
    * **Async Jobs**: **Active Job** (Async/Solid Queue) for non-blocking notification delivery.
* **Frontend**: **Hotwire (Turbo/Stimulus)** + **Tailwind CSS** (SPA-like performance).
* **Architecture**: **Multi-tenancy** isolation for scalable B2B2C coaching business.

-----

### 🛡️ High-Concurrency Highlights (高併發技術亮點)

#### 1. Zero-Overselling Logic (防超賣機制)
在高併發下，最怕「10 個名額賣給 11 個人」。
* **Pessimistic Locking**: 透過 `@campaign.lock!` 實作資料庫列級鎖定（Row-Level Lock），確保扣庫存的原子性 (Atomicity)。
* **Transaction Integrity**: 結合資料庫事務，確保「扣庫存」與「訂單建立」若有一方失敗則全數回滾。


#### 2. Redis Performance Optimization (效能優化)
為了保護資料庫不被瞬間讀取流量沖垮：
* **Cache-Aside Pattern**: 將剩餘庫存同步至 Redis 記憶體快取。
* **Result**: 讀取庫存的反應速度從毫秒級降至微秒級，大幅降低資料庫 I/O 負擔。


#### 3. Non-blocking Notification (響應式解耦)
下單後的收尾工作不應卡住使用者。
* **Asynchronous Processing**: 透過 `deliver_later` 將 Email 通知交由背景任務處理。
* **Responsiveness**: 確保下單主流程在 100ms 內完成回應，提升使用者體驗。

-----

### 📈 Roadmap (開發進度)

#### **Phase 1: SaaS Foundation (Completed)**
- [x] **Multi-tenant Architecture**: Tenant/User isolation walls.
- [x] **Custom Auth System**: Lightweight session-based logic.

#### **Phase 2: High-Concurrency Flash Sale (Completed)**
- [x] **Inventory Locking**: Implementation of `SELECT FOR UPDATE` logic.
- [x] **Redis Cache Layer**: High-speed stock reading strategy.
- [x] **Async Emailer**: Decoupled order confirmation workflow.

#### **Phase 3: Financial & Scaling (Planning)**
- [ ] **Stripe Integration**: Automated payment with Webhook idempotency.
- [ ] **Real-time Counter**: Live stock updates using **Turbo Streams** over WebSockets.

-----

### ⚡ Quick Start (快速啟動)

#### 1. Setup Environment
```bash
# Start Redis Service
brew services start redis

# Setup database & Migration
bin/rails db:prepare

# Enable Development Caching
bin/rails dev:cache

# Start all services (Rails + Tailwind + Worker)
bin/dev
```
