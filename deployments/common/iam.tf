resource "aws_iam_user" "lb" {
  name = "classroom_user_${count.index}"
  path = "/system/"
  force_destroy = true
  count = var.user_count
}

resource "aws_iam_access_key" "lb" {
  user = "classroom_user_${count.index}"
  count = var.user_count
  depends_on = [aws_iam_user.lb]
}

data "aws_iam_policy_document" "classroom_user_policy_doc" {
  statement {
    sid = "1"
    actions = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "classroom_user_policy" {
  name = "classroom_user_policy${count.index}"
  user = "classroom_user_${count.index}"
  count = var.user_count
  depends_on = [aws_iam_access_key.lb, data.aws_iam_policy_document.classroom_user_policy_doc]

  policy =data.aws_iam_policy_document.classroom_user_policy_doc.json
}