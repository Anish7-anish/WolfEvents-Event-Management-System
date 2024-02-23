# WolfEvents Event Management System

Welcome to the WolfEvents Event Management System! This system allows users to manage events, book tickets, and leave reviews for attended events. Admins have additional privileges such as managing users, events, rooms, and reviews.

Below is a guide to help you navigate through the system effectively.

## The application is deployed on VCL: http://152.7.176.57:8080/

## Admin Account

For reviewers with admin privileges, you can log in using the following credentials:
- **Email**: admin@example.com
- **Password**: password

## Functionalities
## Admin:
1. **Login**: Login using admin credentials.
2. **All Events**: Click on "All Events" to view, create, edit, and delete events.
3. **Book Tickets**: In "All Events," click on "Book Tickets" to book tickets for yourself or other users by entering the number of tickets, and choosing the user. **Bonus 2** is implemented here.
4. **All Attendees**: Click on "All Attendees" to view all attendees signed up for the system. Admin can create, edit, and delete attendees. **Bonus 1** is implemented here. Admin can search for attendees who have signed up for an event by giving event name as input.
5. **All Event Tickets**: View tickets booked by all users in "All Event Tickets" and edit and delete them.
6. **Booking History**: View tickets booked by the admin in "Booking History."
7. **All Rooms**: View, create, edit and destroy rooms where events take place.
8. **My Reviews**: Access reviews written by the admin in "My Reviews." You can view, create, edit and delete reviews.
9. **All Reviews**: Access reviews written by all users in "All Reviews." You can filter by attendee name, email, and event name. Admin can view, create, edit and delete reviews.
10. **Edit Profile**: Update admin profile details except for the email address in "Edit Profile."

## Attendee:
1. **Register**: Register by clicking on "Register" if you are a new user.
2. **Login**: Log in by clicking on "Login" for existing users by entering valid credentials.
3. **All Events**: Click on "All Events" to view all available events.
4. **Book Tickets**: Book tickets for yourself or other users by entering the number of tickets and choosing the user in "Book Tickets." **Bonus 2** is implemented here.
5. **Booking History**: View all tickets booked by the attendee in "Booking History."
6. **My Reviews**: Access reviews written by the attendee in "My Reviews." You can view, create, edit and delete reviews.
7. **All Reviews**: Access reviews written by all users in "All Reviews." You can filter by attendee name, email, and event name.
8. **Edit Profile**: Edit your profile details in "Edit Profile."
9. **Delete Account**: If you wish to delete your account, you can do so in the "Delete Account" section. This action will permanently remove your account along with all associated tickets and reviews.

## Bonus Features:
1. **Bonus 1**: This feature is implemented for admin in "All Attendees" link. Admin can filter attendees who have signed up for the event using event name.
2. **Bonus 2**: Users can book tickets for another user. After clicking on "Book Tickets" under "All Events", user can select another user name to book tickets for him/her and the tickets will be visible on both users accounts.

## Installation
To install and run this application, follow these steps:

1.	Clone this repository to your local machine using git clone https://github.ncsu.edu/atoorpu/CSC_ECE_517_Spring2024_Program_2.git
2.	Change into the project directory using cd CSC_ECE_517_Spring2024_Program_2
3.	Install the necessary dependencies using: bundle install
4.	Create the database using rails db:create
5.	Run the database migrations using rails db:migrate
6.	Seed the database with sample data using rails db:seed
7.	Start the server using rails server
8.	Open your web browser and go to http://localhost:3000 to access the application



