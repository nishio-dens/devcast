create_table :articles, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.boolean :published, default: false
  t.varchar :slug
  t.varchar :title
  t.varchar :repo_name, limit: 512
  t.varchar :md5, limit: 32
  t.mediumtext :lead_content, null: true
  t.mediumtext :content, null: true

  t.datetime :published_at, null: true
  t.datetime :created_at
  t.datetime :updated_at

  t.index :slug, unique: true
end

create_table :categories, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :name
  t.int :article_categories_count, default: 0

  t.datetime :created_at
  t.datetime :updated_at

  t.index :name, unique: true
end

create_table :tags, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :name
  t.int :article_tags_count, default: 0

  t.datetime :created_at
  t.datetime :updated_at

  t.index :name, unique: true
end

create_table :article_categories, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :article_id
  t.int :category_id

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :article_id, reference: :articles, reference_column: :id
  t.foreign_key :category_id, reference: :categories, reference_column: :id
end

create_table :article_tags, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :article_id
  t.int :tag_id

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :article_id, reference: :articles, reference_column: :id
  t.foreign_key :tag_id, reference: :tags, reference_column: :id
end

create_table :header_categories, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :category_id
  t.int :display_order, default: 0

  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :category_id, reference: :categories, reference_column: :id
end

create_table :schema_migrations, default_charset: :utf8mb4, row_format: :dynamic, collate: :utf8mb4_unicode_ci do |t|
  t.varchar :version, limit: 191

  t.index :version, name: "unique_schema_migrations", unique: true
end

create_table :ar_internal_metadata, collate: :utf8_bin do |t|
  t.varchar :key
  t.varchar :value
  t.datetime :created_at
  t.datetime :updated_at
end
