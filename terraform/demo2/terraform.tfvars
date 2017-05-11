aws_region = "eu-west-1"

# NOTE:
# Be careful, because adding new user in the list will recreate other users also!
# Correct way is to create each user individually and don't use interpolation functions there.
iam_users = [
  "circleci",
  "user1",
  "user2",
]