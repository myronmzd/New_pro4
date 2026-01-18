# SES Module

resource "aws_ses_email_identity" "sender" {
  email = "noreply@${var.domain_name}"
}