json.user do
	json.id @user.id
	json.username @user.username
	json.email @user.email
	json.type @user.user_type
end