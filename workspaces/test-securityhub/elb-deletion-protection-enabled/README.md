# ELB Deletion Protection Enabled
[AWS Security Hub ELB6](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html#fsbp-elb-6) の解決策

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
     --attributes Key=deletion_protection.enabled,Value=true
   ```

## 参考リンク
* https://docs.aws.amazon.com/cli/latest/reference/elbv2/modify-load-balancer-attributes.html
