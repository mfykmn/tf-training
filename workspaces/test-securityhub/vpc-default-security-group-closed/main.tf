#####################################
# IAM
#####################################
data "template_file" "revoke_security_group_policy_yaml" {
  template = file("${path.module}/yaml-files/revoke_security_group_policy.yaml")
}

data "template_file" "revoke_security_group_role_yaml" {
  template = file("${path.module}/yaml-files/revoke_security_group_role.yaml")
}

resource "aws_iam_role" "revoke_security_group" {
  name               = "RevokeSecurityGroup"
  description        = "revoke_security_group_role. Created from Terraform."
  assume_role_policy = jsonencode(yamldecode(data.template_file.revoke_security_group_role_yaml.rendered))
  inline_policy {
    name   = "RevokeSecurityGroupPolicy"
    policy = jsonencode(yamldecode(data.template_file.revoke_security_group_policy_yaml.rendered))
  }
}

#####################################
# SSM
#####################################
data "template_file" "close_security_group_ssm_document_yaml" {
  template = file("${path.module}/yaml-files/close_security_group_ssm_document.yaml")
}

resource "aws_ssm_document" "auto_disable_default_security_group" {
  name          = "AutoDisableDefaultSecurityGroup"
  document_type = "Automation"

  content = data.template_file.close_security_group_ssm_document_yaml.rendered
  document_format = "YAML"
}

#####################################
# Config
#####################################
resource "aws_config_config_rule" "vpc_default_security_group_closed" {
  name = "vpc-default-security-group-closed"

  source {
    owner             = "AWS"
    source_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"
  }
}

resource "aws_config_remediation_configuration" "vpc_default_security_group_closed" {
  config_rule_name = aws_config_config_rule.vpc_default_security_group_closed.name
  resource_type    = "AWS::EC2::SecurityGroup"

  target_type      = "SSM_DOCUMENT"
  target_id        = aws_ssm_document.auto_disable_default_security_group.name

  automatic                  = true
  maximum_automatic_attempts = 10
  retry_attempt_seconds      = 600

  parameter {
    name         = "AutomationAssumeRole"
    static_value = aws_iam_role.revoke_security_group.arn
  }
  parameter {
    name           = "GroupId"
    resource_value = "RESOURCE_ID"
  }
}
