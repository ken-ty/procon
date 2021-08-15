# procon
競プロ用環境を構築するために必要なファイルと説明。

## 要件

- Ubuntu 20.04.2 LTS でAtCoderを回答するための環境を構築したい。
- ローカル端末を汚したくない
- webサービスのような常駐サーバーは必要ない。単一のスクリプトが実行できればよい。

## 説明

/work内でpythonスクリプトを作成、実行できるようにする。
コンテナサイクルにかかわらず、ファイルは保持し続ける。  
単一のpythonスクリプトの実行について、[python公式イメージのDescription](https://hub.docker.com/_/python/?tab=description)に記載されている(和訳した)ので、それを参考にする。

>## 1ファイルのpythonスクリプトを実行
>
>実行したいpythonスクリプトが1ファイルなら、毎回コンテナを立ち上げるのは不便です！こういったケースでは、Dockerイメージを直接指定することであっという間ににpythonスクリプトが実行できます。
>```
>$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp python:3 python your-daemon-or-script.py
>```
>もしくは (Python2の場合):
>```
>$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp python:2 python your-daemon-or-script.py
>```



1. [このリポジトリ](https://github.com/todoggler/procon)を開発端末にクローンする。
1. /dev配下で./build.shを叩く。これは初回だけ。
1. 以降、./run.shで起動できる。

## 環境説明

* dockerコンテナ内で実行するため、端末の環境を汚さない。
* コンテナは落とすとデータが失われる。/work配下のファイルは失われない。
* 環境が壊れたら./build.shを叩いてコンテナを作り直す。

## 参考

- [Python - Official Image | Docker Hub](https://hub.docker.com/_/python/?tab=description)
- [DockerコンテナでPythonスクリプトを動かす (主要なDockerオプション添え) - Qiita](https://qiita.com/zaki-lknr/items/f0ca0a28e5445884f30a)