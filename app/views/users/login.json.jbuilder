json.user do
	json.id @login[:user].id
	json.username @login[:user].username
	json.email @login[:user].email
	json.type @login[:user].user_type
end

json.jwt do
	json.token @login[:token]
end