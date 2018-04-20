resource "aws_iam_user" "system" {
  name = "${var.system_name}"
  path = "/uploaders/${var.org_name}/"
}

resource "aws_iam_access_key" "system_user" {
  user = "${aws_iam_user.system.name}"
}

data "aws_iam_policy_document" "system_user_s3_upload_writeonly" {
  statement {
    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${var.upload_bucket_arn}/${var.org_name}/${var.system_name}/*",
    ]
  }
}

resource "aws_iam_policy" "system_user_s3_writeonly" {
  name   = "s3_upload_writeonly"
  path   = "/uploaders/${var.org_name}/${var.system_name}/"
  policy = "${data.aws_iam_policy_document.system_user_s3_upload_writeonly.json}"
}