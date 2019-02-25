# tf-training

## AWS credentialsの設定追加
```bash
$ export AWS_ACCESS_KEY_ID={{your_aws_access_key}}
$ export AWS_SECRET_ACCESS_KEY={{your_aws_secret_key}}
```

## init
moduleの取得
providerの取得
バックエンドの構築(tfstateを保持するs3のバケット、ロックを制御するDynamoDBのテーブル)が行われる
```bash
$ cd environments/mutable
$ terraform init
```


## wip構築
```bash
$ terraform plan -out=.
$ terraform apply --
```