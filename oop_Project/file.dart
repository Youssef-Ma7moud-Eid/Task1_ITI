// ---------------------
// Abstract User Class
// ---------------------
abstract class User {
  late int _id;
  String name;
  String email;

  User({required this.name, required this.email});
  int GetId() => this._id;
  void SetId(int id) {
    this._id = id;
  }

  void login();
  void logout();
  void updateProfile(String newName, String newEmail);
}

// ---------------------
// Student Class
// ---------------------
class Student extends User {
  List<Course> enrolledCourses = [];
  Student({required super.name, required super.email});
  // Student() : super(id: 0, name: '', email: '');
  @override
  int GetId() => this._id;
  @override
  void SetId(int id) {
    this._id = id;
  }

  @override
  void login() => print("$name (Student) logged in with email: $email");

  @override
  void logout() => print("$name (Student) logged out");

  @override
  void updateProfile(String newName, String newEmail) {
    name = newName;
    email = newEmail;
    print("Student profile updated: $name, $email");
  }

  void enroll(Course course) {
    enrolledCourses.add(course);
    print("$name enrolled in course: ${course.title}");
  }
}

// ---------------------
// Instructor Class
// ---------------------
class Instructor extends User {
  List<Course> createdCourses = [];

  Instructor({required super.name, required super.email});

  @override
  void login() => print("${name} (Instructor) logged in with email: $email");

  @override
  void logout() => print("${name} (Instructor) logged out");

  @override
  void SetId(int id) {
    this._id = id;
  }

  @override
  int GetId() => this._id;
  @override
  void updateProfile(String newName, String newEmail) {
    name = newName;
    email = newEmail;
    print("Instructor profile updated: $name, $email");
  }

  void createCourse(Course course) {
    createdCourses.add(course);
    print("${name} created a new course: ${course.title}");
  }
}

// ---------------------
// Course Class
// ---------------------
class Course {
  String title;
  String description;
  Instructor instructor;
  List<Content> contentList = [];
  List<RatingReview> reviews = [];

  Course(this.title, this.description, this.instructor);
  void addNewReview(RatingReview newreview) => reviews.add(newreview);
  void addContent(Content content) => contentList.add(content);
  void archive() => print("Course archived");
  void showReviews() => reviews.forEach((r) => print(r.review));
}

// ---------------------
// Abstract Content Class
// ---------------------
abstract class Content {
  String title;

  Content(this.title);

  void display();
}

class Video extends Content {
  int duration;

  Video(String title, this.duration) : super(title);

  @override
  void display() => print("Playing video: $title");
}

class PDF extends Content {
  int pages;

  PDF(String title, this.pages) : super(title);

  @override
  void display() => print("Displaying PDF: $title");
}

class Quiz extends Content {
  int questionCount;

  Quiz(String title, this.questionCount) : super(title);

  @override
  void display() => print("Showing quiz: $title");
}

// ---------------------
// Enrollment Class
// ---------------------
class Enrollment {
  Student student;
  Course course;
  double progress = 0;

  Enrollment(this.student, this.course);

  void updateProgress(double newProgress) => progress = newProgress;
  void markComplete() => print("Course completed");
}

// ---------------------
// Payment Interface
// ---------------------
abstract class Payment {
  void processPayment(double amount);
}

class CreditCardPayment implements Payment {
  @override
  void processPayment(double amount) => print("Paid ${amount} by Credit Card");
}

class PaypalPayment implements Payment {
  @override
  void processPayment(double amount) => print("Paid ${amount} by PayPal");
}

// ---------------------
// Notification Interface
// ---------------------
abstract class Notification {
  void send(String message);
}

class EmailNotification implements Notification {
  @override
  void send(String message) => print("Email: $message");
}

class SMSNotification implements Notification {
  @override
  void send(String message) => print("SMS: $message");
}

// ---------------------
// RatingReview Class
// ---------------------
class RatingReview {
  Student student;
  int rating;
  String review;

  RatingReview(this.student, this.rating, this.review);

  void showReview() => print("Rating: $rating, Review: $review");
}

void main() {
  Student student1 = Student(
      name: "Youssef", email: "youssed@gmail.com"); // new student detail
  student1.SetId(1);

  Instructor instructor1 = Instructor(
      name: 'Amgad', email: 'Amgad@gmail.com'); // new instructor detail
  instructor1.SetId(123);

  Course course1 = Course('Flutter', 'Mobile Application',
      instructor1); // new course detail by owned instructor

  PDF content_course1 =
      PDF('Dart & Flutter track', 20); // content of course to added

  course1.addContent(content_course1); // add this content to course

  instructor1
      .createCourse(course1); // instructor add this new course and publish it

  student1.enroll(course1); // student start enroll to this course

  CreditCardPayment cardPayment =
      CreditCardPayment(); // start pay price of this  course

  cardPayment.processPayment(320); // paid price done

  EmailNotification emailNotification =
      EmailNotification(); // make sure that this course become own this student by his email

  emailNotification.send('Success enroll course'); // massage of success enroll

  Enrollment enrollment = Enrollment(student1,
      course1); // start enroll of student in course with progress 0 and later increase to 100%

  RatingReview course1_rating =
      RatingReview(student1, 100, "very good"); // course review by student1

  course1
      .addNewReview(course1_rating); // add this review in course1 reviews list

  print(student1.enrolledCourses.first
      .title); // first course  title enrolled by this student

  print(student1.enrolledCourses.first
      .description); // first course  desciription enrolled by this student

  print(student1.GetId());
}
