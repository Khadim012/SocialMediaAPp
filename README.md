# SocialMediaAPp

## For the development I used:

- MVVM architecture 
- Web-service with NSURLSession (Native).
- I used Single class and single function for all apis request
- Codable for parsing data.
- I’m using single view for Home Screen posts listing and for comments screen listing.I reused the code.
- all the function have single responsibility.
- I have one class for screen navigation. We need to pass only the screen name. 
- Project assets are grouped with screen name.

## Code Structure:

**Model**			:  I have all model classes in this folder.<br>
**View**  			:  UI of the Application.<br>
**viewMode**		:  Project business logic. Like apis call and the communication between view and model.<br>
**Controller**		:  All the controller class are this group. Also I divide classes according to the module.<br>
**WebService**	:  I have a generic class API request.<br> 
**Constant** 		:  Application constants.<br>
**Resources**	:   include Application fonts, assist and plist file.<br>
