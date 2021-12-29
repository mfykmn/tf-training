# EC2 IMDSv2 Check
[AWS Security Hub EC2.8](https://docs.aws.amazon.com/ja_jp/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html#fsbp-ec2-8) の解決策

## 使用方法
1. 環境構築
    ```bash
    $ terraform apply
    ```
2. IMDS V2担っているか確認
    * Configのルールを確認して準拠と非準拠が１点ずつできていることを確認する
      * [securityhub-ec2-imdsv2-check-*****](https://ap-northeast-1.console.aws.amazon.com/config/home?region=ap-northeast-1#/rules/details?configRuleName=securityhub-ec2-imdsv2-check-f6801b8c)
    * コマンドでも確認できる
      * {instance ID} optional enabled になっているものがIMDS V2になっていないもの
      ```bash
      $ aws ec2 describe-instances \
        --query "Reservations[].Instances[].[InstanceId,MetadataOptions.HttpTokens,MetadataOptions.HttpEndpoint]" \
        --output text
      i-0cf48878dda0f8d26     required        enabled
      i-0fa777bf3968e5d00     optional        enabled
      ````
3. AWS CLIコマンドでの IMDS V2 対応
    ```bash
    $ export INSTANCE_ID=i-0fa777bf3968e5d00
    $ aws ec2 modify-instance-metadata-options \
      --instance-id $INSTANCE_ID \
      --http-tokens required \
      --http-endpoint enabled
    ```
4. 再度確認しIMDS V2に対応済みであることを確認
    ```bash
    $ aws ec2 describe-instances \
      --query "Reservations[].Instances[].[InstanceId,MetadataOptions.HttpTokens,MetadataOptions.HttpEndpoint]" \
      --output text
    i-0cf48878dda0f8d26     required        enabled
    i-0fa777bf3968e5d00     required        enabled
    ```