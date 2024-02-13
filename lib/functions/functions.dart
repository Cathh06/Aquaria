import 'package:aquaria/classes/fish.dart';
import 'package:aquaria/classes/timer.dart';
import 'package:aquaria/classes/user.dart';
import 'package:aquaria/services/http_service.dart';

User? currentUser;

Future<int> registerUser(username, email, password, confirmPassword) async {
  if (password != confirmPassword) {
    return 400;
  }

  User user = User(null, username, email, password);
  dynamic request = await createUser(user);

  if (request == 200) {
    return 200;
  }

  return 500;
}

Future<dynamic> loginUser(username, password) async {
  User user = User(null, username, null, password);
  dynamic request = await verifyUser(user);

  if (request is User) {
    currentUser =
        User(request.id, request.username, request.email, request.password);

    return request;
  }

  return 400;
}

Future<Fish?> fishStrike(minutes) async {
  Fish? request = await timerFinished(minutes);

  return request;
}

Future<Fish?> timerFinished(minutes) async {
  Timer timer = Timer(null, minutes, currentUser!.id, null, null);
  dynamic request = await createTimer(timer);

  if (request is Fish) {
    return Fish(
      request.id,
      request.name,
      request.description,
      request.image,
    );
  }

  return null;
}

Future<dynamic> fishcollection(name, description, image) async {
  Fish fish = Fish(null, name, description, image);
}

Future<List<dynamic>> getProgressData() async {
  dynamic request = await getTimerByUser(currentUser!.id);
  print("request $request");

  if (request is List<dynamic>) {
    List<dynamic> progressList = [
      {
        "totalMinutes": 0,
        "dayName": "Monday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Tuesday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Wednesday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Thursday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Friday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Saturday",
      },
      {
        "totalMinutes": 0,
        "dayName": "Sunday",
      },
    ];

    for (var item in request) {
      // print(
      //     "${progressList[4]['totalMinutes'].runtimeType} - ${int.parse(item['daily_focus_time']).runtimeType}");
      if (item['dayname'] == "Monday") {
        progressList[0]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Tuesday") {
        progressList[1]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Wednesday") {
        progressList[2]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Thursday") {
        progressList[3]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Friday") {
        progressList[4]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Saturday") {
        progressList[5]['totalMinutes'] += int.parse(item['daily_focus_time']);
      } else if (item['dayname'] == "Sunday") {
        progressList[6]['totalMinutes'] += int.parse(item['daily_focus_time']);
      }
    }

    return progressList.toList();
  }

  return [];
}
