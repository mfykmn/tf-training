# ELB Logging Enabled
[AWS Security Hub ELB5](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html#fsbp-elb-5) の解決策

## 使用方法
1. 環境構築
    ```bash
    $ terraform apply
    ```
2. AWS CLIコマンドでの ALB アクセスログの有効化対応
   ```bash
   $ ALB_ARN=$(aws elbv2 describe-load-balancers | jq -r '.LoadBalancers[0].LoadBalancerArn')
   $ aws elbv2 modify-load-balancer-attributes \
     --load-balancer-arn $ALB_ARN \
     --attributes Key=access_logs.s3.enabled,Value=true Key=access_logs.s3.bucket,Value=alb-accesslogs-0011 Key=access_logs.s3.prefix,Value=myapp
   ```

## 参考リンク
* https://dev.classmethod.jp/articles/alb-log-s3-default-encryption/
* https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/classic/enable-access-logs.html#attach-bucket-policy
* https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/application/load-balancer-access-logs.html#enable-access-logging
* https://docs.aws.amazon.com/cli/latest/reference/elbv2/modify-load-balancer-attributes.html
