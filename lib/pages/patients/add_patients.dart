import 'package:flutter/material.dart';
import 'package:medizda/constants.dart';

class AddPatientButton extends StatelessWidget {
  const AddPatientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(builder: (context) {
          return const _AddTodoPopupCard();
        }));
      },
      child: Hero(
        tag: _heroAddPatient,
        child: Material(
          type: MaterialType.button,
          color: primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Container(
            width: 196,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(32)),
            child: const ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(Icons.add, color: backgroundColor),
              title: Text('ADD PATIENT'),
              mouseCursor: MaterialStateMouseCursor.clickable,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroAddPatient = 'add-patient-hero';

class _AddTodoPopupCard extends StatelessWidget {
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: Hero(
          tag: _heroAddPatient,
          child: Material(
            color: primaryColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              label: Text('Name'),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              label: Text('Surname'),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              label: Text('Pesel'),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    SizedBox(
                      width: 128,
                      height: 32,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('A D D',
                            style: TextStyle(color: Colors.black)),
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

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
