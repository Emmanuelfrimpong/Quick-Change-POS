final emailRegEx = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final List<String> newUserInfo = [
  'Make sure to provide accurate and up-to-date information about your company, including your business name, and contact details.',
  'If you need help or have any questions, don\'t hesitate to reach out to Quick Change POS customer support for assistance.'
];
final secretQuestion = [
  'What is your favorite childhood book?',
  'What is the name of the street you grew up on?',
  'What was your high school Nickname?',
  'What was the name of your first pet?',
  'What is your favorite movie or TV show?',
  'In what city or town was your mother born?'
];

// create 2 instructions fo login
final List<String> loginInfo = [
  'Please enter your UserID and password(Case sensitive) to login.',
  'If you forgot your password, User you secret question and answer to reset your password or contact your administrator for assistance.'
];
