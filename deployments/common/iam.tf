resource "aws_iam_user" "lb" {
  name = "classroom_user_${count.index}"
  path = "/system/"
  count = var.user_count
}

resource "aws_iam_access_key" "lb" {
  user = "classroom_user_${count.index}"
  count = var.user_count
  depends_on = [aws_iam_user.lb]
}

resource "aws_iam_user_policy" "classroom_user_policy" {
  name = "classroom_user_policy${count.index}"
  user = "classroom_user_${count.index}"
  count = var.user_count
  depends_on = [aws_iam_access_key.lb]

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}