# MANUAL
## AWS credentialsの設定追加
```bash
$ export AWS_ACCESS_KEY_ID=
$ export AWS_SECRET_ACCESS_KEY=
$ export AWS_SESSION_TOKEN=
```

## 開発コマンド
- version指定
    ```bash
    $ cd terraform/workspaces/{env_dir}/{workspace_dir}
    $ tfenv install
    ```
- fmt
    ```bash
    $ terraform fmt -diff=true -check=true terraform/workspaces/{env_dir}/{workspace_dir}
    ```
- validate
    ```bash
    $ terraform init -backend=false terraform/workspaces/{env_dir}/{workspace_dir}
    $ terraform validate terraform/workspaces/{env_dir}/{workspace_dir}
    ```
- tflint
    ```bash
    $ tflint terraform/workspaces/{env_dir}/{workspace_dir}
    ```
- apply
    ```bash
    $ export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
    $ terraform plan -out .terraform/plan
    $ terraform apply -input .terraform/plan
    ```
- Debug
    ```bash
    $ export TF_LOG=DEBUG
    ```
## トークンによるCLIアクセス
Terraform CloudのGUIコンソールから行えないような調査、構成の管理を行いたい場合におこなう
https://www.terraform.io/docs/commands/cli-config.html

```bash
$ vim ~/.terraformrc
credentials "app.terraform.io" {
  token = "****"
}
```

入力するトークンはTerraform Cloud GUIコンソールの UserSettings > Tokensで作成する
