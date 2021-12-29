# Contribution Guide
Terraformへのコントリビュート方法についてガイドです

## Directory Structure
```
.
├── README.md
├── modules
│   └── {resource_dir}
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
│
├── workspaces
│   └── {env_dir}
│       └── {workspace_dir}
│           ├── main.tf
│           ├── backend.tf
│           ├── providers.tf
│           ├── output.tf
│           ├── variables.tf
│           └── versions.tf
│
└── yaml-files
    └── {workspace_dir}
        └── hoge.yaml
```
### description
#### workspaces
インフラを分割する粒度 [See](https://www.terraform.io/docs/cloud/workspaces/index.html)

- workspaces/{env_dir}/{workspace_dir}/backend.tf
  - remote stateの管理
- workspaces/{env_dir}/{workspace_dir}/main.tf or {resource}.tf
  - モジュールを組み合わせてインフラを作成する場所
- workspaces/{env_dir}/{workspace_dir}/providers.tf
  - AWSやGCPなど使用するプロバイダを指定する [See](https://www.terraform.io/docs/providers/index.html)
- workspaces/{env_dir}/{workspace_dir}/variables.tf
  - 外部から値を入れる変数(e.g. Terraform Cloud)
- workspaces/{env_dir}/{workspace_dir}/locals.tf
  - 共通利用するローカル変数
- workspaces/{env_dir}/{workspace_dir}/versions.tf
  - バージョンを管理する
- workspaces/{workspace_dir}/output.tf
  - remote state経由で参照したい値を出力させる

#### modules
  - モジュールという単位で複数のリソースを組み合わせる [See](https://www.terraform.io/docs/configuration/modules.html)
- modules/{resource_dir}/output.tf
  - moduleで生成されたリソースを別の場所で使用したい場合はoutputで指定しないといけない
- modules/{resource_dir}/variables.tf
  - moduleの引数をこちらで管理する

#### yaml-files
  - IAM Policyなどtf内で使用するファイルをyaml化したものを保持する
