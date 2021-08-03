# Dockerfile
# 
# 利用する開発環境を指定する
# コンテナ作成時にインストールしておきたいOS用のライブラリや、
# Pythonモジュールなどをインストールする。


# ベースイメージ
FROM python:3

# 初期設定
# ユーザー設定
USER root
# パッケージリストの更新
RUN apt-get update
# ロケールを日本に設定
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja_JP
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9

# デフォルトのターミナルをxtermに設定
ENV TERM xterm
# vim, lessをインストール
RUN apt-get install -y vim less

# pipをアップグレード
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# 最初から使用したいPythonモジュールのインストール
RUN python -m pip install jupyterlab