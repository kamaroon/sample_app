Feature: Signing_in

Scenario: Unsuccessful Signin
	Given a user visits the signin page
	When he submits invalid signin information
	Then he should see a error message
	
Scenario: Successful Signin
	Given a user visits the signin page
	 And the user has an account
	 And the user submit valid signin information
	Then he should see his profile page
	 And he should see a signout link
