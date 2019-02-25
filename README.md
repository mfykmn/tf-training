# tf-training

## AWS credentialsの設定追加
```bash
$ export AWS_ACCESS_KEY_ID={{your_aws_access_key}}
$ export AWS_SECRET_ACCESS_KEY={{your_aws_secret_key}}
```

## init
tfstateをリモートで管理するS3バケットを用意する
moduleの取得
providerの取得
バックエンドの構築(tfstateを保持するs3のバケット、ロックを制御するDynamoDBのテーブル)が行われる
```bash
$ export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
$ cd environments/init
$ terraform init
$ terraform plan -out .terraform/plan
$ terraform apply -input .terraform/plan
```


## 構築
```bash
$ export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
$ cd environments/mutable
$ terraform init
$ terraform plan -out .terraform/plan
$ terraform apply -input .terraform/plan
```

## Debug
```bash
$ export TF_LOG=DEBUG
```