# Join Form
A user enters their email address.
An `account` row is created with the email address and a `status` of `pending`


# Sponsor Form
A user fills out the form and selects type of sponsorship.
IF the `email` already exits in `account`s table
  THEN create as many `sponsor_sponsorship_type` row with the `sponsor_id` and `sponsorship_type`s as needed
IF the `email` does not exist in the `account`s table
  THEN create an `account` row with the email address and a `status` of `pending`
  THEN create a `sponsor` row with the form metadata with a `status` of `pending`
  THEN create as many `sponsor_sponsorship_type` row with the `sponsor_id` and `sponsorship_type`s as needed

A user can `confirm` their account and `cancelled` their sponsorship. That is why both tables maintain their own `status`
The `sponsor` row has an `account_id` foreign key.


# Speaker Form
A user fills out the form
IF the `email` already exits in `account`s table
  THEN create a `speaker` row with the form metadata with a `status` of `pending`
IF the `email` does not exist in the `account`s table
  THEN create an `account` row with the email address and a `status` of `pending`
  THEN create a `speaker` row with the form metadata with a `status` of `pending`

A user can `confirm` their account and `cancelled` their sponsorship. That is why both tables maintain their own `status`
The `speaker` row has an `account_id` foreign key

# News

The news is made of stories that are resources. The stories are articles that have authors.

A user submitting a story for the news section is to advertise something and then subsequently the users write comments.

How to personalize this?

If a user likes a news piece they can favorite it (star it) and it gets added to their account.
They essentially are bookmarking stories with comments making them useful resources to come back to later on.



DEFAULT TAGS:
`react`
`state management`

`prod-env`

`css`

`javascript`
`typescript`

`graphql`
`rest api`
`api`



category
kind
subtype
type_of
role
class
<entity>_type


articles
resources
news items
stories
posts
blog
