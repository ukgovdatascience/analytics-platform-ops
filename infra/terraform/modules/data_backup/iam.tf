# resource "aws_iam_role" "nfs_backup" {
#   name               = "${var.env}_nfs_backup"
#   assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
# }

# resource "aws_iam_policy" "nfs_backup" {
#   name        = "${var.env}_nfs_backup"
#   description = "Policy for S3 write for NFS backup processes"
#   policy      = "${data.aws_iam_policy_document.nfs_backup.json}"
# }

# resource "aws_iam_policy_attachment" "nfs_backup" {
#   name       = "${var.env}_nfs_backup"
#   roles      = ["${aws_iam_role.nfs_backup.name}"]
#   policy_arn = "${aws_iam_policy.nfs_backup.arn}"
# }

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${var.k8s_worker_role_arn}"]
    }
  }
}

# data "aws_iam_policy_document" "nfs_backup" {
#   statement {
#     effect = "Allow"


#     actions = [
#       "s3:AbortMultipartUpload",
#       "s3:DeleteObject",
#       "s3:GetObject",
#       "s3:GetObjectAcl",
#       "s3:PutObject",
#       "s3:PutObjectAcl",
#     ]


#     resources = [
#       "${aws_s3_bucket.nfs_backup.arn}/*",
#     ]
#   }


#   statement {
#     effect = "Allow"


#     actions = [
#       "s3:ListBucket",
#       "s3:GetBucketLocation",
#     ]


#     resources = [
#       "${aws_s3_bucket.nfs_backup.arn}",
#     ]
#   }
# }

