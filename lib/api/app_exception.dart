class AppExceptions implements Exception {
  String title;
  String body;

  AppExceptions({required this.title, required this.body});

  String toString() {
    return "$title : $body";
  }
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions({required String mBody})
      : super(title: "Data Communication Error", body: mBody);
}

class UnAuthorisedException extends AppExceptions {
  UnAuthorisedException({required String mBody})
      : super(title: "Un-Authorised Access Error", body: mBody);
}

class InValidInputException extends AppExceptions {
  InValidInputException({required String mBody})
      : super(title: "In-Valid Input Error", body: mBody);
}


class BadRequestException extends AppExceptions {
  BadRequestException({required String mBody})
      : super(title: "Bad-Request Error", body: mBody);
}




class ServerException extends AppExceptions {
  ServerException({required String mBody})
      : super(title: "Server Error", body: mBody);
}
