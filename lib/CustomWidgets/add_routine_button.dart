import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/Models/models.dart';
import 'package:video_app/Notifyers/listViewIndex.dart';
import 'package:video_app/Notifyers/tabbar_color.dart';
import 'package:video_app/Services/database_handler.dart';
import 'package:video_app/Services/firebase_auth_service.dart';
import 'package:video_app/Services/storage_handler.dart';
import 'package:video_app/Views/dashboard.dart';
import 'package:video_app/Views/home_musik_style.dart';
import '../CustomColors/customColors.dart';
import 'package:video_app/Helpers/hero_dialog_route.dart';

import 'custom_rect_tween.dart';
import '../Helpers/hero_dialog_route.dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddRoutineButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddRoutineButton({Key key,@required this.uid,}) : super(key: key);

  final String uid;


  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseHandler>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height/18,
        width: MediaQuery.of(context).size.width/2,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
              return MultiProvider(
                  providers: [
                    Provider(create: (context) => DatabaseHandler(uid: database.uid),),
                  ],
                  child: const _AddRoutinePopupCard());
            }
            )
            );
          },
          child: Hero(
            tag: _heroAddRoutine,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin, end: end);
            },
              child: FlatButton.icon(
                splashColor: Colors.grey,
                icon: Icon(Icons.add, color: Colors.white,),
                label: Text('Add Routine'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'FiraSansExtraCondensed',
                  fontSize: 14.0,
                  color: Colors.white
                ),),
              ),

          ),
        ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddRoutine = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Routine]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddRoutine].
/// {@endtemplate}
class _AddRoutinePopupCard extends StatefulWidget {
  /// {@macro add_todo_popup_card}
  const _AddRoutinePopupCard({Key key}) : super(key: key);

  Future<Routine> _createRoutine(BuildContext context, String name, String count,) async {
    try {
      final database = Provider.of<DatabaseHandler>(context, listen: false);
      List videoPaths = List.generate(int.parse(count), (index) => '');
      List thumbnails = List.generate(int.parse(count), (index) => '');
      List workoutNames = List.generate(int.parse(count), (index) => '');
      await database.createRoutine(Routine(
          routineName: name,
          videoPaths: videoPaths,
          thumbnails: thumbnails,
          workoutNames: workoutNames,
          count: count));
    } catch (e) {
      print(e);
    }
  }

  @override
  __AddRoutinePopupCardState createState() => __AddRoutinePopupCardState();
}

class __AddRoutinePopupCardState extends State<_AddRoutinePopupCard> {

  final routineNameController = TextEditingController();
  final routineSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddRoutine,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Colors.redAccent,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: routineNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Gib deiner Routine einen Namen'
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextField(
                      controller: routineSizeController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Wie viele Übungen soll deine Routine enthalten'
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    OutlineButton(
                      color: Colors.grey,
                        splashColor: Colors.grey,
                        onPressed: () {
                          widget._createRoutine(context, routineNameController.text, routineSizeController.text);
                        },
                      child: Center(
                        child: Text('Speichern'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'FiraSansExtraCondensed',
                          fontSize: 18.0,
                          color: Colors.white
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}