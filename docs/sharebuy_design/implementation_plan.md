# ShareBuy (うちメモ) 実装計画 & 設計書

## 目標
家族共有買い物メモアプリ「うちメモ (ShareBuy)」のMVP実装．
スマートで見やすいUIと、リアルタイム同期・オフライン対応を備えたFlutterアプリを量産テンプレートベースで構築する．
├── main.dart              # Entry point
├── app.dart               # App Widget (Theme, Router)
├── core/                  # 共通基盤
│   ├── config/            # 定数, Env
│   ├── theme/             # AppTheme, ThemeExtension (Smart/Pop)
│   ├── router/            # GoRouter definition
│   ├── utils/             # Helpers (Date, String, Validations)
│   └── widgets/           # Common Widgets (AppButton, AppCard, ErrorView)
├── features/
### 手動検証
- スキン切り替えの即時反映
- オフラインにしてアイテム追加 -> オンライン復帰で同期確認
- 削除 -> スナックバーUndoが動作すること
