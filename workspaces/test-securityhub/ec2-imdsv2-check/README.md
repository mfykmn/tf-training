# EC2 IMDSv2 Check
[AWS Security Hub EC2.8](https://docs.aws.amazon.com/ja_jp/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html#fsbp-ec2-8) の解決策

## 使用方法
1. 環境構築
    ```bash
    $ terraform apply
    ```
2. Configのルールを確認して準拠と非準拠が１点ずつできていることを確認する
   [securityhub-ec2-imdsv2-check-*****](https://ap-northeast-1.console.aws.amazon.com/config/home?region=ap-northeast-1#/rules/details?configRuleName=securityhub-ec2-imdsv2-check-f6801b8c)