import 'dart:io';
import 'package:flutter/material.dart';

class OwnUser {
  const OwnUser({@required this.uid, this.email, this.name, this.foto});
  final String uid;
  final String email;
  final String name;
  final String foto;
}
/*
class ImageFile<File> {
  const ImageFile({this.image});
  final File image;
}

 */

class DownloadUrl {
  const DownloadUrl({@required this.downloadUrl});
  final String downloadUrl;
}

class Favorite {
  Favorite({@required this.videoPath, this.duration, @required this.workout, @required this.level, @required this.thumbnail, @required this.bodyPart});

  final String duration;
  final String videoPath;
  final String workout;
  final String level;
  final String thumbnail;
  final String bodyPart;

  factory Favorite.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String videoPath = data['videoPath'];
    final String duration = data['duration'];
    final String workout = data['workout'];
    final String level = data['level'];
    final String thumbnail = data['thumbnail'];
    final String bodyPart = data['bodyPart'];

    return Favorite(
      videoPath: videoPath,
      duration: duration,
      workout: workout,
      level: level,
      thumbnail: thumbnail,
      bodyPart: bodyPart
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoPath': videoPath,
      'duration': duration,
      'workout': workout,
      'level': level,
      'thumbnail': thumbnail,
      'bodyPart': bodyPart
    };
  }

}

class Workout {
  Workout({@required this.videoPath, @required this.workout, @required this.level, @required this.bodyPart, @required this.thumbnail});

  final String videoPath;
  final String workout;
  final String level;
  final String bodyPart;
  final String thumbnail;

  factory Workout.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String videoPath = data['videoPath'];
    final String workout = data['workout'];
    final String level = data['level'];
    final String bodyPart = data['bodyPart'];
    final String thumbnail = data['thumbnail'];

    return Workout(
        videoPath: videoPath,
        workout: workout,
        level: level,
        bodyPart: bodyPart,
        thumbnail: thumbnail
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoPath': videoPath,
      'workout': workout,
      'level': level,
      'bodyPart': bodyPart,
      'thumbnail': thumbnail
    };
  }

}


class Routine {
  Routine({@required this.workoutNames, @required this.thumbnails, @required this.routineName, @required this.videoPaths, @required this.count,});

  final String routineName;
  final String count;
  final List<dynamic> videoPaths;
  final List<dynamic> thumbnails;
  final List<dynamic> workoutNames;


  factory Routine.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final List<dynamic> videoPaths = data['videoPaths'];
    final String count = data['count'];
    final String routineName = data['routineName'];
    final List<dynamic> thumbnails = data['thumbnails'];
    final List<dynamic> workoutNames = data['workoutNames'];

    return Routine(
        videoPaths: videoPaths,
        count: count,
        routineName: routineName,
        thumbnails: thumbnails,
        workoutNames: workoutNames
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoPaths': videoPaths,
      'count': count,
      'routineName': routineName,
      'thumbnails': thumbnails,
      'workoutNames': workoutNames
    };
  }

}