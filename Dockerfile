# Rubyのイメージを指定
FROM ruby:2.7.4

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリの設定
WORKDIR /myapp

# ローカルのGemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Bundle installの実行
RUN bundle install

# ローカルのカレントディレクトリをコピー
COPY . /myapp

# コンテナがリッスンするポート番号を指定
EXPOSE 3000

# コンテナ起動時の実行コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
