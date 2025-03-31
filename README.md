# yu-n8n-core
A personal n8n infrastructure and automation toolkit by YuHan.

This project provides a clean, Docker-based n8n environment setup, including:

- Workflow and credentials export/import scripts
- Backup automation
- .env-based configuration
- Optional Nginx setup for domain + HTTPS deployment

## 🚀 Quick Start
```bash
docker-compose up -d
```

## 🧰 Scripts
- `scripts/export-all.sh`: Export workflows + credentials
- `scripts/import-all.sh`: Import all JSON workflows/credentials
- `scripts/backup.sh`: Timestamped backups

## 📦 AWS Deployment Ready
- Suitable for deploying to AWS EC2 with optional Nginx/SSL
- Just `git clone`, adjust `.env`, and `docker-compose up`!

---
## 🗓️ 實際工作流建議
1️⃣ 開發流程：n8n UI 中建立/修改 workflow
2️⃣ 改完 → 執行 export-all.sh 匯出成 JSON（放進 workflows/）
3️⃣ Git commit + push（專案更新）
4️⃣ 需要部署新環境時 → 執行 import-all.sh 還原所有流程
5️⃣ 每天自動跑 backup.sh 備份 workflows（到 backups/資料夾）


---
yu-n8n-core/
├── docker-compose.yml                # Docker 部署設定
├── .env                               # 環境變數設定（帳號、密碼、主機）
├── workflows/                        # 匯出的 workflows JSON
│   └── example-flow.json
├── credentials/                      # 匯出的 credentials（建議加入 .gitignore）
├── backups/                          # 自動備份工作流程與認證
├── scripts/                          # 所有自動化腳本
│   ├── backup.sh                     # 匯出 workflows + credentials 並存檔
│   ├── import-all.sh                 # 匯入全部 workflows/credentials
│   └── export-all.sh                 # 匯出全部 workflows/credentials
├── nginx/                            # （選配）Nginx + SSL 設定檔備用資料夾
│   └── default.conf
├── .gitignore                        # 忽略敏感檔案與暫存資料夾
├── LICENSE                           # 專案授權條款（MIT）
└── README.md                         # 專案簡介與部署說明

---
👤 n8n 使用者帳號（v1.0 之後必須有）
這是你一開始啟動 n8n 時建立的「使用者帳號」，用來登入 n8n UI、管理 workflow。

✅ 為了安全、審計、多人協作（這是核心帳號）

✅ 每個 workflow 都是「某個使用者」的資產

✅ 這是 內建在 n8n 本體裡的認證機制

✅ 必須登入後才能操作任何東西（無 UI 沒有任何權限）

🔐 .env 裡的 N8N_BASIC_AUTH_USER 是什麼？
這是「啟動 n8n UI 之前的額外保護」，它是個選配功能，稱作：

Basic Auth：給部署者一層入口保護，避免 UI 對外直接暴露

✅ 用處是什麼？
假設你把 n8n 部署到 AWS、綁了網域、開了 5678 port
→ 沒有這層 Basic Auth，任何人只要知道網址，就可以看到登入頁面，甚至暴力破解帳號密碼

如果你加了 Basic Auth，那別人一進網址會先看到「🔒 需要帳密登入」

第一層門：Basic Auth

第二層門：n8n 使用者登入


✅ 實用場景舉例：
場景	用法
你在 AWS 部署了 n8n	加一層 Basic Auth 保護公網 UI
團隊成員共享 Basic Auth 帳密	但登入時使用各自 n8n 帳號
不同 workflow 擁有不同 user	workflow 還是分明、可以控權限
