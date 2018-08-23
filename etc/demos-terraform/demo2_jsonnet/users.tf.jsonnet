// Do not edit generated file (users.tf.json)

// Specify list of users here
local users = std.sort(["user2", "user3", "user1"]);

{
  resource: {
    aws_iam_user: {
      ["%s" % user]: {
        name: user,
      } for user in users
    },
    aws_iam_access_key: {
      ["%s" % user]: {
        user: user,
      } for user in users
    },
    aws_iam_group_membership: {
      developers: {
        name: "terraform-developers",
        group: "${aws_iam_group.developers.name}",
        users: ["${aws_iam_user.%s.name}" % user for user in std.sort(users)],
      },
    },
  },
  output: {
    ["iam_user_access_key_" + user]: {
      value: "${aws_iam_access_key."+user+".id} ===  ${aws_iam_access_key."+user+".secret}",
    } for user in users
  }
}
