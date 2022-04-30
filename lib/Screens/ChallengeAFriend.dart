import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../Utilities/player.dart';
import 'CreateARoom.dart';
import 'JoinARoom.dart';

class ChallengeAFriend extends StatelessWidget {
  final String subject;
  final Player player;
  const ChallengeAFriend({
    Key? key,
    required this.subject,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Color blue = Color.fromARGB(255, 13, 77, 174);
    const _profileRadius = 35.0;
    const _iconSize = 40.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Flexible(
            child: Container(
              width: _width,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    blue,
                    const Color.fromARGB(255, 159, 31, 31),
                  ],
                ),
              ),
              child: Row(children: [
                Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.transparent,
                      child: player.avatar,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 30,
                    color: Colors.transparent,
                    child: ClipRRect(
                        //used to make circular borders
                        borderRadius: BorderRadius.circular(15),
                        child: Center(
                            child: Text(
                          player.username,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )))),
              ]),
            ),
            flex: 20),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.white,
            )),
        Flexible(
            child: Container(
              width: _width - 20,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 30,
                    lightSource: LightSource.bottom,
                    color: Color.fromARGB(255, 232, 229, 229)),
                child: const Center(
                    child: Text(
                  "Challenge A Friend",
                  style: TextStyle(fontSize: 26, color: Colors.black),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
            flex: 10),
        Flexible(
            flex: 5,
            child: Container(
              color: Colors.white,
            )),
        Flexible(
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: Color.fromARGB(255, 125, 125, 125),
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CreateARoom(
                                  player: player,
                                  subject: subject,
                                ))),
                    child: const FittedBox(
                        child: Text(
                          "Create Room",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        fit: BoxFit.fill),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 13, 77, 174),
                    )),
                  )),
              height: 75,
              width: _width / 2 + 60,
            ),
            flex: 30),
        Flexible(
          child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: Color.fromARGB(255, 125, 125, 125),
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => JoinARoom(
                                  player: player,
                                  subject: subject,
                                ))),
                    child: const FittedBox(
                        child: Text(
                          "Join a Room",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        fit: BoxFit.fill),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 13, 77, 174),
                    )),
                  )),
              height: 75,
              width: _width / 2 + 60,
              margin: const EdgeInsets.all(30)),
          flex: 30,
        )
      ]),
    );
  }
}
