resource "aws_iam_user" "user" {
  name = "${var.name}-${terraform.workspace}-deployer"
}

resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::sample-project"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:prefix"

      values = [
        ""
      ]
    }
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::sample-project",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "production",
        "production/*"
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::sample-project/production/*",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.name}-${terraform.workspace}-policy"
  description = "${var.name} policy"
  policy      = data.aws_iam_policy_document.policy_document.json
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "attachment"
  users      = ["${aws_iam_user.user.id}"]
  roles      = ["${aws_iam_role.iam_role.id}"]
  policy_arn = aws_iam_policy.policy.arn
}
resource "aws_iam_user_policy_attachment" "attach2" {
  user       = aws_iam_user.user.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceFullAccess"
}
resource "aws_iam_user_policy_attachment" "attach3" {
  user       = aws_iam_user.user.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
