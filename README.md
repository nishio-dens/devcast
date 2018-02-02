# DevCast

技術ブログ DevCast 管理用アプリケーションです。

## 記事のアップロード

DevCastサーバに向けて記事をgit pushしてください。

```
git remote add deploy git@dev.densan-labs.net:devcast/devcast.git
git push deploy master
```

## 記事リポジトリの形式

articles ディレクトリの下に .md 形式で記事を配置してください。
images には利用する画像を配置してください。

### ディレクトリ例

```
.
├── articles
│   ├── hello-world.md
│   └── infra
│       ├── another-example.md
│       └── test.md
└── images
    └── image-test.png
```

## 記事の形式

記事の先頭にYAML形式で以下を追記してください。

```
---
title: "ここは記事のタイトルです"
author: nishio-dens
draft: false
categories: Rails
tags: ruby, ActiveRecord
published_at: 2018-02-03 15:00
--
```

draft: false の場合、記事が公開されます。
