# procon

procon は プログラミングコンテストの解答環境です。

* **クリーン:** ローカル端末を汚しません。
* **[追加予定]自動テスト:** 入出力を比較し、異なるなら差分を比較できます。

## Installation

[AtCoder](https://atcoder.jp/home) から問題をお借りして、使い方を見てみましょう。
python3 で [AtCoder Beginners Selection PracticeA - Welcome to AtCoder](https://atcoder.jp/contests/abs/tasks/practice_1?lang=ja) を解答してみます。

1. 解答環境を作成します。以下のコマンドを打ちます。

    ```
    $npm run create welcome-to-atcoder    # npm run create ${解答する問題の名前} のようにする
    ```

    すると、解答環境が作成されます。作成されたディレクトリの構成を確認します。

    ```
    $tree welcome-to-atcoder/
    welcome-to-atcoder/
    ├── test
    │   ├── 1.in                 # このファイルに入力をコピペする
    │   ├── 1.out                # このファイルに期待する出力をコピペする
    │   ├── 2.in
    │   ├── 2.out
    │   ├── 3.in
    │   └── 3.out
    └── welcome-to-atcoder.py     # このファイルに解答する
    ```

1. 解答しましょう！  welcome-to-atcoder/welcome-to-atcoder.py を好きなエディターで開いて下さい。解答スクリプトを記述します。

    ```
    # -*- coding: utf-8 -*-
    # 整数の入力
    a = int(input())
    # スペース区切りの整数の入力
    b, c = map(int, input().split())
    # 文字列の入力
    s = input()
    # 出力
    print("{} {}".format(a+b+c, s))
    ```

1. 試しに解答ファイルを実行してみましょう！以下コマンドで実行できます。

    ```
    $npm run start welcome-to-atcoder/welcome-to-atcoder.py
    ```

    実行するとコンテナが起動し、 コンテナ内で welcome-to-atcoder.py が実行されます。入力待ちになっています。以下をターミナルに貼りましょう。

    貼る内容:
    ```
    1
    2 3
    test
    ```

    結果:
    ```
    $npm run start welcome-to-atcoder/welcome-to-atcoder.py

    > procon@0.0.3 start
    > ./src/run.sh -f "welcome-to-atcoder/welcome-to-atcoder.py"

    1
    2 3
    test
    6 test
    ```

    うまくいったようです！実行終了したコンテナは既に破棄されているので、環境はクリーンな状態を保っています。

4. [追加予定]testを自動化しましょう！ 入力ファイル( 1.in, 2.in ), 出力ファイル( 1.out, 2.out )を準備します。3.in, 3.out は今回使いませんので、消してください。
    // TODO: 入出力ファイルの命名規則を書く。

    1.in
    ```
    1
    2 3
    test
    ```

    1.out
    ```
    6 test
    ```

    2.in
    ```
    72
    128 256
    myonmyon
    ```

    2.out
    ```
    456 myonmyon
    ```

5. [追加予定]以下コマンドでテストが走ります。

    ```
    $npm run test welcome-to-atcoder
    1.in / 1.out ... OK
    2.in / 2.out ... OK
    2 / 2 case OK, complete!!
    ```

## 環境構築

| name | version | description |
| --- | --- | --- |
| OS | Ubuntu 20.04.2 LTS | 動作確認したOSです, macOS確認中 |
| docker | version | TODO: versionかくにんする, macOSだとdocker起動してないとエラー |
| node | 未確認 | インストールしてね。 TODO: .nvmrc作る |

## 注意
 - 解答ファイルについて、取り扱いはそれぞれのコンテスト規約に準拠してください。githubでpublicなリポートリポジトリにpushする場合、それがmainブランチでなくても誰でも見れる状態になります。AtCoderなどは公開可能時間前に回答コードを公開するのは規約違反となります。お気をつけて!

## 参考

- [Python - Official Image | Docker Hub](https://hub.docker.com/_/python/?tab=description)
- [DockerコンテナでPythonスクリプトを動かす (主要なDockerオプション添え) - Qiita](https://qiita.com/zaki-lknr/items/f0ca0a28e5445884f30a)
- [シェルスクリプトの説明をコメントで書いてコマンドラインでヘルプとして表示する - Qiita](https://qiita.com/progrhyme/items/073dbf58844caa0e4b5c)

## License

[MIT License](LICENSE)