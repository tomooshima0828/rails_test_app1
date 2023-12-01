# Rubyのイメージを指定
FROM ruby:2.7.4

# Node.js をバージョン 14.x にアップグレード
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs

# Yarn のインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

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
