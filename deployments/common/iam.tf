resource "aws_iam_user" "lb" {
  name = "classroom_user"
  path = "/system/"
}

resource "aws_iam_access_key" "lb" {
  user = aws_iam_user.lb.name
}

resource "aws_iam_user_policy" "classroom_user_policy" {
  name = "test"
  user = aws_iam_user.lb.name

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