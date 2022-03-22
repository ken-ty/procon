# Change Log
このプロジェクトに対するすべての注目すべき変更は、このドキュメントに示されます。

このドキュメントは [Keep a Changelog](http://keepachangelog.com/) に従います。
このプロジェクトは [Semantic Versioning](http://semver.org/) に準拠していません。

| Group | 説明 |
| --- | --- |
| Added | 新機能について |
| Changed | 既存機能の変更について |
| Deprecated | 間もなく削除される機能について |
| Removed | 今回で削除された機能について |
| Fixed | バグ修正について |
| Security | 脆弱性に関する場合 |

## [Unreleased]
- なし
## [0.1.2] - 2022-03-22
### Added
- ロゴを追加しました！
## [0.1.1] - 2022-03-21
### Removed
- `npm run init` を削除
- `npm run start` を削除
## [0.1.0] - 2022-03-21
### Changed
- サンプルが`sample.py`→`npm run sample-setup` に変更
- 回答環境構築コマンドを`npm run create`→`npm run template`に変更
- READMEを更新
- ライセンスが `no lisence`→`MIT lisence` に変更
### Added
- 楽にテスト実行できる`npm run test WORK_NAME`を追加
- テンプレート作成時に利用言語とテストファイル数の選択を追加

### Removed
- `npm run start` で コンテナ内でスクリプト実行する機能を凍結しました。テストが楽にできることに重きを置く。今後復活させたい。

## [0.0.3] - 2022-03-16
### Changed
- npmパッケージ化
- ディレクトリ構造を変更
- README npmパッケージ化に伴い、npm scripts として実行する手順を記載
### Added
- CHANGELOG 変更ログを残す。
- create.sh これは作業フォルダを作成する。スクリプトファイルに加え、testフォルダも追加される。
## [0.0.2] - 2021-08-26
### Added
- run.sh の対応言語に `python2`, `php7.4` を追加
## 0.0.1 - 2021-08-16
### Added
- procon: python3 スクリプトをコンテナで実行する `run.sh` を追加

[Unreleased]: https://github.com/ken-ty/procon/compare/v0.1.2...HEAD?w=1
[0.1.2]: https://github.com/ken-ty/procon/compare/v0.1.1...v0.1.2?w=1
[0.1.1]: https://github.com/ken-ty/procon/compare/v0.1.0...v0.1.1?w=1
[0.1.0]: https://github.com/ken-ty/procon/compare/v0.0.3...v0.1.0?w=1
[0.0.3]: https://github.com/ken-ty/procon/compare/v0.0.2...v0.0.3?w=1
[0.0.2]: https://github.com/ken-ty/procon/compare/v0.0.1...v0.0.2?w=1
