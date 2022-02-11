# S3 bucket level public access prohibited
[AWS Security Hub S3.8](https://docs.aws.amazon.com/ja_jp/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html#fsbp-s3-8) の解決策

## 使用方法
1. 環境構築
    ```bash
    $ terraform init -backend=false
    $ terraform plan
    $ terraform apply
    ```
2. AWS CLIコマンドでの バケットへのパブリックアクセス禁止対応
   ```bash
   $ aws s3api put-public-access-block \
    --bucket security-hub-public-access-0011 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" 
   ```
3. 掃除
   ```bash
   $ terraform plan --destroy
   $ terraform apply --destroy
   ```